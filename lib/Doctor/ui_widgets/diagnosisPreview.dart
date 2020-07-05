import 'package:allo_doctor/Doctor/DoctorScreens/diagnosis.dart';
import 'package:flutter/material.dart';

Widget diagnosisPreview(BuildContext context){
  return  Container(
     // margin: EdgeInsets.symmetric(horizontal:20,vertical:5),
      padding: EdgeInsets.only(top:20,bottom:5,right:25,left:10),
      decoration: BoxDecoration(
      //border: Border(bottom:BorderSide(style: BorderStyle.solid,color:Colors.black)),
        borderRadius: BorderRadius.circular(15),
        color:Colors.grey[200]
      ),
      child: Column( 
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
            Text(": " "تشخيص يتبع تخصص",style: TextStyle(fontSize:13,color:Colors.black),),
            Text('')
           ]),
           Row(
             textDirection: TextDirection.rtl,
           children:[
            Text(' : تاريخ التشخيص',style: TextStyle(fontSize:13,color:Colors.black),),
            Text('')
           ]),
           Container(
             alignment: Alignment.topLeft,
             child: RaisedButton(
               onPressed:(){
                   Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Diagnosis()));
              },
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