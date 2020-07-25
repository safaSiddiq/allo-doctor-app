import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DoctorFileScreen extends StatefulWidget{
  final MainModel model;
 final Doctor doctor;
 final dynamic snapShot;
  DoctorFileScreen(this.model,this.doctor,this.snapShot);
  @override
  _DoctorFileScreen createState() => _DoctorFileScreen();
}


class _DoctorFileScreen extends State<DoctorFileScreen> {

final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.center,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );
 Doctor _doctor;
  
  Patient _patient;


initState() {
    super.initState();
     setState(() {
         _patient = widget.snapShot;
         _doctor =widget.doctor;
   });
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          return Container(
      decoration: BoxDecoration(
        gradient: mainColor
      ),
    child:
    Scaffold(
        backgroundColor: Color(0xFF00000),
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xFF0000),
          actions: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 5, top: 5, bottom: 5),
                child: Stack(
                  children: <Widget>[
                CircleAvatar(
                            radius: 21,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                                child: SizedBox(
                                    width: 40.0,
                                    height: 40.0,
                                    child: _patient.avatar==""?
                                    Image.asset('assets/Patient.png',
                                        fit: BoxFit.fill)
                                        :Image.network(_patient.avatar)
                                        ))),
                        
             ]),
             )
          ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical:15),
          children: <Widget>[
          Column(children: [
            Center(
              child: CircleAvatar(
                  radius: 120,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                      child: SizedBox(
                          width: 235.0,
                          height: 235.0,
                          child: _doctor.avatar=="null"?
                           Image.asset('assets/Doctor.png',
                              fit: BoxFit.fill)
                              :Image.network(_doctor.avatar)
                              ))),
            ),
            SizedBox(height: 15),
            Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '.د',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  Text(
                    _doctor.firstName + " "+_doctor.lastName,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  )
                ]),
            SizedBox(height: 15),
            Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'طبيب مختص',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  SizedBox(width: 20),
                  Text(
                   _doctor.major,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  )
                ]),
          ]),
          SizedBox(height: 30),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(textDirection: TextDirection.rtl, children: [
                IconButton(
                    icon: Icon(
                      Icons.place,
                      color: Colors.white,
                    ),
                    onPressed: null),
                Text(
                  'أماكن العمل',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )
              ])),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Text(''),
          ),
          SizedBox(height: 30),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(textDirection: TextDirection.rtl, children: [
                IconButton(
                    icon: Icon(
                      Icons.library_books,
                      color: Colors.white,
                    ),
                    onPressed: null),
                Text(
                  'السيرة الذاتية',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )
              ])),
          Container(
            padding: EdgeInsets.symmetric(horizontal:15,vertical:10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Directionality(textDirection: TextDirection.rtl, child: 
             Text(_doctor.bio
             ,style: TextStyle(
               color: Colors.black,
               fontSize: 16
             ),)),
          ),
        ])));

        });
  }
}
