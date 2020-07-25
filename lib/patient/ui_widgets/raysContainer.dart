import 'package:flutter/material.dart';

Widget raysContainer(){
  return Container(
     margin: EdgeInsets.symmetric(vertical:10),
     
            decoration:BoxDecoration(
              //borderRadius: BorderRadius.circular(20),
              color: Colors.white
            ),
    child: Table( 
      textDirection: TextDirection.rtl,
      border: TableBorder.all(width:2,color:Colors.teal),
      children: [
        TableRow(
          children: [
            TableCell(
              child:   Container(
                    padding: EdgeInsets.symmetric(vertical:10),
                    child:Text('نوع الصورة',textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color:Colors.grey[700],fontSize:15))),
            ),
             TableCell(
              child:   Container(
                    padding: EdgeInsets.symmetric(vertical:10),  
                 child:Text('تصوير',textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color:Colors.grey[700],fontSize:15))),
              ) ,
            TableCell(
              child:   Container(
                    padding: EdgeInsets.symmetric(vertical:10),
                  
                 child:Text('ملاحظات',textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color:Colors.grey[700],fontSize:15))),
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
              ) ,
              TableCell(
              child:   Container(
                    padding: EdgeInsets.symmetric(vertical:10),
                    child:Text('',textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color:Colors.grey[700],fontSize:15))),
            ),
          ]
        ),
        
      ],
    ),
  );
}