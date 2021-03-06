import 'dart:io';

import 'package:allo_doctor/Doctor/DoctorScreens/chatScreen.dart';
import 'package:allo_doctor/Doctor/DoctorScreens/patientDiagnosises.dart';
import 'package:allo_doctor/Doctor/DoctorScreens/patientMidicalFile.dart';
import 'package:allo_doctor/models/configSize.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';

int calculateAge(DateTime birthDate) {

  
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}

Widget patientCard(BuildContext context, Patient _patient) {

   MainModel model ;
   SizeConfig().init(context);
   
  var date = DateTime.parse(_patient.birthdate.substring(0, 10));
  var age = calculateAge(date);
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Card(
        color: Colors.white,
        //key: ValueKey(record.name),
        elevation: 0.0,
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
        child: Container(
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: ListTile(
            contentPadding: EdgeInsets.only(top: 2, bottom: 10, right: 5),
            leading: Container(
             width: SizeConfig.blockSizeHorizontal * 20.0,
             height:  SizeConfig.blockSizeVertical * 30.0,
          // height: 75,
          // width: 75,
              padding: EdgeInsets.only(
                right: 5.0,
              ),
              child:
                  CircleAvatar(
                     radius: 41,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                          child: SizedBox(
                               width: SizeConfig.blockSizeHorizontal * 20.0,
             height:  SizeConfig.blockSizeVertical * 30.0,
                              child: _patient.avatar == ""
                                  ? Image.asset('assets/Patient.png',
                                      fit: BoxFit.fill)
                                  : Image.file(File(_patient.avatar))))),
            ),
            title: Text(
              _patient.firstName + " " + _patient.lastName,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle:Container(
              // width:h, SizeConfig.blockSizeHorizontal * 60.0,
             // height:  SizeConfig.blockSizeVertical * 10.0,
            child:

             Row(
              children: [
                Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Text(
                            "العمر" " :",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 4),
                          Text(age.toString())
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Text(
                            "الجنس" " :",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 4),
                          _patient.gender == "MALE" ? Text("ذكر") : Text("أنثى")
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        Container(
                            height: 25,
                            width:SizeConfig.blockSizeHorizontal * 22.0,           
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          PatientDiagnosises(_patient.patientId,model)));
                                })),
                        SizedBox(width: 2),
                        Container(
                            height: 25,
                            width: SizeConfig.blockSizeHorizontal * 19.0,
            
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
                                     Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          PatientMidicalFile(model,_patient)));
                              //  Navigator.pushNamed(context, "/PatientMidicalFile");
                                })),
                        SizedBox(width: 2),
                        Container(
                            height: 25,
                            width: SizeConfig.blockSizeHorizontal * 22.0,
            
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
            )),
          ),
        )),
  );
}
