

import 'package:allo_doctor/patient/ui_widgets/diagnosisPreview.dart';
import 'package:flutter/material.dart';

class DiagnosisesScreen extends StatefulWidget {
  @override
  _DiagnosisesScreenState createState() => _DiagnosisesScreenState();
}

class _DiagnosisesScreenState extends State<DiagnosisesScreen> {

   final mainColor=  LinearGradient(
          begin: FractionalOffset.topRight,
           // end: FractionalOffset.bottomCenter,
          stops: [0.0, 1.0,],
          colors: [
            Color(0xFF87C9BF),
            Color(0xFF2B95AF)
          ],
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: mainColor
      ),
    child:
    Scaffold(
      backgroundColor: Color(0xFF00000),
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Color(0xFF0000),
        actions: <Widget>[
             Container( 
             margin: EdgeInsets.symmetric(horizontal:5,vertical:20),
             child: Text('التشخيصات',textDirection: TextDirection.rtl,style: TextStyle(fontSize:18),)), 
         SizedBox(width:5),
          Container(
        
            padding: EdgeInsets.only(right:5,top:5,bottom:5),
             child: CircleAvatar(
                            radius: 21,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                                child: SizedBox(
                                    width: 40.0,
                                    height: 40.0,
                                    child: Image.asset('assets/Patient.png',
                                        fit: BoxFit.fill)))))
       
        ],
        ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal:20,vertical:5),
        decoration: BoxDecoration( 
          color:Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: ListView(
          children: <Widget>[
           diagnosisPreview(context, Colors.grey[300]),

          ],
        ),
      ),
      
     ) );
  }
}




