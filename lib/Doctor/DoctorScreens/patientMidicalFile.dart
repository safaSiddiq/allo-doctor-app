import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientMidicalFile extends StatefulWidget {
  final MainModel model;
  final Patient patient;

  PatientMidicalFile(this.model, this.patient);
  @override
  _PatientMidicalFileState createState() => _PatientMidicalFileState();
}

class _PatientMidicalFileState extends State<PatientMidicalFile> {
    Future<Doctor>_doctor;
  final mainColor = LinearGradient(
    begin: FractionalOffset.bottomCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );


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
//var birthdate =


 
  @override
  // void initState() {
  //   widget.model.getDoctor().then((_){
  //     setState(() {
  //       _doctor = widget.model.getDoctor();
  //     });
  //   });

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {

      model.getDoctor().then((_){
      setState(() {
        _doctor =model.getDoctor();
      });
    });

    var date = DateTime.parse( widget.patient.birthdate.substring(0, 10));
  var age = calculateAge(date);
      return Container(
          decoration: BoxDecoration(gradient: mainColor),
          child: Scaffold(
              backgroundColor: Color(0xff00000),
              appBar: AppBar(
                backgroundColor: Color(0xff0000),
                elevation: 0,
                actions: <Widget>[
                  FutureBuilder(
                    future: _doctor,
                    builder: (context,snapShot){
                      if(snapShot.hasData){
                        return

                  Container(
                    padding: EdgeInsets.only(right: 5, top: 5, bottom: 5),
                    child: CircleAvatar(
                        radius: 21,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                            child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: snapShot.data.avatar==""?
                                    Image.asset('assets/Doctor.png',
                                        fit: BoxFit.fill)
                                : Image.network(snapShot.data.avatar)
                                ))),
                  );
                  }else{
                        return Center(
                              child: SpinKitFadingCircle(
                            color: Color(0xFF87C9BF),
                            size: 32,
                          ));
                  }
                  })
                ],
              ),
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 5, bottom: 10),
                      child: Text(
                        "المعلومات الشخصية",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Container(
                              width: 85,
                              height: 85,
                              padding: EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: 
                                  CircleAvatar(
                                      radius: 41,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                          child: SizedBox(
                                              width: 70.0,
                                              height: 70.0,
                                              child: widget.patient.avatar=="null"?
                                               Image.asset(
                                                  'assets/Patient.png',
                                                  fit: BoxFit.fill)
                                                  :Image.network(widget.patient.avatar)
                                                  ))),
                               
                            ),
                          SizedBox(width: 10),
                          Column(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 10),
                              Text(
                                widget.patient.firstName+" "+widget.patient.lastName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              SizedBox(height: 8),
                              textRow(   "العمر"    , age.toString()),
                              textRow("الجنس", 
                              widget.patient.gender=="MALE"?"ذكر":"أنثى"
                              ),
                              textRow("الجنسية", 'محل الإقامة'),
                              textRow("محل الإقامة", "مصراتة - ليبيا"),
                              textRow("فصيلة الدم", "A+"),
                              SizedBox(height: 10)
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 5, bottom: 10, top: 20),
                      child: Text(
                        "الأمراض المزمنة",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 5, bottom: 10, top: 20),
                      child: Text(
                        "الحساسيات",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 5, bottom: 10, top: 20),
                      child: Text(
                        "الأدوية الحالية",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 5, bottom: 10, top: 20),
                      child: Text(
                        "الجراحات السابقة",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      child: Column(
                        children: <Widget>[exData()],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 5, bottom: 10, top: 20),
                      child: Text(
                        "التحاليل السابقة",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      child: Column(
                        children: <Widget>[exData()],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 5, bottom: 10, top: 20),
                      child: Text(
                        "الأشعة السابقة",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      child: Column(
                        children: <Widget>[exData(), exData()],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )));});
  }
}

Widget textRow(String title, String info) {
  return Row(
    textDirection: TextDirection.rtl,
    children: <Widget>[
      Text(
        ": " + title,
        style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
      ),
      SizedBox(width: 5),
      Text(info)
    ],
  );
}

Widget exData() {
  return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.teal))),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            title: Text("data"),
            subtitle: Text("data"),
            trailing: Container(
                width: 110,
                height: 46,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[300]),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        SizedBox(width: 5),
                        Text("22/2/2020"),
                        SizedBox(width: 5),
                        Icon(Icons.calendar_today),
                      ],
                    ))),
          )));
}
