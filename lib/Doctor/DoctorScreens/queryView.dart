import 'package:allo_doctor/Doctor/DoctorScreens/chatScreen.dart';
import 'package:allo_doctor/Doctor/DoctorScreens/writeQuery.dart';
import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/models/query.dart';
import 'package:flutter/material.dart';

class QueryView extends StatefulWidget {
  @override
  _QueryViewState createState() => _QueryViewState();
}

class _QueryViewState extends State<QueryView> {
  Doctor doctor;
  Patient patient;
  Query query;
  bool isOnline = true;


    Patient get _patient{
    if (patient == null ){
      patient = Patient();
    }
  return  
  _patient;
  }


  @override
//   void initState(){
//     _isDisabled = false;
// } 
//   void disabledButton(){
//     _isDisabled = true;
//   }



 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: <Widget>[
           Container(
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
                                    child: //doctor.avatar==null? 
                                    Image.asset('assets/Doctor.png',
                                        fit: BoxFit.fill)))),
                                        //:NetworkImage(doctor.avatar)))),
                                           isOnline  ? Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(bottom:5,right:2),
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
            )
          : Container(),
            ]),
             )
        ],
      ),
      body: Container(
       margin: EdgeInsets.symmetric(horizontal:20),
      child:
      ListView(
        children: <Widget>[
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
                                    child: //patient.avatar==null?
                                    
                                    Image.asset('assets/Patient.png',
                                        fit: BoxFit.fill)))),
                                     ///  : NetworkImage(patient.avatar)))),
                                           isOnline  ? Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(top: 40,right:2),
              child: Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
            )
          : Container(),
            ]),
             ),
             Column(
               children: <Widget>[
                 SizedBox(height:22),
                _textRow(": " "استعلام من المريض"),
                _textRow(_patient.firstName + _patient.lastName),
                Container(
                  margin: EdgeInsets.only(right:65),
                  child: Row(
                    children: <Widget>[
                   _textRow( ": " "تاريخ الاستعلام "),
                   _textRow(query.queryDate)

                    ],
                  )
                ),
               ],
             )            
            ],
          ),
          SizedBox(height:20),
          Text('data',textDirection: TextDirection.rtl,style: TextStyle(fontSize:18,color:Colors.white),),
          SizedBox(height:10),
          Container(
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
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Text("",style: TextStyle(color:Colors.white,fontSize:14),),
                    )
                  ],
                ),
                SizedBox(height:15),
                Container(
                  padding: EdgeInsets.only(right:5),
                 alignment: Alignment.topRight, 
                child:
                Text(":" 'الاستعلام',
                style: TextStyle(color:Colors.teal,fontSize:14),)),
                Text(query.queryData,style: TextStyle(
                  color:Colors.black,
                  fontSize: 14,
                ),
                maxLines: 80,),
              //  SizedBox(height:150),
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
    );
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
        //padding: EdgeInsets.symmetric(horizontal: 60.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WriteQuery()));
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

