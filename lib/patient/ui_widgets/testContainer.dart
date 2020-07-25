import 'package:flutter/material.dart';

Widget testContainer(){
  return Container(
     margin: EdgeInsets.symmetric(vertical:10),
     
            decoration:BoxDecoration(
              //borderRadius: BorderRadius.circular(20),
              color: Colors.white
            ),
    child: Table( 
      border: TableBorder.all(width:2,color:Colors.teal),
      children: [
        TableRow(
          children: [
            TableCell(
              child:   Container(
                    padding: EdgeInsets.symmetric(vertical:10),
                    child:Text('موعد التحليل',textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color:Colors.grey[700],fontSize:15))),
            ),
             TableCell(
              child:   Container(
                    padding: EdgeInsets.symmetric(vertical:10),
                  
                 child:Text('اسم التحليل',textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color:Colors.grey[700],fontSize:15))),
              ) ]
        ),
        TableRow(
          children: [
            TableCell(
              child:   Container(
                    padding: EdgeInsets.symmetric(vertical:10),
                    child:Text('',textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color:Colors.grey[700],fontSize:15))),
            ),
             TableCell(
              child:   Container(
                    padding: EdgeInsets.symmetric(vertical:10),
                  
                 child:Text(' ',textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color:Colors.grey[700],fontSize:15))),
              ) 
          ]
        ),
         TableRow(
          children: [
            TableCell(
              child:   Container(
                    padding: EdgeInsets.symmetric(vertical:10),
                    child:Text('',textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color:Colors.grey[700],fontSize:15))),
            ),
             TableCell(
              child:   Container(
                    padding: EdgeInsets.symmetric(vertical:10),
                  
                 child:Text(' ',textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color:Colors.grey[700],fontSize:15))),
              ) 
          ]
        ),
      ],
    ),
  );
}