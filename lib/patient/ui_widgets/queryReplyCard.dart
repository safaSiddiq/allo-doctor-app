import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/query.dart';
import 'package:allo_doctor/patient/patientScreens/diagnosisView.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';


 Future<Doctor> getDoctor(String id) async {  
   http.Response response = await http.get(
   "http://34.71.92.1:3000/doctors/$id",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
      print("response stuse get info dr :${response.statusCode}");
      print("response body :${response.body}");
   
     var _doctorData = json.decode(response.body);
  var  _newDoctor =Doctor(
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
    return  _newDoctor;
     // return Patient.fromJson(json.decode(response.body));
  }

Widget queryReplyCard(BuildContext context, Query query) {
 MainModel model;
  
  return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
          elevation: 0.0,
        
          margin: EdgeInsets.only(top: 5, right: 10, left: 10, bottom: 5),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.teal))
                //shape: BoxShape.circle
                ),
            child: FutureBuilder(
              future: getDoctor(query.doctorId),
              builder: (context,snapShot){
                if(snapShot.hasData){
                  return 
              
             ListTile(
              contentPadding: EdgeInsets.only(top: 1, bottom: 1, right: 5,left: 5),
              leading: Container(
                  height: 70,
                  width: 70,
                  padding: EdgeInsets.only(
                    right: 10.0,
                  ),
                  child: 
                      CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                              child: SizedBox(
                                  width: 65.0,
                                  height: 65.0,
                                  child://snapShot.data.avatar == ""?
                                   Image.asset('assets/Doctor.png',
                                      fit: BoxFit.fill)))),
                  ),
              title: Text(snapShot.data.firstName + " "+snapShot.data.lastName),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                      child: Column(
                    children: <Widget>[
                      Text(query.queryDate.substring(0,10)),
                      SizedBox(height: 5),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Color(0xFF2B95AF),
                        ),
                        child: Text( 
                          'زيارة طبية',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      )
                    ],
                  )),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      height: 25,
                      width: 85,
                      child: RaisedButton(
                          // padding: EdgeInsets.symmetric(
                          //     horizontal: 15, vertical: 10),
                          color: (query.approved == true)
                              ? Colors.green
                              : Colors.grey,
                          child: Text(
                            "تشخيص",
                            style: TextStyle(fontSize: 11, color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          onPressed: query.approved == true
                              ? () {
                                  Navigator.of( context).push(
           MaterialPageRoute(builder: (context) => DiagnosisViewScreen(model,query)));
                                }
                              : null)),
                  stateButton(query.approved)
                  // query.approved !=null?
                  // query.approved ==true ?stateButton("تم القبول"):stateButton("تم الرفض")
                  // :stateButton("")
                ],
              ),
            );
              }else{
                  return Center(
                              child: SpinKitFadingCircle(
                            color: Color(0xFF87C9BF),
                            size: 20,
                          ));
              }
            })
          )));
}

stateButton(bool state) {
  if (state == true) {
    return Container(
        height: 25,
        width: 85,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.green),
        child: Text(
          "تم القبول",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: Colors.white),
        ));
  } else if (state == false) {
    return Container(
        height: 25,
        width: 85,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.red),
        child: Text(
          "تم الرفض",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: Colors.white),
        ));
  } else if (state = null) {
    return Container(
        height: 25,
        width: 85,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.grey),
        child: Text(
          "في انتظار الرد",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: Colors.white),
        ));
  }
}
