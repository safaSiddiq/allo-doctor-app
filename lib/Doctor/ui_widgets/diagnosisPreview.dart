import 'package:allo_doctor/Doctor/DoctorScreens/diagnosis.dart';
import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Widget diagnosisPreview(BuildContext context, Query _query) {


  Future<Doctor> getDoctor() async {
 //   var id = "d44adeef-03fe-4af6-8ef0-b6c7db377d2f";
    http.Response response = await http.get(
      //  "http://192.168.1.36:3000/patients/$_patientId",

      // "http://34.71.92.1:3000/doctors/$_doctorId",//1fef50ee-7c82-4a6e-9de5-db5a1ed0ec07
      "http://34.71.92.1:3000/doctors/${_query.doctorId}",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );

    var _doctorData = json.decode(utf8.decode(response.bodyBytes));
    print(_doctorData);
    var _newDoctor = Doctor(
      //  patientId: _patientId,
      doctorId: _doctorData['doctorId'],
      firstName: _doctorData['firstName'],
      lastName: _doctorData['lastName'],
      birthdate: _doctorData["birthdate"],
      gender: _doctorData["gender"],
      major: _doctorData["major"],
      avatar: _doctorData["avatar"],
      bio: _doctorData["bio"],
      email: _doctorData["email"],
    );
    //_doctor = _newDoctor;
    return _newDoctor;
    // return Patient.fromJson(json.decode(response.body));
  }

  return Container(
    // margin: EdgeInsets.symmetric(horizontal:20,vertical:5),
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.only(top: 20, bottom: 5, right: 25, left: 10),
    decoration: BoxDecoration(
        //border: Border(bottom:BorderSide(style: BorderStyle.solid,color:Colors.black)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FutureBuilder(
          future: getDoctor(),
          builder: (context, snapShot) {
          if (snapShot.hasData) {
            return Row(textDirection: TextDirection.rtl, children: [
              Text(
                " : تشخيص طبيب",
                style: TextStyle(fontSize: 13, color: Colors.black),
              ),
              Text(snapShot.data.firstName + " " + snapShot.data.lastName)
            ]);
          } else {
            return Center(
                child: SpinKitFadingCircle(
              color: Color(0xFF87C9BF),
              size: 15,
            ));
          }
        }),
        Row(textDirection: TextDirection.rtl, children: [
          Text(
            ": " "تشخيص يتبع تخصص",
            style: TextStyle(fontSize: 13, color: Colors.black),
          ),
          Text('')
        ]),
        Row(textDirection: TextDirection.rtl, children: [
          Text(
            ' : تاريخ التشخيص',
            style: TextStyle(fontSize: 13, color: Colors.black),
          ),
          Text(_query.queryDate.substring(0, 10)) //resultd
        ]),
        Container(
          alignment: Alignment.topLeft,
          child: RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Diagnosis()));
            },
            color: Color(0xFF2B95AF), // Color(0xFF87C9BF),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text(
              'عرض التشخيص',
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
        ),
      ],
    ),
  );
}
