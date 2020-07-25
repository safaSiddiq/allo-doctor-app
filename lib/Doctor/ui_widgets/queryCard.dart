import 'package:allo_doctor/Doctor/DoctorScreens/queryView.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/models/query.dart';
import 'package:allo_doctor/pages/ui_widgets/wrongWidget.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QueryCard extends StatefulWidget {
  final MainModel model;
  final Query query;
  final dynamic snapShot;
  final String patientId;
  final String queryId;
  QueryCard(
      this.model, this.query, this.snapShot, this.patientId, this.queryId);
  @override
  _QueryCardState createState() => _QueryCardState();
}

class _QueryCardState extends State<QueryCard> {
  int value = 0;
  Future<Patient> _patient;
  MainModel model;
  Future<Query> _query;

  Future acceptingQuery({
    String queryId,
    String patientId,
    bool approved,
  }) async {
    final Map<String, dynamic> queryResultData = {
      "queryId": queryId,
      "patientId": patientId,
      "approved": approved,
    };
    final http.Response response = await http.patch(
        "http://34.71.92.1:3000/doctors/d44adeef-03fe-4af6-8ef0-b6c7db377d2f/queries",
        headers: {
          "Accept": "Application/json",
          'Content-Type': 'Application/json'
        },
        body: json.encode(queryResultData));
    print("query edit${response.statusCode}");
    print(response.body);
  }

