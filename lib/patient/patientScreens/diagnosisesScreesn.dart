import 'dart:io';

import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/models/query.dart';
import 'package:allo_doctor/patient/ui_widgets/diagnosisPreview.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DiagnosisesScreen extends StatefulWidget {
  final MainModel model;
  DiagnosisesScreen(this.model);
  @override
  _DiagnosisesScreenState createState() => _DiagnosisesScreenState();
}

class _DiagnosisesScreenState extends State<DiagnosisesScreen> {
  List<Query> _queriesReplay = [];
  List<Query> _queriesReplayApproved = [];
  Future<Patient> _patient;

  @override
  void initState() {
    widget.model.getPatient().then((_) {
      setState(() {
        _patient = widget.model.getPatient();
      });
    });

    widget.model.getQueryResultData().then((_) {
      _queriesReplay = widget.model.queriesResults;
      _check();
    });
    super.initState();
  }

  void _check() {
    for (int i = 0; i < _queriesReplay.length; i++) {
      if (_queriesReplay[i].approved == true) {
        _queriesReplayApproved.add(_queriesReplay[i]);
      }
    }
    setState(() {
      _queriesReplayApproved;
    });
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final mainColor = LinearGradient(
    begin: FractionalOffset.topRight,
    // end: FractionalOffset.bottomCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [
      Color(0xFF2B95AF),
      Color(0xFF87C9BF),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(gradient: mainColor),
        child: Scaffold(
            backgroundColor: Color(0xFF00000),
            appBar: AppBar(
              centerTitle: false,
              elevation: 0,
              backgroundColor: Color(0xFF0000),
              actions: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    child: Text(
                      'التشخيصات',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 18),
                    )),
                SizedBox(width: 5),
                FutureBuilder(
                    future: _patient,
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        return Container(
                            //  padding: EdgeInsets.only(right: 5, top: 5, bottom: 5),
                            child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                    child: SizedBox(
                                        width: 38.0,
                                        height: 38.0,
                                        child: snapShot.data.avatar == ""
                                            ? Image.asset('assets/Patient.png',
                                                fit: BoxFit.fill)
                                            : Image.file(
                                                File(snapShot.data.avatar),
                                                fit: BoxFit.fill)))));
                      }
                      return Center(
                          child: SpinKitFadingCircle(
                        color: Color(0xFF87C9BF),
                        size: 20,
                      ));
                    }),
              ],
            ),
            body: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _refresh,
                child:
                    // FutureBuilder(
                    //   future: _patient,
                    //   builder: (context, snapShot) {
                    //     if (snapShot.hasData) {
                    //       return
                    Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15))),
                  child: ListView.builder(
                    itemCount: _queriesReplayApproved.length,
                    itemBuilder: (context, index) => diagnosisPreview(
                        context, _queriesReplayApproved[index]),
                  ),
                ))));
  }

  Future _refresh() {
    // widget.model.getPatient().then((_) {
    //   setState(() {
    //     _patient = widget.model.getPatient();
    //   });
    // });

    widget.model.getQueryResultData().then((_) {
      _queriesReplay = widget.model.queriesResults;
    });
    return widget.model.getQueryResultData();
  }
}
