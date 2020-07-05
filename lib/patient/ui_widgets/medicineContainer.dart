import 'package:flutter/material.dart';

Widget medicineContainer(){
  return  Container(
          
          //height: 150,
            padding: EdgeInsets.symmetric(horizontal:15,vertical:10),
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white
            ),
            child:Column(
              children: <Widget>[
             Row(
               textDirection: TextDirection.rtl,
              children: <Widget>[
                Text('اسم الدواء'' :',textDirection:TextDirection.rtl,style: TextStyle(color:Colors.grey[700],fontSize:13),)
              ],
            ),
             Row(
               textDirection: TextDirection.rtl,
              children: <Widget>[
                Text('الجرعة' " :",textDirection:TextDirection.rtl,style: TextStyle(color:Colors.grey[700],fontSize:13),)
              ],
            ),
             Row(
               textDirection: TextDirection.rtl,
              children: <Widget>[
                Text('مدة الإستخدام'' :',textDirection:TextDirection.rtl,style: TextStyle(color:Colors.grey[700],fontSize:13),)
              ],
            ),
             Row(
               textDirection: TextDirection.rtl,
              children: <Widget>[
                Text('ملاحظات'' :',textDirection:TextDirection.rtl,style: TextStyle(color:Colors.grey[700],fontSize:13),)
              ],
            ),
             ],
            )
            );
}