  Widget acceptQuery(String snapShot) {
    return Container(
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.teal,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  value = 1;
                  acceptingQuery(
                      queryId: snapShot, // widget.queryId,
                      patientId: widget.patientId,
                      approved: true);
                  // widget.query.approved =true;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => QueryView(model, widget.query)));
                  //  Navigator.pushNamed(context, "/QueryView");
                });
              }),
          IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.red,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  value = 2;
                  acceptingQuery(
                      queryId: snapShot, //widget.query.queryId,
                      patientId: widget.patientId,
                      approved: false);
                });
              })
        ],
      ),
    );
  }

  Future<Patient> getPatient() async {
    var id = widget.patientId;

    /// var ids ="1b407356-9df5-4079-b978-6a12e216e6e6";

    http.Response response = await http.get(
      //  "http://192.168.1.36:3000/patients/$_patientId",
      "http://34.71.92.1:3000/patients/${id}",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
    print("response stuse get patient info :${response.statusCode}");
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
    // _patient = _newPatient;
    return _newPatient;
    // return Patient.fromJson(json.decode(response.body));
  }

  Future<Query> getQuery() async {
    final http.Response response = await http.get(
      //  "http://34.71.92.1:3000/doctors/d44adeef-03fe-4af6-8ef0-b6c7db377d2f/queries",
      "http://34.71.92.1:3000/allo-doctors-queries/4bf9db8d-142b-4d3b-bf16-c09a599b0713",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
    var _queryData = json.decode(response.body);
    var _newQuery = Query(
      //  patientId: _patientId,
      queryId: _queryData['queryId'],
      queryData: _queryData['queryData'],
      queryDate: _queryData['queryDate'],
      queryResult: _queryData["queryResult"],
      queryResultDate: _queryData["queryResultDate"],
      approved: _queryData["approved"],
      emergency: _queryData["emergency"],
    );
    // _patient = _newPatient;

    return _newQuery;
  }

  @override
  void initState() {
    getPatient().then((_) {
      setState(() {
        _patient = getPatient();
      });
    });
    getQuery().then((_) {
      setState(() {
        _query = getQuery();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            //width: MediaQuery.of(context).size.width * 0.80,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.teal))),
            child: Card(
                color: Colors.white,
                //key: ValueKey(record.name),
                elevation: 0,
                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
                margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
                child: SizedBox(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: FutureBuilder(
                          future: _patient,
                          builder: (context, snapShot) {
                            if (snapShot.hasData) {
                              return SizedBox(
                                  child: ListTile(
                                      contentPadding: EdgeInsets.only(
                                          top: 1, bottom: 1, right: 5),
                                      leading: PreferredSize(
                                          preferredSize:
                                              Size(double.infinity, 80),
                                          child: Container(
                                            width: 65,
                                            height: 65,
                                            padding: EdgeInsets.only(
                                              right: 10.0,
                                            ),
                                            child: CircleAvatar(
                                                radius: 41,
                                                backgroundColor: Colors.white,
                                                child: ClipOval(
                                                    child: SizedBox(
                                                        width: 70.0,
                                                        height: 70.0,
                                                        child: snapShot.data
                                                                    .avatar ==
                                                                ""
                                                            ? Image.asset(
                                                                'assets/Patient.png',
                                                                fit:
                                                                    BoxFit.fill)
                                                            : Image.network(
                                                                snapShot.data
                                                                    .avatar)))),
                                            //   value == 0 && (value != 1 && value != 2)
                                            //       ? Positioned(
                                            //           right: 0.5,
                                            //           child: Container(
                                            //               // margin: EdgeInsets.only(left: 50)
                                            //               height: 10,
                                            //               width: 10,
                                            //               decoration: BoxDecoration(
                                            //                 shape: BoxShape.circle,
                                            //                 color: Colors.red,
                                            //               )),
                                            //         )
                                            //       : Container(),
                                          )),
                                      title: Text(
                                        snapShot.data.firstName +
                                            " " +
                                            snapShot.data.lastName,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: FutureBuilder(
                                          future: _query,
                                          builder: (context, snapShot1) {
                                            if (snapShot1.hasData) {
                                              return Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  //width: 75,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(snapShot1
                                                          .data.queryDate
                                                          .substring(0, 10)),
                                                      Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 8),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: Color(
                                                                  0xFF2B95AF)),
                                                          child: Text(
                                                            snapShot1.data
                                                                        .queryType ==
                                                                    null
                                                                ? "زيارة طبية"
                                                                : "   ",

                                                            // Text(  widget.query.queryType == null
                                                            //       ? "زيارة طبية"
                                                            //       : "   ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10),
                                                          ))
                                                    ],
                                                  ));
                                            } else {
                                              return Center(
                                                  child: SpinKitFadingCircle(
                                                color: Color(0xFF87C9BF),
                                                size: 20,
                                              ));
                                            }
                                          }),
                                      trailing: Container(
                                          child: FutureBuilder(
                                              future: _query,
                                              builder: (context, snapShot2) {
                                                if (snapShot2.hasData) {
                                                  return Column(
                                                    children: <Widget>[
                                                      Container(
                                                          height: 25,
                                                          width: 92,
                                                          child: RaisedButton(
                                                              color: snapShot2
                                                                      .data
                                                                      .approved
                                                                  ? Colors.green
                                                                  : Colors.grey,
                                                              child: Text(
                                                                'ملف طبي',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0)),
                                                              onPressed: snapShot2
                                                                      .data
                                                                      .approved
                                                                  ? () {
                                                                    Navigator.pushNamed(context, "/PatientMidicalFile");
                                                                    }
                                                                  : null)),
                                                      SizedBox(height: 1),
                                                      snapShot2.data.approved ==
                                                              null // &&(value != 1 && value != 2)
                                                          ? Container(
                                                              height: 30,
                                                              width: 110,
                                                              child: acceptQuery(
                                                                  snapShot2.data
                                                                      .queryId),
                                                            )
                                                          : Container(
                                                              height: 30,
                                                              width: 110,
                                                              child: snapShot2
                                                                          .data
                                                                          .approved ==
                                                                      true //value == 1 &&value != 0
                                                                  ? acceptButton()
                                                                  : declineButton())
                                                      // Container(
                                                      //   height: 30,
                                                      //   width: 110,
                                                      //  child: acceptQuery(),
                                                      // )
                                                    ],
                                                  );
                                                } else {
                                                  return Center(
                                                      child:
                                                          SpinKitFadingCircle(
                                                    color: Color(0xFF87C9BF),
                                                    size: 20,
                                                  ));
                                                }
                                              }))));
                            } else if (snapShot.hasError) {
                              return wrongWidget(context);
                            }
                            return Center(
                                child: SpinKitFadingCircle(
                              color: Color(0xFF87C9BF),
                              size: 35,
                            ));
                          })),
                ))));
  }

  Widget acceptButton() {
    return RawMaterialButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => QueryView(model, widget.query)));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          height: 25,
          width: 95,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(8)),
          child: Text(
            'تم القبول',
            style: TextStyle(fontSize: 10, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ));
  }

  Widget declineButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(8)),
      child: Center(
          child: Text(
        'تم الرفض',
        style: TextStyle(fontSize: 10, color: Colors.white),
      )),
    );
  }
}
