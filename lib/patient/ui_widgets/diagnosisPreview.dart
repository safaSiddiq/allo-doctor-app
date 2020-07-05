import 'package:allo_doctor/patient/patientScreens/diagnosisView.dart';
import 'package:flutter/material.dart';

Widget diagnosisPreview(BuildContext context, Color color){
    return Container(
     // margin: EdgeInsets.symmetric(horizontal:20,vertical:5),
      padding: EdgeInsets.only(top:20,bottom:5,right:25,left:10),
      decoration: BoxDecoration(
     // border: Border(bottom:BorderSide(style: BorderStyle.solid,color:Colors.black)),
        borderRadius: BorderRadius.circular(15),
        color:color
      ),
      child:
       Column( 
      mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         Row(
           textDirection: TextDirection.rtl,
           children:[
            Text(" : تشخيص طبيب",style: TextStyle(fontSize:13,color:Colors.black),),
            Text('')
           ]),
           Row(
             textDirection: TextDirection.rtl,
           children:[
            Text(": طبيب مختص   ",style: TextStyle(fontSize:13,color:Colors.black),),
            Text('')
           ]),
           Row(
             textDirection: TextDirection.rtl,
           children:[
            Text('  : تاريخ التشخيص',style: TextStyle(fontSize:13,color:Colors.black),),
            Text('')
           ]),
           Container(
             alignment: Alignment.topLeft,
             child: RaisedButton(
               onPressed:(){ Navigator.of( context).push(
              MaterialPageRoute(builder: (context) => DiagnosisViewScreen()));},
             color: Colors.teal[200],
             shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
             child: Text('عرض التشخيص',style: TextStyle(color:Colors.white,fontSize:11),),
             ),
           ),
           Divider(thickness: 1,color: Colors.teal,),
        ],
      ),
    );
}