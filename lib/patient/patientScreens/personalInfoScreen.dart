import 'dart:io';

import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/pages/ui_widgets/doneWidget.dart';
import 'package:allo_doctor/pages/ui_widgets/wrongWidget.dart';
import 'package:allo_doctor/patient/input_form/image_input.dart';
import 'package:allo_doctor/patient/patientScreens/changePassword.dart';
//import 'package:allo_doctor/patient/input_form/image_input.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PesronalinfoScreen extends StatefulWidget {
  final MainModel model;
  PesronalinfoScreen(this.model);
  @override
  _PesronalinfoScreen createState() => _PesronalinfoScreen();
}

class _PesronalinfoScreen extends State<PesronalinfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Future<Patient> _patient;
  bool changed = false;

  final Map<String, dynamic> _formData = {
    "firstName": null,
    "lastName": null,
    "email": null,
    "password": null,
    "birthdate": null,
    "image": null
  };

  @override
  void initState() {
    widget.model.getPatient().then((_) {
      setState(() {
        _patient = widget.model.getPatient();
        _formData["image"] = widget.model.patient.avatar
            .toString(); //File(widget.model.patient.avatar);
      
      });
    });


    super.initState();
  }

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
        decoration: BoxDecoration(gradient: mainColor),
        child: Scaffold(
            backgroundColor: Color(0xFF00000),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color(0xFF0000),
            ),
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                    key: _formKey,
                    child: FutureBuilder(
                        future: _patient,
                        builder: (context, snapShot) {
                          if (snapShot.hasData) {
                            String _birthdate = snapShot.data.birthdate;
                            return ListView(children: <Widget>[
                              Center(
                                  child: Container(
                                      height: 250,
                                      child: Column(children: [
                                        Container(
                                            child: CircleAvatar(
                                                radius: 100,
                                                backgroundColor: Colors.white,
                                                child: ClipOval(
                                                    child: SizedBox(
                                                        width: 195.0,
                                                        height: 195.0,
                                                        child: //Image.file(_formData["image"])
                                                            // snapShot.data.avatar == ""?
                                                            _formData["image"] ==
                                                                    ""
                                                                ? Image.asset(
                                                                    'assets/Patient.png',
                                                                    fit: BoxFit
                                                                        .fill)
                                                                :
                                                                // Image.file(File(snapShot.data.avatar))
                                                                Image.file(
                                                                    File(
                                                                      _formData[
                                                                          "image"],
                                                                    ),
                                                                    fit: BoxFit
                                                                        .fill))))),
                                        SizedBox(height: 1),
                                        Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 110),
                                            child: ImageInput(
                                                _setImage, snapShot.data))
                                      ]))),

                              // (
                              //   textDirection: TextDirection.rtl,
                              //   children: <Widget>[
                              //     Align(
                              //         child: CircleAvatar(
                              //       radius: 100,
                              //       backgroundColor: Colors.white,
                              //       child: ClipOval(
                              //         child: SizedBox(
                              //             width: 195.0,
                              //             height: 195.0,
                              //             child: snapShot.data.avatar == ""
                              //                 ? Image.asset(
                              //                     'assets/Patient.png',
                              //                     fit: BoxFit.fill)
                              //                 : Image.network(
                              //                     snapShot.data.avatar)
                              //             // child: (_image!=null)?Image.file(
                              //             //   _image,
                              //             //   fit: BoxFit.fill,
                              //             // ):Image.network(
                              //             //   "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                              //             //   fit: BoxFit.fill,
                              //             ),
                              //       ),
                              //     )),
                              // Positioned(
                              //     right: 150,
                              //     top: 178,
                              //     width: 100,
                              //     height: 26,
                              //     child: RaisedButton(
                              //         padding: EdgeInsets.symmetric(
                              //             horizontal: 12.0),
                              //         shape: RoundedRectangleBorder(
                              //           side: BorderSide(
                              //             style: BorderStyle.none,
                              //           ),
                              //         ),
                              //         color: Colors.black.withOpacity(0.05),
                              //         //  padding: EdgeInsets.only(top: 150.0, right: 130),
                              //         child: editButton(),
                              //         onPressed: () {
                              //           _openImagePicker(context);

                              SizedBox(height: 20.0),
                              Container(
                                  margin: EdgeInsets.only(right: 30.0),
                                  child: Text('الاسم الأول',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.white))),
                             
                              firstName(snapShot.data),
                              SizedBox(height: 15),
                              Container(
                                  margin: EdgeInsets.only(right: 30.0),
                                  child: Text(
                                    'اسم العائلة',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(color: Colors.white),
                                  )),
                              lastName(snapShot.data),
                              SizedBox(height: 10),
                              Container(
                                  margin: EdgeInsets.only(right: 30.0),
                                  child: Text('البريد الإلكتروني',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.white))),
                              SizedBox(height: 5),
                              emailAdress(snapShot.data),
                           
                              SizedBox(height: 10.0),
                              Container(
                                  margin: EdgeInsets.only(right: 30.0),
                                  child: Text('كلمة المرور',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.white))),
                              SizedBox(height: 5),
                              GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.only(left:140,right: 20),
                                  padding: EdgeInsets.only(bottom:10,top:10,right:10),
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrangeAccent,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text('تغيير كلمة المرور ',textAlign: TextAlign.right,style: TextStyle(color: Colors.white),),
                                ),
                                onTap: (){
                                 Navigator.of( context).push(
              MaterialPageRoute(builder: (context) => ChangePassword()));
                                },
                              ),
                             // password(snapShot.data),
                              SizedBox(height: 10.0),
                              Container(
                                  margin: EdgeInsets.only(right: 25, left: 20),
                                  child: Text(
                                    'تاريخ الميلاد',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.0),
                                  )),
                              SizedBox(height: 10.0),
                              Container(
                                  margin: EdgeInsets.only(right: 22, left: 22),
                                  child: DatePickerWidget(
                                      onChange:
                                          (DateTime value, selectedIndex) {
                                        setState(() {
                                          changed =true;
                                          _birthdate =
                                              value.toUtc().toIso8601String();
                                          _formData["birthdate"] =
                                              value.toUtc().toIso8601String();
                                        });
                                      },
                                      initialDateTime: DateTime.parse(
                                          snapShot.data.birthdate),
                                      minDateTime: DateTime(1930),
                                      maxDateTime: DateTime(2020),
                                      locale: DateTimePickerLocale.ar,
                                      pickerTheme: DateTimePickerTheme(
                                          showTitle: false,
                                          pickerHeight: 60.0,
                                          itemTextStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18)))),
                              SizedBox(height: 25.0),

                              //  (_firstNameController.text == snapShot.data.firstName &&_lastNameController.text ==snapShot.data.lastName && _emailController.text==snapShot.data.email&& _birthdate ==snapShot.data.birthdate)?
                              //  saveButton(null):
                              changed == true?
                              saveButton(() async {
                            
                                // await widget.model.uploadImage(_formData["image"]);
                                await widget.model
                                    .updatePatientData(
                                        firstName: _firstNameController.text,
                                        lastName: _lastNameController.text,
                                        email: _emailController.text,
                                        birthdate: _birthdate,
                                        avatar: _formData["image"].toString())
                                    .then((_) {
                                  if (widget.model.statusCodes == 204) {
                                    doneWidget(context);
                                    Future.delayed(Duration(seconds: 1))
                                        .then((_) {
                                      Navigator.pushNamed(
                                          context, "/homeScreenPatient");
                                    });
                                  } else {
                                    print(widget.model.statusCodes);
                                    wrongWidget(context);
                                    Future.delayed(Duration(seconds: 1))
                                        .then((_) {
                                      Navigator.pop(context);
                                    });
                                  }
                                });
                              }) 
                              :saveButton(null)
                              ,
                              SizedBox(height: 15)
                            ]);
                          }
                          return Center(
                              child: SpinKitFadingCircle(
                            color: Color(0xFF87C9BF),
                            size: 30,
                          ));
                        })))));
  }

  void _setImage(File image) {     
    setState(() {
      changed = true;
    if (image.path != null) {
        _formData['image'] = image.path.toString();
    }
    });
      
  }

  Widget firstName(dynamic snapShot) {
    if (_patient == null && _firstNameController.text.trim() == '') {
      _firstNameController.text = '';
    } else if (_patient != null && _firstNameController.text.trim() == '') {
      _firstNameController.text = snapShot.firstName;
    } else if (_patient != null && _firstNameController.text.trim() != '') {
      _firstNameController.text = _firstNameController.text;
    } else if (_patient == null && _firstNameController.text.trim() != '') {
      _firstNameController.text = _firstNameController.text;
    } else {
      _firstNameController.text = '';
    }
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          controller: _firstNameController,
          style: TextStyle(color: Colors.black),
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0))),
          onChanged: (String value) {
            setState(() {
                changed = true;
               _formData["firstName"] = value;
            
            });
           
          },
        ));
  }

  Widget lastName(dynamic snapShot) {
    if (_patient == null && _lastNameController.text.trim() == '') {
      _lastNameController.text = '';
    } else if (_patient != null && _lastNameController.text.trim() == '') {
      _lastNameController.text = snapShot.lastName;
    } else if (_patient != null && _lastNameController.text.trim() != '') {
      _lastNameController.text = _lastNameController.text;
    } else if (_patient == null && _lastNameController.text.trim() != '') {
      _lastNameController.text = _lastNameController.text;
    } else {
      _lastNameController.text = '';
    }

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          controller: _lastNameController,
          style: TextStyle(color: Colors.black),
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0))),
          onSaved: (String value) {
            setState(() {
              changed = true;
                _formData["lastName"] = value;
            });
          
          },
        ));
  }

  Widget emailAdress(dynamic snapShot) {
    if (_patient == null && _emailController.text.trim() == '') {
      _emailController.text = '';
    } else if (_patient != null && _emailController.text.trim() == '') {
      _emailController.text = snapShot.email;
    } else if (_patient != null && _emailController.text.trim() != '') {
      _emailController.text = _emailController.text;
    } else if (_patient == null && _emailController.text.trim() != '') {
      _emailController.text = _emailController.text;
    } else {
      _emailController.text = '';
    }
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          controller: _emailController,
          style: TextStyle(color: Colors.black),
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0))),
          onSaved: (String value) {
            setState(() {
              changed = true;
              _formData["email"] = value;
            //  _check();
            });
          },
        ));
  }

  Widget password(dynamic snapShot) {
    if (_patient == null && _passwordController.text.trim() == '') {
      _passwordController.text = '';
    } else if (_patient != null && _passwordController.text.trim() == '') {
      _passwordController.text = snapShot.lastName;
    } else if (_patient != null && _passwordController.text.trim() != '') {
      _passwordController.text = _passwordController.text;
    } else if (_patient == null && _passwordController.text.trim() != '') {
      _passwordController.text = _passwordController.text;
    } else {
      _passwordController.text = '';
    }

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          controller: _passwordController,
          style: TextStyle(color: Colors.black),
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0))),
          onSaved: (String value) {
            setState(() {
              changed = true;
              _formData["password"] = value;
             
            });
          },
        ));
  }

  Widget editButton() {
    return Row(textDirection: TextDirection.rtl, children: <Widget>[
      Icon(
        Icons.edit,
        size: 15.0,
        color: Colors.white,
      ),
      Text(
        'تغيير الصورة',
        textAlign: TextAlign.end,
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
    ]);
  }

  Widget saveButton(Function function) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 60.0),
        height: 40.0,
        child: RaisedButton(
            color: Colors.deepOrangeAccent,
            textColor: Colors.white,
            child: Text(
              'حفظ',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            //padding: EdgeInsets.symmetric(horizontal: 60.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            onPressed: function));
  }

// void _submitForm(
//       dynamic updateProduct,) {
//     if (!_formKey.currentState.validate()
//         ) {
//       return;
//     }
//     _formKey.currentState.save();
//   //  if (){

//   //   } else {
//       updateProduct(
//         _firstNameController.text,
//         _lastNameController.text,
//         _emailController.text,
//       ).then((_){
//         setState(() {
//           _patient;
//         });
//       });
//        }

}
