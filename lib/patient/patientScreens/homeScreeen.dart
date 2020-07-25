import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreenPatient extends StatefulWidget {
  final MainModel model;
  HomeScreenPatient(this.model);
  @override
  _HomeScreenPatientState createState() => _HomeScreenPatientState();
}

class _HomeScreenPatientState extends State<HomeScreenPatient> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
     GlobalKey<RefreshIndicatorState>();
  bool isOnline = true;

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
  void initState() {
    
    widget.model.getPatient().then((_) {
          setState(() {
       _patient = widget.model.getPatient();
          });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(gradient: mainColor),
        child: Scaffold(
          backgroundColor: Color(0xff00000),
          appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Color(0xFF0000),
              actions: <Widget>[
                FutureBuilder(
                    future:
                    
                     _patient,
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        return Container(
                            padding:
                                EdgeInsets.only(right: 5, top: 5, bottom: 5),
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
                                            child: snapShot.data.avatar ==
                                                    ""
                                                ? Image.asset(
                                                    'assets/Patient.png',
                                                    fit: BoxFit.fill)
                                                : Image.network(
                                                    snapShot.data.avatar)))),
                                isOnline
                                    ? Container(
                                        alignment: Alignment.bottomRight,
                                        margin: EdgeInsets.only(
                                            right: 3, bottom: 5),
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
                            ));
                      } else {
                        return Center(
                            child: SpinKitFadingCircle(
                          color: Color(0xFF87C9BF),
                          size: 30                                                                                                                                                                                                                                                                                                                                                                                                                                      ,
                        ));
                      }
                    })
              ]),
          endDrawer: Drawer(
              child: Container(
            color: Color(0xFF174160),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: Colors.deepOrange),
                child: ListView(children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: FutureBuilder(
                              future: _patient,
                              builder: (context, snapShot) {
                                if (snapShot.hasData) {
                                  return UserAccountsDrawerHeader(
                                      //margin: EdgeInsets.only(left:100.0),
                                      accountName: 
                                       Text(
                                    //    _editPatient.firstName
                                         snapShot.data.firstName +
                                              "  " +
                                              snapShot.data.lastName
                                        ,
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      accountEmail: Text(
                                        snapShot.data.email,
                                        style: TextStyle(fontSize: 17),
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
                                                      child: //_patient.avatar == "null"
                                                          //?
                                                          Image.asset(
                                                              'assets/Patient.png',
                                                              fit: BoxFit.fill)
                                                      //: Image.network( _patient.avatar)
                                                      ))),
                                       
                                        ],
                                      ));
                                }
                                return Center(
                                    child: SpinKitFadingCircle(
                                  color: Color(0xFF87C9BF),
                                  size: 30,
                                ));
                              }))),
                  RawMaterialButton(
                      child:
                          iconDrawer(' استعلام عام', Icons.create_new_folder),
                      onPressed: () {
                        Navigator.pushNamed(context, "/FillQueryScreen");
                      }),
                  RawMaterialButton(
                      child: iconDrawer('بحث عن طبيب', Icons.search),
                      onPressed: () {
                        Navigator.pushNamed(context, "/DoctorsSearch");
                      }),
                  RawMaterialButton(
                      child: iconDrawer('ردود الاستعلامات', Icons.inbox),
                      onPressed: () {
                        Navigator.pushNamed(context, "/QueriesReplaies");
                      }),
                  RawMaterialButton(
                      child: iconDrawer('الرسائل', Icons.mail),
                      onPressed: () {
                        Navigator.pushNamed(context, "/MassagesScreen");
                      }),
                  RawMaterialButton(
                      child: iconDrawer('التشخيصات', Icons.playlist_add_check),
                      onPressed: () {
                        Navigator.pushNamed(context, "/DiagnosisesScreen");
                      }),
                  RawMaterialButton(
                      child: iconDrawer('ملف طبي', Icons.folder),
                      onPressed: () {
                        Navigator.pushNamed(context, "/MedicalFile");
                      }),
                  RawMaterialButton(
                      child: iconDrawer('مركز الاتصالات', Icons.contact_phone),
                      onPressed: () {
                        Navigator.pushNamed(context, "/CallCenterScreen");
                      }),
                  RawMaterialButton(
                      child: iconDrawer('تواصل معنا', Icons.phone),
                      onPressed: () {}),
                  RawMaterialButton(
                      child: iconDrawer('بيانات شخصية', Icons.settings),
                      onPressed: () {
                        Navigator.pushNamed(context, "/PesronalinfoScreen");
                      }),
                  RawMaterialButton(
                      child:
                          iconDrawer('تسجيل الخروج', Icons.power_settings_new),
                      onPressed: () {
                        Navigator.pushNamed(context, "/RegistrationScreen");
                      }),
                ])),
          )),
          body: RefreshIndicator(
    key: _refreshIndicatorKey,
    onRefresh: _refresh,
    child:
          
           FutureBuilder(
            future: _patient,
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                return ListView(
                  padding: EdgeInsets.only(top:25,right:5,left:5,),
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 25),
                      alignment: Alignment.topRight,
                      child: Text(
                          'اخر ردود الاستعلامات ' + snapShot.data.firstName,
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
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
                                    setState(() {});
                                    Navigator.pushNamed(
                                        context, "/QueriesReplaies");
                                  },
                                  color: Colors.deepOrangeAccent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Text(
                                    "عرض الكل",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ))
                          ],
                        )),
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        //padding: EdgeInsets.all(5),
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(children: []))
                  ],
                );
              }
              return Center(
                  child: SpinKitFadingCircle(
                color:Color(0xFF87C9BF),
                size: 55,
              ));
            },
          ),
        )));
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
  Future<Patient> _refresh(){
    setState(() {
      _patient= widget.model.getPatient();
    });
   return _patient;
  }
}
