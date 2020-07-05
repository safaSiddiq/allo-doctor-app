import 'package:allo_doctor/Doctor/DoctorScreens/chatScreen.dart';
import 'package:allo_doctor/Doctor/DoctorScreens/patientDiagnosises.dart';
import 'package:allo_doctor/Doctor/DoctorScreens/patientMidicalFile.dart';
import 'package:flutter/material.dart';

Widget patientCard(BuildContext context,bool isOnline) {
  return 
  Directionality(
    textDirection: TextDirection.rtl,
    child: Card(
      color: Colors.white,
        //key: ValueKey(record.name),
        elevation: 0.0,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
        child: Container(
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: ListTile(
            contentPadding: EdgeInsets.only(top: 5, bottom: 10, right: 5),
            leading:
                 Container(
                     width: 65,
                   height: 65,
              
                padding: EdgeInsets.only(
                  right: 10.0,
                ),
                child: Stack(
                  children: <Widget>[
                     CircleAvatar(
                            radius: 41,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                                child: SizedBox(
                                    width: 70.0,
                                    height: 70.0,
                                    child: Image.asset('assets/Patient.png',
                                        fit: BoxFit.fill)))),
                isOnline  ? Container(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
            )
          : Container(),
                  ],
                )),
                
              
            title: Text(
              'محمد خالد',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         textDirection: TextDirection.rtl,
                         children: <Widget>[
                           Text("العمر"" :",style: TextStyle(color:Colors.teal,fontWeight: FontWeight.bold),),
                           SizedBox(width:4),
                           Text("50 عام")

                         ],
                       ),
                       SizedBox(height:4),
                        Row(
                          textDirection: TextDirection.rtl,
                         children: <Widget>[
                           Text("الجنس"" :",style: TextStyle(color:Colors.teal,fontWeight: FontWeight.bold),),
                           SizedBox(width:4),
                           Text("ذكر")
                         ],
                       ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        
                        Container(
                            height: 25,
                            width: 80,
                            child: RaisedButton(
                                color: Colors.deepOrangeAccent,
                                child: Text(
                                  'التشخيصات',
                                  style: TextStyle(
                                      fontSize: 9, color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                onPressed: () {
                                   Navigator.of( context).push(
              MaterialPageRoute(builder: (context) => PatientDiagnosises()));
                                })),
                         SizedBox(width:4),
                        Container(
                            height: 25,
                            width: 70,
                            child: RaisedButton(
                                color: Colors.deepOrangeAccent,
                                child: Text(
                                  'ملف طبي',
                                  style: TextStyle(
                                      fontSize: 9, color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                onPressed: () {
                                   Navigator.of( context).push(
              MaterialPageRoute(builder: (context) => PatientMidicalFile()));
                                })),
                                SizedBox(width:4),
                                  Container(
                            height: 25,
                            width: 80,
                            child: RaisedButton(
                                color: Colors.deepOrangeAccent,
                                child: Text(
                                  'بدء المحادثة',
                                  style: TextStyle(
                                      fontSize: 9, color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DrChatScreen())); 
                                })),
                      ])
                    ]))
              ],
            ),
          ),
        )),
  
  );
}
