import 'package:allo_doctor/patient/ui_widgets/medicineContainer.dart';
import 'package:allo_doctor/patient/ui_widgets/raysContainer.dart';
import 'package:allo_doctor/patient/ui_widgets/testContainer.dart';
import 'package:flutter/material.dart';

class DiagnosisViewScreen extends StatefulWidget {
  @override
  _DiagnosisViewScreenState createState() => _DiagnosisViewScreenState();
}

class _DiagnosisViewScreenState extends State<DiagnosisViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
         centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.teal,
        actions: <Widget>[
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
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal:20,vertical:10),
        children: <Widget>[
          Container(
            child:Row(
              textDirection: TextDirection.rtl,
              children:
              [Text(' : تشخيص طبيب',style: TextStyle(fontSize:12,color:Colors.white),)])
          ),
           Container(
            child:Row(
              textDirection: TextDirection.rtl,
              children:
              [Text(' : طبيب مختص',style: TextStyle(fontSize:12,color:Colors.white))])
          ),
           Container(
             padding: EdgeInsets.only(right:150),
            child:Row(
              textDirection: TextDirection.rtl,
              children:
              [Text(' : تاريخ التشخيص',style: TextStyle(fontSize:12,color:Colors.white))])
          ),
          SizedBox(height:10),
          Container(
            padding: EdgeInsets.symmetric(horizontal:15,vertical:10),
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text(' استعلام من نوع'),
                SizedBox(width:10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal:35,vertical:8),
                  decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blue,),
                  child: Text('زيارة طبية') ,
                )
              ],
            ),
          ),
         SizedBox(height:15),
         tilteWidget('استعلامات'),
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

        ],
      ),
    );
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
              borderRadius: BorderRadius.circular(20),
              color: Colors.white
            ),
            child: Text('',textDirection: TextDirection.rtl,style: TextStyle(fontSize:14,color:Colors.black),)
            );
}



