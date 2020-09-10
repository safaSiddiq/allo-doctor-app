import 'dart:io';

import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/patient/patientScreens/doctorFile.dart';
import 'package:allo_doctor/patient/patientScreens/fillQueryDr.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';

Widget doctorCard(
  BuildContext context,
  Doctor doctor,
  dynamic snapShot,
) {
  final MainModel model = MainModel();
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Card(
        color: Colors.white,
        //key: ValueKey(record.name),
        elevation: 0.0,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
        margin: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
        child: Container(
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: ListTile(
            contentPadding: EdgeInsets.only(top: 2, bottom: 10, right: 5),
            leading://PreferredSize(
            //   preferredSize: Size.fromHeight(110),
            //   child:
             Container(
                width: 75,
                height: 75,
                padding: EdgeInsets.only(
                  right: 5.0,
                ),
              //   Container(
              // width: 65,
              // height: 65,
              // padding: EdgeInsets.only(
              //   right: 10.0,
              // ),
              // child:
              //     CircleAvatar(
              //         radius: 41,
              //         backgroundColor: Colors.white,
              //         child: ClipOval(
              //             child: SizedBox(
              //                 width: 70.0,
              //                 height: 70.0,
              //                 child: _patient.avatar == ""
              //                     ? Image.asset('assets/Patient.png',
              //                         fit: BoxFit.fill)
              //                     : Image.file(File(_patient.avatar))))),
   // ),
                  child:  CircleAvatar(
                        radius: 41,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                            child: SizedBox(
                                width: 75.0,
                                height: 75.0,
                                child: doctor.avatar == ""
                                    ? //doctor.avatar == null?
                                    Image.asset('assets/Doctor.png',
                                        fit: BoxFit.fill)
                                    : Image.file(File(doctor.avatar.toString()),
                                        fit: BoxFit.fill)))),
            ),
            title: Text(
              doctor.firstName + " " + doctor.lastName,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                SizedBox(width: 5),
                Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          text: doctor.major,
                          style: TextStyle(
                              color: Colors.blue, fontFamily: 'Tajawal-Medium'),
                        ),
                        maxLines: 3,
                        softWrap: true,
                      ),
                      SizedBox(height: 5),
                      Row(children: [
                        Container(
                            height: 25,
                            width: 85,
                            child: RaisedButton(
                                color: Colors.deepOrangeAccent,
                                child: Text(
                                  'ملف طبيب',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DoctorFileScreen(
                                          model, doctor, snapShot)));
                                  //  Navigator.pushNamed(context, "/DoctorFileScreen");
                                })),
                        SizedBox(width: 20),
                        Container(
                            height: 25,
                            width: 85,
                            child: RaisedButton(
                                color: Colors.deepOrangeAccent,
                                child: Text(
                                  'استعلام',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                onPressed: () {
                                  print(snapShot);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => FillQueryDrScreen(
                                          model, doctor, snapShot)));
                                  // Navigator.pushNamed(context, "/FillQueryDrScreen");
                                })),
                      ])
                    ]))
              ],
            ),
          ),
        )),
  );
}
