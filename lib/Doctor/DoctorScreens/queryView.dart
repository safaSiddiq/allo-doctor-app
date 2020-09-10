import 'dart:io';

import 'package:allo_doctor/Doctor/DoctorScreens/chatScreen.dart';
import 'package:allo_doctor/Doctor/DoctorScreens/writeQuery.dart';
import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/models/query.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QueryView extends StatefulWidget {
  final MainModel model;
  final Query query;
 QueryView(this.model,this.query);
  @override
  _QueryViewState createState() => _QueryViewState();
}

class _QueryViewState extends State<QueryView> {
  bool isOnline = true;
  Future<Patient>_patient;
  Future<Doctor> _doctor;
  MainModel model;

final mainColor = LinearGradient(
    begin: FractionalOffset.bottomCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );

   
  //   void initState(){
//     _isDisabled = false;
// } 
//   void disabledButton(){
//     _isDisabled = true;
//   }

Future<Patient> getPatient() async {
    var id = widget.query.patientId.toString();
    print(id);
    http.Response response = await http.get(
      //  "http://192.168.1.36:3000/patients/$_patientId",
      "http://34.71.92.1:3000/patients/$id",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
    print("response stuse get patient info :${response.statusCode}");
    print("response body :${response.body}");
    var _patientData = json.decode(response.body);
    var _newPatient = Patient(
      //  patientId: _patientId,
      patientId: _patientData['patientId'],
      firstName: _patientData['firstName'],
      lastName: _patientData['lastName'],
      birthdate: _patientData["birthdate"],
      gender: _patientData["gender"],
      avatar: _patientData["avatar"],
      email: _patientData["email"],
    );
    // _patient = _newPatient;
    return _newPatient;
    // return Patient.fromJson(json.decode(response.body));
  }




 Future<Doctor> getDoctor() async {
   var id=widget.query.doctorId;
   http.Response response = await http.get(
    //  "http://192.168.1.36:3000/patients/$_patientId",
     "http://34.71.92.1:3000/doctors/$id",//1fef50ee-7c82-4a6e-9de5-db5a1ed0ec07

      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
      print("response stuse get info dr :${response.statusCode}");
      print("response body :${response.body}");
   
     var _doctorData = json.decode(response.body);
  var  _newDoctor =Doctor(
        doctorId: _doctorData['doctorId'],
        firstName: _doctorData['firstName'],
        lastName: _doctorData['lastName'],
        birthdate: _doctorData["birthdate"],
        gender: _doctorData["gender"],
        major: _doctorData["major"],
        avatar: _doctorData["avatar"],
        bio: _doctorData["bio"],
        email: _doctorData["email"],
      );
     // _doctor = _newDoctor;
       return  _newDoctor;
     // return Patient.fromJson(json.decode(response.body));
  }


  @override
  void initState() {
  getDoctor().then((_){
    setState(() {
      _doctor = getDoctor();
    });
  });
  getPatient().then((_) {
      setState(() {
        _patient = getPatient();
      });
    });
    

    super.initState();
  }



  




 Widget build(BuildContext context) {
    return Container(
     decoration: BoxDecoration(gradient: mainColor),
      child:
    Scaffold(
      backgroundColor: Color(0xff00000),
      appBar: AppBar(
        backgroundColor: Color(0xff0000),
        elevation: 0,
        actions: <Widget>[
          FutureBuilder(
            future: _doctor,
            builder: (context,snapShot){
            if(snapShot.hasData){
              return Container(
               margin: EdgeInsets.only(top:8),
                        child:Stack(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                         CircleAvatar(
                            radius: 21,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                                child: SizedBox(
                                    width: 40.0,
                                    height: 40.0,
                                    child: snapShot.data.avatar=="null"? 
                                    Image.asset('assets/Doctor.png',
                                        fit: BoxFit.fill)
                                        :Image.network(snapShot.data.avatar)))),
               
            ]),
             );
             }else{
               return  Center(
                        child: SpinKitFadingCircle(
                      color: Color(0xFF87C9BF),           
                      size: 35,
                    ));
             }
          })
        ],
      ),
      body: Container(
       margin: EdgeInsets.symmetric(horizontal:20),
      child:
      ListView(
        children: <Widget>[
         FutureBuilder(
           future: _patient,
           builder: (context,snapShot){
             if(snapShot.hasData){
               return
            
          Row(
            textDirection: TextDirection.rtl
            ,
            children: <Widget>[
              Container(
               margin: EdgeInsets.only(top:20,right:45),
                        child:Stack(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                         CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                                child: SizedBox(
                                    width: 54.0,
                                    height: 54.0,
                                    child: snapShot.data.avatar==""?                                   
                                    Image.asset('assets/Patient.png',
                                        fit: BoxFit.fill)
                                       : Image.file(File(  snapShot.data.avatar))))),
                                          
            ]),
             ),
             Column(
               children: <Widget>[
                 SizedBox(height:22),
                _textRow(": " "استعلام من المريض"),
                _textRow(snapShot.data.firstName +" "+ snapShot.data.lastName),
                Container(
                  margin: EdgeInsets.only(right:10),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                   _textRow( ": " "تاريخ الاستعلام"),            
                  _textRow(widget.query.queryDate.substring(0, 10))

                    ],
                  )
                ),
               ],
             )            
            ],
          );
           }else{
             return  Center(
                        child: SpinKitFadingCircle(
                      color: Color(0xFF87C9BF),           
                      size: 35,
                    ));
           }
         }),
          SizedBox(height:20),
          Text('الاستعلام',textDirection: TextDirection.rtl,style: TextStyle(fontSize:18,color:Colors.white),),
          SizedBox(height:10),
          Container( 
           
            height: 180,
            margin: EdgeInsets.only(bottom:10),    
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white
            ),
            child:Container(
              padding: EdgeInsets.symmetric(horizontal:5,vertical:10),
              child:   
             Column(

              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[         
                Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Text( ": "'نوع الاستعلام ',style: TextStyle(color:Colors.black,fontSize:14)),
                    SizedBox(width:10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal:10,vertical:6),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: widget.query.queryType==null?
                      Text("زيارة طبية",style: TextStyle(color:Colors.white,fontSize:14),):
                      Text("",style: TextStyle(color:Colors.white,fontSize:14),)
                    )
                  ],
                ),
                SizedBox(height:15),
                Container(
                  padding: EdgeInsets.only(right:5,bottom:5),
                 alignment: Alignment.topRight, 
                child:
                Text(":" 'الاستعلام',
                style: TextStyle(color:Colors.teal,fontSize:14),)),
               Text( widget.query.queryData 
                ,style: TextStyle(
                  color:Colors.black,
                  fontSize: 15,
                ),               
                maxLines: 80,),
              ],
            ),
          )),
          SizedBox(height:20),
          Container(
            padding: EdgeInsets.symmetric(horizontal:30),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
           textDirection: TextDirection.rtl,
            children: <Widget>[
                buttons(),
                RawMaterialButton(onPressed: (){
                   Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DrChatScreen()));
                },
                child: Text("بدء محادثة",style:TextStyle(color:Colors.white,fontSize:18)),)
            ],
          ))
        ],        
      ),
      )
    ));
  }
  Widget buttons(){
  return 
       Container(
      width: 120,
      height: 40.0,     
      child:
    RaisedButton(
        color: Colors.deepOrangeAccent,
        textColor: Colors.white,
        child: Text(
          'تشخيص',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WriteQuery(model,widget.query)));
        })
  );
}
}

Widget _textRow(String text){
  return Row(
    children: <Widget>[
       Text(text,
       textAlign: TextAlign.right,
       style: TextStyle(color:Colors.white,fontSize: 14),),
              SizedBox(width:5),
              Text('',style: TextStyle(color:Colors.white,fontSize: 12),)
    ],
  );
}

 

