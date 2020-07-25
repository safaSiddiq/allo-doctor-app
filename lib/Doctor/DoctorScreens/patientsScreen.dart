import 'package:allo_doctor/Doctor/ui_widgets/patientCard.dart';
import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PatientsScreen extends StatefulWidget {
  final MainModel model;
  PatientsScreen(this.model);
  @override
  _PatientsScreenState createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  final mainColor = LinearGradient(
    begin: FractionalOffset.bottomCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );
  List<Patient> _patients;
  Future<Doctor> _doctor;
  @override
  void initState() {
    widget.model.getPatientsData().then((_) {
      setState(() {
        _patients = widget.model.patients;
      });
    });

    widget.model.getDoctor().then((_) {
      setState(() {
        _doctor = widget.model.getDoctor();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(gradient: mainColor),
        child: Scaffold(
            backgroundColor: Color(0xFF00000),
            appBar: PreferredSize(
                preferredSize: Size(double.infinity, 105),
                child: AppBar(
                    elevation: 0,
                    backgroundColor: Color(0xFF0000),
                    actions: <Widget>[
                      RawMaterialButton(
                          onPressed: () {
                            //  showSearch(
                            //    context: context,
                            //   delegate: CustomSearchDelegate());
                          },
                          child: Container(
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              margin: EdgeInsets.only(
                                top: 10,
                                bottom: 2,
                                right: 30,
                              ),
                              //width: 280,
                              width: MediaQuery.of(context).size.width * 0.78,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {}))),
                    ],
                    bottom: PreferredSize(
                        preferredSize: Size(double.infinity, 75),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            textDirection: TextDirection.rtl,
                            children: [
                              SizedBox(width: 30),
                              RaisedButton(
                                  onPressed: () {},
                                  color: Colors.white,
                                  textColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Row(
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        Text(
                                          ' بالـإسم',
                                          style: TextStyle(fontSize: 11),
                                          textAlign: TextAlign.center,
                                        ),
                                        Icon(
                                          Icons.arrow_upward,
                                          size: 12,
                                          color: Colors.teal,
                                        ),
                                        Icon(
                                          Icons.arrow_downward,
                                          size: 12,
                                          color: Colors.teal,
                                        ),
                                      ])),
                            ])))),
            body: FutureBuilder(
                future: _doctor,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: _patients.length,
                        itemBuilder: (context, index) =>
                            patientCard(context, _patients[index]));
                  } else {
                    return Center(
                        child: SpinKitFadingCircle(
                      color: Color(0xFF87C9BF),
                      size: 40,
                    ));
                  }
                })));
  }
}
