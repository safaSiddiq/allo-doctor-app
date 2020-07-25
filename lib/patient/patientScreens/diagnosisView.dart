import 'dart:ui';

import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/models/query.dart';
import 'package:allo_doctor/patient/ui_widgets/medicineContainer.dart';
import 'package:allo_doctor/patient/ui_widgets/raysContainer.dart';
import 'package:allo_doctor/patient/ui_widgets/testContainer.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';



class DiagnosisViewScreen extends StatefulWidget {
  final MainModel model;
  final Query query;
  DiagnosisViewScreen(this.model,this.query);
  @override
  _DiagnosisViewScreenState createState() => _DiagnosisViewScreenState();
}

class _DiagnosisViewScreenState extends State<DiagnosisViewScreen> {

   final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );
  Future<Doctor> _doctor ;

   Future<Doctor> getDoctor(String id) async {  
   http.Response response = await http.get(
   "http://34.71.92.1:3000/doctors/$id",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
      print("response stuse get info dr :${response.statusCode}");
      print("response body :${response.body}");
   
     var _doctorData = json.decode(response.body);
  var  _newDoctor =Doctor(
      //  patientId: _patientId,
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
    return  _newDoctor;
     // return Patient.fromJson(json.decode(response.body));
  }

Future<Patient> getPatient() async {
  var pId = widget.query.patientId;
   http.Response response = await http.get(
    //  "http://192.168.1.36:3000/patients/$_patientId",
        "http://34.71.92.1:3000/patients/$pId",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
     var _patientData = json.decode(response.body);
  var  _newPatient =Patient(
      //  patientId: _patientId,
        patientId: _patientData['patientId'],
        firstName: _patientData['firstName'],
        lastName: _patientData['lastName'],
        birthdate: _patientData["birthdate"],
        gender: _patientData["gender"],
        avatar: _patientData["avatar"],
        email: _patientData["email"],
      );
       return  _newPatient;

  
  }



  @override
  void initState() {
   var id = widget.query.doctorId;
  getDoctor(id).then((_){
    setState(() {
      _doctor = getDoctor(id);
    });
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
    Container(
        decoration: BoxDecoration(
          gradient: mainColor
        ),
    child:
    Scaffold(
      backgroundColor: Color(0xff00000),
      appBar: AppBar(
         centerTitle: false,
        elevation: 0,
        backgroundColor: Color(0xff0000),
        actions: <Widget>[
          FutureBuilder(
            future: getPatient(),
            builder: (context , snapShot){
            if(snapShot.hasData){
              return 
          
            Container(
            padding: EdgeInsets.only(right:5,top:5,bottom:5),
            child: CircleAvatar(
                            radius: 19,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                                child: SizedBox(
                                    width: 36.0,
                                    height: 36.0,
                                    child: snapShot.data.avatar ==""?
                                    Image.asset('assets/Patient.png',
                                        fit: BoxFit.fill):
                                        Image.network(snapShot.data.avatar)
                                        ))));
                                          }else{
                  return Center(
                              child: SpinKitFadingCircle(
                            color: Color(0xFF87C9BF),
                            size: 12,
                          ));
              }
          })
       
        ],
      ),
      body: FutureBuilder(
        future:_doctor,
        builder: (context,snapShot){
        if(snapShot.hasData){
          return
        
      ListView(
        
        padding: EdgeInsets.symmetric(horizontal:20,vertical:10),
        children: <Widget>[
          Container(
            child:Row(
              textDirection: TextDirection.rtl,
              children:
              [Text( 'تشخيص طبيب : ' + snapShot.data.firstName + " "+ snapShot.data.lastName,textDirection: TextDirection.rtl,style: TextStyle(fontSize:12,color:Colors.white),)])
          ),
           Container(
            child:Row(
              textDirection: TextDirection.rtl,
              children:
              [Text(' طبيب مختص : ' + snapShot.data.major,textDirection: TextDirection.rtl,style: TextStyle(fontSize:12,color:Colors.white))])
          ),
           Container(
             padding: EdgeInsets.only(right:150),
            child:Row(
              textDirection: TextDirection.rtl,
              children:
              [Text(' تاريخ التشخيص : ' + widget.query.queryDate.substring(0,10),textDirection: TextDirection.rtl,style: TextStyle(fontSize:12,color:Colors.white))])
          ),
          SizedBox(height:10),
          Container(
            padding: EdgeInsets.symmetric(horizontal:15,vertical:10),
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text(' استعلام من نوع'),
                SizedBox(width:15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal:25,vertical:8),
                  decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:  Color(0xFF2B95AF),),
                  child: Text('زيارة طبية') ,
                )
              ],
            ),
          ),
         SizedBox(height:15),
         tilteWidget('استعلامات'),
         infoContainer(widget.query.queryData.toString()),
          SizedBox(height:15),
         tilteWidget("التشخيص"),
         infoContainer(widget.query.queryResult.toString()),
          SizedBox(height:15),
         tilteWidget("الأدوية المطلوبة"),
        medicineContainer(),
         SizedBox(height:15),
         tilteWidget("التحاليل المطلوبة"),
         testContainer(),
          SizedBox(height:15),
         tilteWidget("صور الأشعة"),
         raysContainer(),
        SizedBox(height:15),
         tilteWidget("العمليات "),
         infoContainer(""),

        ],
      );
      }else{
                  return Center(
                              child: SpinKitFadingCircle(
                            color: Color(0xFF87C9BF),
                            size: 20,
                          ));
              }
      })
    ));
  }


Widget tilteWidget(String title){
  return  Container(
    
            padding: EdgeInsets.only(right: 15),
            child:
            Text(title,textDirection: TextDirection.rtl,
            style:TextStyle(color: Colors.white,fontSize:18))
          );
}

Widget infoContainer( String data){
  return  Container(
          height: 150,
            padding: EdgeInsets.symmetric(horizontal:15,vertical:10),
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white
            ),
            child: Text(data,textDirection: TextDirection.rtl,style: TextStyle(fontSize:14,color:Colors.black),)
            );
}



}