import 'dart:async';

import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/models/query.dart';
import 'package:allo_doctor/pages/ui_widgets/doneWidget.dart';
import 'package:allo_doctor/pages/ui_widgets/wrongWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_model.dart/mainModel.dart';

class FillQueryScreen extends StatefulWidget {
  final MainModel model;
  FillQueryScreen(this.model);
  @override
  _FillQueryScreen createState() => _FillQueryScreen();
}

class _FillQueryScreen extends State<FillQueryScreen> {
  String _selectedText = "استعلام عام";
  bool isOnline = true;
  Query _query;

  TextEditingController _queryDataController = TextEditingController();

  final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );
  Future<Patient> _patient;

  @override
  initState() {
    widget.model.getPatient().then((_) {
      setState(() {
        _patient = widget.model.getPatient();
      });
    });
   
    super.initState();
  }

  Widget build(BuildContext context,) {
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
                                                child: snapShot.data.avatar ==
                                                        ""
                                                    ? Image.asset(
                                                        'assets/Patient.png',
                                                        fit: BoxFit.fill)
                                                    : Image.network(snapShot
                                                        .data.avatar)))),
                                    isOnline
                                        ? Container(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                bottom: 13,
                                              ),
                                              height: 9,
                                              width: 9,
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
                                ));
                          } else {
                            return Center(
                                child: SpinKitFadingCircle(
                              color: Color(0xFF2B95AF),
                              size: 28,
                            ));
                          }
                        })
                  ]),
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Center(
                        child: Text(
                      'هذا الاستعلام سيوجه الى مجموعة من الأطباء',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
                    SizedBox(height: 25),
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
                          items: <String>["استعلام عام", 'زيارة طبية']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            _selectedText = value;
                            setState(() {
                              _selectedText = value;
                              // query.queryType = value;
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
                    queryField(),
                    SizedBox(height: 15),
                    sendButton(() async {
                      // widget.model.isLoading ? onLoading(context) : null;
                      await widget.model.writeQuery(
                          queryData: _queryDataController.text,
                          queryType: 1,
                         queryDate: DateTime.now().toUtc().toIso8601String(),
                          // doctorId: "6234f0d1-4822-41bb-8aed-15be668dcb04");
                          doctorId:"6234f0d1-4822-41bb-8aed-15be668dcb04");
                      if (widget.model.statusCodes == 200) {
                        doneWidget(context);
                        await Future.delayed(Duration(seconds: 2)).then((_) {
                          Navigator.pushNamed(context, "/homeScreenPatient");
                        });
                      } else if (widget.model.statusCodes != 200) {
                        wrongWidget(context);
                        await Future.delayed(Duration(seconds: 2)).then((_) {
                          Navigator.pop(context);
                        });
                      }
                    }),
                    SizedBox(height: 15)
                  ],
                ),
              )));
    });
  }

  Widget queryField() {
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
                onSaved: (String value) {
                  setState(() {
                    _query.queryData = value;
                  });
                },
                textDirection: TextDirection.rtl,
                maxLines: 25,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'اكتب الاستعلام',
                ))));
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
