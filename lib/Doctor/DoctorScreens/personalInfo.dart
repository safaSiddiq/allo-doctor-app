import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/pages/ui_widgets/doneWidget.dart';
import 'package:allo_doctor/patient/patientScreens/medicalFile.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DrPersonalInfo extends StatefulWidget {
  final MainModel model;

  DrPersonalInfo(this.model);
  @override
  _DrPersonalInfoState createState() => _DrPersonalInfoState();
}

class _DrPersonalInfoState extends State<DrPersonalInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final myController = TextEditingController();
  String inputData = "";
  bool boolValue = false;

  final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );

  final Map<String, dynamic> _formData = {
    "firstName": null,
    "lastName": null,
    "email": null,
    "bio": null,
    "birthdate": null
  };

  Future<Doctor> getDoctor() async {
    var id = "d44adeef-03fe-4af6-8ef0-b6c7db377d2f";
    http.Response response = await http.get(
      //  "http://192.168.1.36:3000/patients/$_patientId",

      // "http://34.71.92.1:3000/doctors/$_doctorId",//1fef50ee-7c82-4a6e-9de5-db5a1ed0ec07
      "http://34.71.92.1:3000/doctors/$id",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
    print("response stuse get info dr :${response.statusCode}");
    print("response body :${response.body}");

    var _doctorData = json.decode(response.body);
    var _newDoctor = Doctor(
      //  patientId: _patientId,
      doctorId: _doctorData['doctorId'],
      firstName: _doctorData['firstName'],
      lastName: _doctorData['lastName'],
      birthdate: _doctorData["birthdate"],
      gender: _doctorData["gender"],
      major: _doctorData["major"],
      avatar: _doctorData["avatar"],
      bio: _doctorData["bio"],
      email: _doctorData["email"],
    );
    return _newDoctor;
    // return Patient.fromJson(json.decode(response.body));
  }

  Future<Doctor> _doctor;
  @override
  void initState() {
    // widget.model.getDoctor().then((_) {
    //   setState(() {
    //     _doctor = widget.model.getDoctor();
    //   });
    // });
    getDoctor().then((_) {
      setState(() {
        _doctor = getDoctor();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return  ScopedModelDescendant<MainModel>(
    //     builder: (BuildContext context, Widget child, MainModel model) {

    //   model.getDoctor().then((_){
    //   setState(() {
    //     _doctor =model.getDoctor();
    //   });
    // });
    return Container(
        decoration: BoxDecoration(gradient: mainColor),
        child: Scaffold(
            backgroundColor: Color(0xFF0000),
            appBar: AppBar(
              backgroundColor: Color(0xFF0000),
              elevation: 0,
            ),
            body: FutureBuilder(
                future: _doctor,
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    String _birthdate = snapShot.data.birthdate;
                    return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              Center(
                                  child: Container(
                                      height: 250,
                                      child: Stack(children: [
                                        Container(
                                            child: CircleAvatar(
                                                radius: 100,
                                                backgroundColor: Colors.white,
                                                child: ClipOval(
                                                    child: SizedBox(
                                                        width: 195.0,
                                                        height: 195.0,
                                                        child: Image.asset(
                                                            'assets/Doctor.png',
                                                            fit: BoxFit
                                                                .fill))))),
                                        SizedBox(height: 1),
                                        Positioned(
                                            right: 50,
                                            top: 200,
                                            width: 100,
                                            height: 26,
                                            //  Container(
                                            //     margin: EdgeInsets.only(right:80,left:120,bottom: 100),
                                            //     padding: EdgeInsets.only(right:18,left:20,bottom: 10),
                                            child: RaisedButton(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.0),
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    style: BorderStyle.none,
                                                  ),
                                                ),
                                                color: Colors.grey
                                                    .withOpacity(0.05),
                                                //  padding: EdgeInsets.only(top: 150.0, right: 130),
                                                child: editButton(),
                                                onPressed: () {})),
                                      ]))),
                              SizedBox(height: 5),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Text(
                                      'د.  ' + snapShot.data.firstName + "  "+snapShot.data.lastName
                                     ,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                       snapShot.data.major,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(right: 25),
                                child: Text(
                                  'الاسم الأول',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              firstName(snapShot.data),
                              SizedBox(height: 15),
                              Container(
                                margin: EdgeInsets.only(right: 25),
                                child: Text(
                                  'اسم العائلة',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              lastName(snapShot.data),
                              SizedBox(height: 15),
                              Container(
                                margin: EdgeInsets.only(right: 25),
                                child: Text(
                                  'كلمة المرور',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              password(snapShot.data),
                              SizedBox(height: 20.0),
                              Container(
                                  margin: EdgeInsets.only(right: 25),
                                  child: Text(
                                    'البريد الالكتروني',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  )),
                              SizedBox(height: 5.0),
                              Container(
                                padding:
                                    EdgeInsets.only(top: 10, right: 5, left: 5,bottom: 5),
                                margin: EdgeInsets.symmetric(horizontal: 20,),
                                
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.white),
                                child: Column(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    // ListTile(
                                    //   title:emailAdress(snapShot.data),
                                    // ),
                                  emailAdress(snapShot.data),
                                      
                                    Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        alignment: Alignment.bottomCenter,
                                        child: addDeleteButtons())
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                  margin: EdgeInsets.only(right: 25),
                                  child: Text(
                                    'أرقام الهواتف',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  )),
                              SizedBox(height: 5.0),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                padding:
                                    EdgeInsets.only(top: 10, right: 5, left: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                child: Column(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    CheckboxListTile(
                                        title: Text(
                                          inputData,
                                          textDirection: TextDirection.rtl,
                                        ),
                                        value: boolValue,
                                        onChanged: (bool value) {
                                          setState(() {
                                            boolValue = true;
                                          });
                                        }),
                                    Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        alignment: Alignment.bottomCenter,
                                        child: addDeleteButtons())
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                  margin: EdgeInsets.only(right: 25),
                                  child: Text(
                                    'تاريخ الميلاد',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  )),
                              SizedBox(height: 10.0),
                              Container(
                                  margin: EdgeInsets.only(right: 25, left: 25),
                                  child: DatePickerWidget(

                                     onChange:
                                          (DateTime value, selectedIndex) {
                                        setState(() {
                                      _birthdate =
                                              value.toUtc().toIso8601String();
                                          _formData["birthdate"] =
                                              value.toUtc().toIso8601String();
                                        });
                                      },
                                      initialDateTime:  DateTime.parse(
                                          snapShot.data.birthdate),
                                      minDateTime: DateTime(1980),
                                      maxDateTime: DateTime(2020),
                                      locale: DateTimePickerLocale.ar,
                                      pickerTheme: DateTimePickerTheme(
                                          showTitle: false,
                                          pickerHeight: 60.0,
                                          itemTextStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18)))),
                              SizedBox(height: 15.0),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(right: 25),
                                child: Text(
                                  'محل الإقامة',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                  child: Text("")
                                  //TextField(textDirection: TextDirection.rtl)
                                  ),
                              SizedBox(height: 30),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.place,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {}),
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
                                  padding: EdgeInsets.only(
                                      top: 10, right: 5, left: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          alignment: Alignment.bottomCenter,
                                          child: addDeleteButtons())
                                    ],
                                  )),
                              SizedBox(height: 30),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.slideshow,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {}),
                                        Text(
                                          'السيرة الذاتية',
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        )
                                      ])),
                              bio(snapShot.data),
                              SizedBox(height: 20),
                              saveButton(() async {
                                await widget.model
                                    .updateDoctorData(
                                        firstName: _firstNameController.text,
                                        lastName: _lastNameController.text,
                                        bio: _bioController.text,
                                      //  email: _emailController.text,
                                        birthdate: _birthdate)
                                    .then((_) {
                                  doneWidget(context);
                                  Future.delayed(Duration(seconds: 1))
                                      .then((_) {
                                    Navigator.pushNamed(
                                        context, "/HomeScreenDr");
                                  });
                                });
                              })
                            ],
                          ),
                          // ))
                        ));
                  } else {
                    return Center(
                        child: SpinKitFadingCircle(
                      color: Color(0xFF87C9BF),
                      size: 30,
                    ));
                  }
                })));
    //   });
  }

  Widget editButton() {
    return Row(textDirection: TextDirection.rtl,
        // padding: EdgeInsets.only(top: 170.0,left:120),
        children: <Widget>[
          //padding: EdgeInsets.only(top: 170.0,left:120),

          Icon(
            Icons.edit,
            size: 15.0,
            color: Colors.white,
          ),
          // onPressed: () {
          //   //getImage();
          // },
          Text(
            'تغيير الصورة',
            textAlign: TextAlign.end,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ]);
  }

  Widget firstName(dynamic snapShot) {
    if (_doctor == null && _firstNameController.text.trim() == '') {
      _firstNameController.text = '';
    } else if (_doctor != null && _firstNameController.text.trim() == '') {
      _firstNameController.text = snapShot.firstName;
    } else if (_doctor != null && _firstNameController.text.trim() != '') {
      _firstNameController.text = _firstNameController.text;
    } else if (_doctor == null && _firstNameController.text.trim() != '') {
      _firstNameController.text = _firstNameController.text;
    } else {
      _firstNameController.text = '';
    }
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          controller: _firstNameController,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0))),
          onChanged: (String valure) {},
        ));
  }

  Widget lastName(dynamic snapShot) {
    if (_doctor == null && _lastNameController.text.trim() == '') {
      _lastNameController.text = '';
    } else if (_doctor != null && _lastNameController.text.trim() == '') {
      _lastNameController.text = snapShot.lastName;
    } else if (_doctor != null && _lastNameController.text.trim() != '') {
      _lastNameController.text = _lastNameController.text;
    } else if (_doctor == null && _lastNameController.text.trim() != '') {
      _lastNameController.text = _lastNameController.text;
    } else {
      _lastNameController.text = '';
    }
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          controller: _lastNameController,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0))),
          onChanged: (String valure) {},
        ));
  }

  Widget emailAdress(dynamic snapShot) {
    if (_doctor == null && _emailController.text.trim() == '') {
      _emailController.text = '';
    } else if (_doctor != null && _emailController.text.trim() == '') {
      _emailController.text = snapShot.email;
    } else if (_doctor != null && _emailController.text.trim() != '') {
      _emailController.text = _emailController.text;
    } else if (_doctor == null && _emailController.text.trim() != '') {
      _emailController.text = _emailController.text;
    } else {
      _emailController.text = '';
    }
    return Container(
      //  margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0))),
          onChanged: (String valure) {},
        ));
  }

  Widget password(dynamic snapShot) {
    if (_doctor == null && _passwordController.text.trim() == '') {
      _passwordController.text = '';
    } else if (_doctor != null && _passwordController.text.trim() == '') {
      _passwordController.text = snapShot.email;
    } else if (_doctor != null && _passwordController.text.trim() != '') {
      _passwordController.text = _passwordController.text;
    } else if (_doctor == null && _passwordController.text.trim() != '') {
      _passwordController.text = _passwordController.text;
    } else {
      _passwordController.text = '';
    }
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          controller: _passwordController,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0))),
          onChanged: (String valure) {},
        ));
  }


