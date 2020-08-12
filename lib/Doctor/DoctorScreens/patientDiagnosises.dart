import 'package:allo_doctor/Doctor/ui_widgets/diagnosisPreview.dart';
import 'package:flutter/material.dart';

class PatientDiagnosises extends StatefulWidget {
  @override
  _PatientDiagnosisesState createState() => _PatientDiagnosisesState();
}

class _PatientDiagnosisesState extends State<PatientDiagnosises> {
final mainColor = LinearGradient(
    begin: FractionalOffset.bottomCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );
  @override
  Widget build(BuildContext context) {
   return Container(
     decoration: BoxDecoration(
       gradient: mainColor
     ),
   child:
    Scaffold(
      backgroundColor: Color(0xff00000),
      appBar:  PreferredSize(
            preferredSize: Size(double.infinity, 105), 
            child:  AppBar(
        backgroundColor: Color(0xff0000),
        elevation: 0,
       
        actions: <Widget>[
           Row(
             children: <Widget>[
                Text("تشخيصات المريض",style: TextStyle(fontSize:20),),
                SizedBox(width:15),
            Container(
            padding: EdgeInsets.only(right:5,top:5,bottom:5),
         child:  Stack(
                textDirection: TextDirection.rtl,
                children: <Widget>[ 
              CircleAvatar(
                  radius: 21,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                      child: SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child: Image.asset('assets/Doctor.png',
                              fit: BoxFit.fill)))),
                                  
            ],
              ),),
            
        ],
           )
        ],
        bottom: PreferredSize(
            preferredSize: Size(double.infinity, 95), 
            child:Container(
              margin: EdgeInsets.symmetric(vertical:10),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text("محمد عبدالله",style:TextStyle(color: Colors.white,fontSize:12)),
                SizedBox(width:15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal:18,vertical:10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.deepOrangeAccent
                  ),
                  child: Text("الملف الطبي",style:TextStyle(color: Colors.white,fontSize: 12)),
                ),
               
              ],
            ),
        )))),
      body:Container(
        padding: EdgeInsets.symmetric(vertical:10,horizontal:15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
        ),
        child:  ListView(          
        children: <Widget>[
          diagnosisPreview(context),
          SizedBox(height:10),
          diagnosisPreview(context),
          
        ],
      )),
    ));
  }
}