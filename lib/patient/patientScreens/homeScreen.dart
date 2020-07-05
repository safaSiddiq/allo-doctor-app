//import 'package:allo_doctor/pages/registrationScreen.dart';
import 'package:allo_doctor/pages/registrationScreen.dart';
import 'package:allo_doctor/patient/patientScreens/callCenterScreen.dart';
import 'package:allo_doctor/patient/patientScreens/diagnosisesScreesn.dart';
import 'package:allo_doctor/patient/patientScreens/doctorsSearch.dart';
import 'package:allo_doctor/patient/patientScreens/fillQuery.dart';
import 'package:allo_doctor/patient/patientScreens/massagesScreen.dart';
import 'package:allo_doctor/patient/patientScreens/medicalFile.dart';
import 'package:allo_doctor/patient/patientScreens/personalInfoScreen.dart';
import 'package:allo_doctor/patient/patientScreens/queriesReplaies.dart';
import 'package:allo_doctor/patient/ui_widgets/doctorCard.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';

class HomeScreenPatient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenPatient();
  }
}

class _HomeScreenPatient extends State<HomeScreenPatient> {
  MainModel model;
  bool isOnline = true;

  final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: mainColor
      ),
    child:
    Scaffold(
      backgroundColor: Color(0xFF00000),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color(0xFF0000),
        actions: <Widget>[
          Container(
            
              padding: EdgeInsets.only(right: 5, top: 5, bottom: 5),
              child: Stack(
                textDirection: TextDirection.rtl,
                children: <Widget>[ 
              CircleAvatar(
                  radius: 21,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                      child: SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child: Image.asset('assets/Patient.png',
                              fit: BoxFit.fill)))),
                                  isOnline
                                ? Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(right: 3,bottom: 5),
                                    child: Container(
                                      height: 10,
                                      width: 10,
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
              )),
        ],
      ),
      endDrawer: Drawer(
        child: Container(
          color: Color(0xFF174160),
        child:
        Container(
            decoration: BoxDecoration(
            
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15)
        
          ),
                color: Colors.deepOrange),
            child: ListView(children: <Widget>[
              Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: UserAccountsDrawerHeader(
                        //margin: EdgeInsets.only(left:100.0),
                        accountName: Text(
                          "محمد علي عبدالله",
                        ),
                        accountEmail: Text(
                          "ashishrawat2911@gmail.com",
                        ),
                        currentAccountPicture: Stack(
                          children: <Widget>[
                            CircleAvatar(
                                radius: 41,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                    child: SizedBox(
                                        width: 70.0,
                                        height: 70.0,
                                        child: Image.asset('assets/Patient.png',
                                            fit: BoxFit.fill)))),
                            isOnline
                                ? Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(right: 3),
                                    child: Container(
                                      height: 15,
                                      width: 15,
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
                        )),
                  )),
              RawMaterialButton(
                  child: iconDrawer(' استعلام عام', Icons.create_new_folder),
                  onPressed: () {
                    
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => FillQueryScreen(model)));
                  }),
              RawMaterialButton(
                  child: iconDrawer('بحث عن طبيب', Icons.search),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => DoctorsSearch(model)));
                  }),
              RawMaterialButton(
                  child: iconDrawer('ردود الاستعلامات', Icons.inbox),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => QueriesReplaies()));
                  }),
              RawMaterialButton(
                  child: iconDrawer('الرسائل', Icons.mail),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MassagesScreen()));
                  }),
              RawMaterialButton(
                  child: iconDrawer('التشخيصات', Icons.playlist_add_check),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DiagnosisesScreen()));
                  }),
              RawMaterialButton(
                  child: iconDrawer('ملف طبي', Icons.folder),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MedicalFile()));
                  }),
              RawMaterialButton(
                  child: iconDrawer('مركز الاتصالات', Icons.contact_phone),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => CallCenterScreen()));
                  }),
              RawMaterialButton(
                  child: iconDrawer('تواصل معنا', Icons.phone),
                  onPressed: () {}),
              RawMaterialButton(
                  child: iconDrawer('بيانات شخصية', Icons.settings),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PesronalinfoScreen()));
                  }),
              RawMaterialButton(
                  child: iconDrawer('تسجيل الخروج', Icons.power_settings_new),
                  onPressed: () {
                       Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegistrationScreen()));
                  }),
            ])),
      )),
      body: ListView(
        padding: EdgeInsets.only(
          top: 40,
        ),
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 25),
            alignment: Alignment.topRight,
            child: Text('اخر ردود الاستعلامات ',
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    child: Text('لا يوجد ردود استعلامات'),
                  ),
                  Container(
                    height: 35,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(),
                      child: RaisedButton(
                        onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QueriesReplaies()));
                        },
                        color: Colors.deepOrangeAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(
                          "عرض الكل",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ))
                ],
              )
              //
              ),
          SizedBox(height: 20),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.topRight,
              child: Text(
                'الأطباء الجدد',
                style: TextStyle(fontSize: 18, color: Colors.white),
              )),
          SizedBox(height: 5),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              //padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(children: [
                doctorCard(context, true),
                Divider(),
                doctorCard(context, true)
              ]))

          // Container(
          //    decoration: BoxDecoration(
          //     color:Colors.white,
          //     borderRadius: BorderRadius.circular(20)
          //   ),
          //   padding: EdgeInsets.all(5),
          //   child:ListView.builder(
          //     itemCount: 2,
          //     itemBuilder: ,
          // ))
        ],
      ),
    ));
  }
}

Widget iconDrawer(String title, IconData icon) {
  return Row(
    textDirection: TextDirection.rtl,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(right: 2.0),
        height: 50.0,
        width: 65.0,
        // decoration: BoxDecoration(
        //     shape: BoxShape.rectangle,
        //     borderRadius: BorderRadius.circular(24.0),
        // ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      SizedBox(width: 1.0),
      Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 15.0),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
      )
    ],
  );
}
