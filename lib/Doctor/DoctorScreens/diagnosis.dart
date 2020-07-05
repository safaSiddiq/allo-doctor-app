import 'package:flutter/material.dart';

class Diagnosis extends StatefulWidget {
  @override
  _DiagnosisState createState() => _DiagnosisState();
}

class _DiagnosisState extends State<Diagnosis> {
  bool isOnline = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
       
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: <Widget>[
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
                                  isOnline
                                ? Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(bottom: 5),
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
            ],
              ),),
        ],
      ),   
      body: Container(
        
        margin: EdgeInsets.symmetric(horizontal:20),
        child: 
       ListView(     
        children: <Widget>[
          Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text(  ": " 'تشخيص الطبيب',style: TextStyle(color:Colors.white),),
              SizedBox(width:5),
              Text('')
            ],
          ),
           Row(
             textDirection: TextDirection.rtl,
            children: <Widget>[
              Text(": "'تشخيص يتبع',style: TextStyle(color:Colors.white),),
              SizedBox(width:5),
              Text('')
            ],
          ),
         Container(
           margin: EdgeInsets.only(right:120),
           child:
          Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text(": "'تاريخ التشخيص',style: TextStyle(color:Colors.white),),
              SizedBox(width:5),
              Text('')
            ],
          )),
          SizedBox(height:5),
          Container(
            padding: EdgeInsets.symmetric(horizontal:10,vertical:10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text(' :استعلام نوع '),
                SizedBox(width:10),
                  Container(
                  padding: EdgeInsets.symmetric(horizontal:25,vertical:8),
                  decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.teal,),
                  child: Text('زيارة طبية',style: TextStyle(color: Colors.white),)) 
              ],
            ),
          ),
          SizedBox(height:10),
          SizedBox(height:15),
         tilteWidget('الاستعلام'),
         infoContainer(),
          SizedBox(height:15),
         tilteWidget("التشخيص"),
         infoContainer(),
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
         infoContainer(),
         SizedBox(height:15)
        ],
      ),   
    ));
  }
}

Widget tilteWidget(String title){
  return  Container(
    
            padding: EdgeInsets.only(right: 15),
            child:
            Text(title,textDirection: TextDirection.rtl,
            style:TextStyle(color: Colors.white,fontSize:18))
          );
}

Widget infoContainer(){
  return  Container(
          height: 150,
            padding: EdgeInsets.symmetric(horizontal:15,vertical:10),
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white
            ),
            child: Text('',textDirection: TextDirection.rtl,style: TextStyle(fontSize:14,color:Colors.black),)
            );
}



Widget medicineContainer(){
  return  Container(
          
          //height: 150,
            padding: EdgeInsets.symmetric(horizontal:15,vertical:10),
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(8),
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
Widget testContainer(){
  return Container(
     margin: EdgeInsets.symmetric(horizontal:10,vertical:10),
     
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

Widget raysContainer(){
  return Container(
     margin: EdgeInsets.symmetric(horizontal:10,vertical:10),
     
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