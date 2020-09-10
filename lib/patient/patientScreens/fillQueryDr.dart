import 'dart:io';

import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/models/query.dart';
import 'package:allo_doctor/pages/ui_widgets/doneWidget.dart';
import 'package:allo_doctor/pages/ui_widgets/wrongWidget.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FillQueryDrScreen extends StatefulWidget {
  final MainModel model;
  final Doctor doctor;
  final dynamic snapShot;
  FillQueryDrScreen(this.model, this.doctor, this.snapShot);
  @override
  _FillQueryDrScreen createState() => _FillQueryDrScreen();
}

class _FillQueryDrScreen extends State<FillQueryDrScreen> {
  String _selectedText = "استعلام عام";
  Query _query;
  Doctor _doctor;
  //Future<Patient> _patient;
  Future<Patient> _patient;
  TextEditingController _queryDataController = TextEditingController();

  final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.center,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );

  Future<Patient> getPatient() async {
    var id = widget.snapShot.patientId;

    http.Response response = await http.get(
      //  "http://192.168.1.36:3000/patients/$_patientId",
      "http://34.71.92.1:3000/patients/$id",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
    print("response stuse get info :${response.statusCode}");
    print("response body :${response.body}");

    var _patientData = json.decode(response.body);
    var _newPatient = Patient(
      //  patientId: _patientId,
      patientId: _patientData['patientId'],
      firstName: _patientData['firstName'],
      lastName: _patientData['lastName'],
      birthdate: _patientData["birthdate"],
      gender: _patientData["gender"],
      avatar: _patientData["avatar"],
      email: _patientData["email"],
    );

    return _newPatient;
  }

  initState() {
    getPatient().then((_) {
      setState(() {
        _patient = getPatient();
      });
    });

    super.initState();
    setState(() {
      _doctor = widget.doctor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Container(
          decoration: BoxDecoration(gradient: mainColor),
          child: Scaffold(
              backgroundColor: Color(0xFF00000),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Color(0xFF0000),
                actions: <Widget>[
                  FutureBuilder(
                      future: _patient,
                      builder: (context, snapShot) {
                        if (snapShot.hasData) {
                          return Container(
                              width: 38,
                              height: 38,
                              padding: EdgeInsets.only(
                                right: 5.0,
                              ),
                              child: Stack(
                                children: <Widget>[
                                  CircleAvatar(
                                      radius: 38,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                          child: SizedBox(
                                              width: 32.0,
                                              height: 32.0,
                                              child: snapShot.data.avatar == ""
                                                  ? Image.asset(
                                                      'assets/Patient.png',
                                                      fit: BoxFit.fill)
                                                  : Image.file(
                                                      File(
                                                          snapShot.data.avatar),
                                                      fit: BoxFit.fill)))),
                                ],
                              ));
                        }
                        return Center(
                            child: SpinKitFadingCircle(
                          color: Color(0xFF2B95AF),
                          size: 28,
                        ));
                      })
                ],
              ),
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 25),
                    Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 19,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: SizedBox(
                                width: 36.0,
                                height: 36.0,
                                child: _doctor.avatar == ""
                                    ? Image.asset('assets/Doctor.png',
                                        fit: BoxFit.fill)
                                    : Image.file(File(_doctor.avatar),
                                        fit: BoxFit.fill)
                                //   :Image.network(_doctor.avatar)
                                // child: (_image!=null)?Image.file(
                                //   _image,
                                //   fit: BoxFit.fill,
                                // ):Image.network(
                                //   "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                //   fit: BoxFit.fill,
                                ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Text(
                              ' : الاستعلام سيوجه الى الطبيب',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Text(
                              _doctor.firstName + " " + _doctor.lastName,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                        margin: EdgeInsets.only(right: 5),
                        alignment: Alignment.topRight,
                        child: Text(
                          'اختر نوع الاستعلام',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.white),
                        )),
                    SizedBox(height: 5),
                    Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0)),
                        margin: EdgeInsets.only(
                          left: 15.0,
                        ),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                          icon: Container(
                            child: Icon(
                              Icons.arrow_drop_down,
                              size: 24,
                              color: Color(0xFF2B95AF),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Tajawal-Medium',
                          ),
                          value: _selectedText,
                          items: <String>[
                            "طبيب أسنان",
                            "استعلام عام",
                            'طبيب عيون'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String val) {
                            _selectedText = val;
                            setState(() {
                              _selectedText = val;
                            });
                          },
                        ))),
                    SizedBox(height: 20),
                    Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          'الاستعلام',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                    SizedBox(height: 5),
                    query(),
                    SizedBox(height: 15),
                    FutureBuilder(
                        future: _patient,
                        builder: (context, snapShot) {
                          if (snapShot.hasData) {
                            return sendButton(() async {
                              // widget.model.isLoading ? onLoading(context) : null;
                              await widget.model.writeQueryDr(
                                  patientId: snapShot.data.patientId,
                                  queryData: _queryDataController.text,
                                  queryType: 1,
                                  queryDate:
                                      DateTime.now().toUtc().toIso8601String(),
                                  doctorId: _doctor.doctorId
                                  // doctorId: "6234f0d1-4822-41bb-8aed-15be668dcb04",
                                  // patientId: "6bd62458-25ac-475b-aaf9-d6ea527a6d71"
                                  );

                              if (widget.model.statusCodes == 200) {
                                doneWidget(context);
                                await Future.delayed(Duration(seconds: 2))
                                    .then((_) {
                                  Navigator.pushNamed(
                                      context, "/homeScreenPatient");
                                });
                              } else if (widget.model.statusCodes != 200) {
                                wrongWidget(context);
                                await Future.delayed(Duration(seconds: 2))
                                    .then((_) {
                                  Navigator.pop(context);
                                });
                              }
                            });
                          } else {
                            return Center(
                                child: SpinKitFadingCircle(
                              color: Color(0xFF2B95AF),
                              size: 28,
                            ));
                          }
                        }),
                    SizedBox(height: 15)
                  ],
                ),
              )));
    });
  }

  Widget query() {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
        margin: EdgeInsets.only(
          left: 15.0,
        ),
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              controller: _queryDataController,
              textDirection: TextDirection.rtl,
              maxLines: 25,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'اكتب الاستعلام',
              ),
              onSaved: (String value) {
                _query.queryData = value;
              },
            )));
  }

  Widget sendButton(Function function) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 60.0),
        height: 40.0,
        child: RaisedButton(
            color: Colors.deepOrangeAccent,
            textColor: Colors.white,
            child: Text(
              'ارسال',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            //padding: EdgeInsets.symmetric(horizontal: 60.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            onPressed: function));
  }
}