Widget bio(dynamic snapShot){
     if (_doctor == null && _bioController.text.trim() == '') {
      _bioController.text = '';
    } else if (_doctor != null && _bioController.text.trim() == '') {
      _bioController.text = snapShot.bio;
    } else if (_doctor != null && _bioController.text.trim() != '') {
      _bioController.text = _bioController.text;
    } else if (_doctor == null && _bioController.text.trim() != '') {
      _bioController.text = _bioController.text;
    } else {
      _bioController.text = '';
    }
  return Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          controller: _bioController,
          textDirection: TextDirection.rtl,
          maxLines:10,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0))),
          onChanged: (String valure) {},
        ));
}
  Widget changeButton() {
    return RawMaterialButton(
        onPressed: () {},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.tealAccent, borderRadius: BorderRadius.circular(8)),
          child: Text('تغيير'),
        ));
  }

  Widget addDeleteButtons() {
    return Container(
        // alignment: Alignment.bottomLeft,
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RaisedButton(
            color: Colors.teal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'اضافة',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.add,
                  color: Colors.white,
                )
              ],
            ),
            onPressed: () {
              return showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AlertDialog(
                          content: TextFormField(
                            controller: myController,
                            textDirection: TextDirection.rtl,
                            onSaved: (String value) {
                             
                            },
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.deepOrangeAccent),
                            child: RawMaterialButton(
                              onPressed: () {
                                setState(() {
                                  inputData = myController.text;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(
                                "تم",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ))
                      ],
                    ));
                  });
            }),
        RaisedButton(
            color: Colors.red,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'حذف',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 5),
                Container(
                    margin: EdgeInsets.only(bottom: 13),
                    child: Icon(
                      Icons.minimize,
                      color: Colors.white,
                    ))
              ],
            ),
            onPressed: () {})
      ],
    ));
  }

  
}
