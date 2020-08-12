import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/query.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreenDr extends StatefulWidget {
  final MainModel model;
  HomeScreenDr(this.model);
  @override
  _HomeScreenDrState createState() => _HomeScreenDrState();
}

class _HomeScreenDrState extends State<HomeScreenDr> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  bool _isDisabled = false;
  int value = 0;

  final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );
 List<Query> _queries;
 
  Future<Doctor> _doctor;
  @override
  void initState() {
    
    widget.model.getDoctor().then((_) {
      setState(() {
        _doctor = widget.model.getDoctor();
      });
    });

    widget.model.getQueries().then((_) {
      setState(() {
        _queries = widget.model.queries;
      });
    });

    super.initState();
  }

  Widget acceptQuery() {
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
                  _isDisabled = true;
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => QueryView()));
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
                  _isDisabled = false;
                });
              })
        ],
      ),
    );
  }

  Widget qoueryPreview(String name) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            value == 0 && (value != 1 && value != 2)
                ? Container(
                    height: 9,
                    width: 9,
                    decoration: BoxDecoration(
                      //   border: Border.all(
                      //     color: Colors.white,
                      //     //width: 1,
                      //   ),
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  )
                : Container(),
            Text(
              "قام",
              style: TextStyle(fontSize: 12),
            ),
            Text(name),
            Text(
              'بارسال استعلام',
              style: TextStyle(fontSize: 12),
            ),
            value == 0 && (value != 1 && value != 2)
                ? Container(
                    height: 30,
                    width: 110,
                    child: acceptQuery(),
                  )
                : Container(
                    height: 30,
                    width: 110,
                    child: value == 1 && value != 0
                        ? acceptButton()
                        : declineButton())
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    //MainModel model;
    return Container(
        decoration: BoxDecoration(gradient: mainColor),
        child: Scaffold(
            backgroundColor: Color(0xFF00000),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Color(0xFF0000),
              actions: <Widget>[
                FutureBuilder(
                    future: _doctor,
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
                                            child:
                                                snapShot.data.avatar == "null"
                                                    ? Image.asset(
                                                        "assets/Doctor.png",
                                                        fit: BoxFit.fill)
                                                    : Image.network(
                                                        snapShot.data.avatar,
                                                        fit: BoxFit.fill)))),
                              
                              ],
                            ));
                      } else {
                        return Center(
                            child: SpinKitFadingCircle(
                          color: Color(0xFF87C9BF),
                          size: 30,
                        ));
                      }
                    })
              ],
            ),
            endDrawer: Drawer(
                child: Container(
                    decoration: BoxDecoration(color: Color(0xFF174160)),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            color: Colors.deepOrange),
                        child: ListView(children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(right: 10, left: 20),
                              child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: FutureBuilder(
                                      future: _doctor,
                                      builder: (context, snapShot) {
                                        if (snapShot.hasData) {
                                          return UserAccountsDrawerHeader(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                color: Colors.teal,
                                              ))),
                                              //margin: EdgeInsets.only(left:100.0),
                                              accountName: Text("د." +
                                                  " " +
                                                  snapShot.data.firstName +
                                                  "  " +
                                                  snapShot.data.lastName),
                                              accountEmail:
                                                  Text(snapShot.data.email),
                                              currentAccountPicture: Stack(
                                                children: <Widget>[
                                                  CircleAvatar(
                                                      radius: 41,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: ClipOval(
                                                          child: SizedBox(
                                                              width: 70.0,
                                                              height: 70.0,
                                                              child: snapShot
                                                                          .data
                                                                          .avatar ==
                                                                      "null"
                                                                  ? Image.asset(
                                                                      'assets/Doctor.png',
                                                                      fit: BoxFit
                                                                          .fill)
                                                                  : Image.network(
                                                                      snapShot
                                                                          .data
                                                                          .avatar)))),
                                                ],
                                              ));
                                        } else {
                                          return Center(
                                              child: SpinKitFadingCircle(
                                            color: Color(0xFF87C9BF),
                                            size: 30,
                                          ));
                                        }
                                      }))),
                          RawMaterialButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/Queries");
                            },
                            child: iconDrawer("الاستعلامات", Icons.inbox),
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/DrMessageScreen");
                            },
                            child: iconDrawer("الرسائل", Icons.mail),
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/PatientsScreen");
                            },
                            child: iconDrawer("المرضى", Icons.people),
                          ),
                          RawMaterialButton(
                            onPressed: () {},
                            child: iconDrawer(
                                "مركز الاتصالات", Icons.contact_phone),
                          ),
                          RawMaterialButton(
                            onPressed: () {},
                            child: iconDrawer("تواصل معنا", Icons.phone),
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //         builder: (context) =>
                              //           PersonalDr(model)));
                              Navigator.pushNamed(context, "/DrPersonalInfo");
                            },
                            child: iconDrawer("بيانات شخصية", Icons.settings),
                          ),
                          RawMaterialButton(
                            onPressed: () {},
                            child: iconDrawer(
                                "تسجيل خروج", Icons.power_settings_new),
                          ),
                        ])))),
            body: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _refresh,
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: FutureBuilder(
                        future: _doctor,
                        builder: (context, snapShot) {
                          if (snapShot.hasData) {
                            return ListView(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 25),
                                  alignment: Alignment.topRight,
                                  child: Text('اخر الاستعلامات ',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        // Container(
                                        //   alignment: Alignment.center,
                                        //   padding: EdgeInsets.all(20),
                                        //   child: Text('لا يوجد ردود استعلامات'),
                                        // ),
                                        // ListView.builder(
                                        //   itemCount: _queries.length,
                                        //   itemBuilder: (context,index)=>qoueryPreview("name")),
                                        qoueryPreview("name"),
                                        SizedBox(height: 10),
                                        Container(
                                            height: 35,
                                            alignment: Alignment.bottomCenter,
                                            decoration: BoxDecoration(),
                                            child: RaisedButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, "/Queries");
                                              },
                                              color: Colors.deepOrangeAccent,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                              child: Text(
                                                "عرض الكل",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                            )),
                                        SizedBox(height: 10)
                                      ],
                                    )),
                                SizedBox(height: 20),
                                Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      ' استعلامات عامة',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    )),
                                SizedBox(height: 5),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Column(children: [
                                      qoueryPreview(''),
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          height: 35,
                                          alignment: Alignment.bottomCenter,
                                          decoration: BoxDecoration(),
                                          child: RaisedButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, "/Queries");
                                            },
                                            color: Colors.deepOrangeAccent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                            child: Text(
                                              "عرض الكل",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ))
                                    ]))
                              ],
                            );
                          } else {
                            return Center(
                                child: SpinKitFadingCircle(
                              color: Color(0xFF87C9BF),
                              size: 40,
                            ));
                          }
                        })))));
  }

  Future _refresh() {
    widget.model.getDoctor().then((_) {
      setState(() {
        _doctor = widget.model.getDoctor();
      });
    });
    widget.model.getQueries().then((_) {
      setState(() {
        _queries = widget.model.queries;
      });
    });

    return _doctor;
  }

  Widget acceptButton() {
    return RawMaterialButton(
        onPressed: () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => QueryView()));
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

Widget iconDrawer(String title, IconData icon) {
  return Row(
    textDirection: TextDirection.rtl,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(right: 2.0),
        height: 50.0,
        width: 65.0,
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
      SizedBox(width: 1.0),
      Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 16.0),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
      )
    ],
  );
}
