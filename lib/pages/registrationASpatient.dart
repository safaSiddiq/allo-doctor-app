import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/pages/ui_widgets/registrationRow.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

//import 'package:flutter/cupertino.dart';
class RegistrationASpatient extends StatefulWidget {

  final MainModel model;
  RegistrationASpatient(this.model);

  @override
  State<StatefulWidget> createState() {
    return _RegistrationASpatient();
  }
}

class _RegistrationASpatient extends State<RegistrationASpatient> {

 //@override
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Patient _patient;
 
  Patient get patient{
    if (_patient == null ){
      _patient = Patient();
    }
  return _patient;
  }
  String _selectedText = 'الجنس';
  

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );
  _onPressed(){
    // setState(() {
    //   if(_emailController.text.trim().toLowerCase().isNotEmpty &&
    //       _passwordController.text.trim().isNotEmpty ){
        widget.model.registrationPatient(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
      _emailController.text.trim().toLowerCase(),
         patient.gender,
     patient.birthdate,
           _userNameController.text,
           _passwordController.text.trim()).whenComplete((){
             print(patient.firstName);
          // if(registrationPatient.status){
          //   _showDialog();
          //   msgStatus = 'Check email or password';
          // }else{
          //  Navigator.pushReplacementNamed(context, '/dashboard');


         // }
      //  });
     // }
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(gradient: mainColor),
        child: Scaffold(
            backgroundColor: Color(0xFF00000),
            appBar: AppBar(
              backgroundColor: Color(0xFF0000),
              elevation: 0,
            ),
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Form(
                  key: _formKey,
                  child: ListView(children: <Widget>[
                    firstName(),
                    SizedBox(height: 10.0),
                    lastName(),
                    SizedBox(height: 10.0),
                    emailAdress(),
                    SizedBox(height: 20.0),
                    Text(
                      'تاريخ الميلاد',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    SizedBox(height: 10.0),
                    DatePickerWidget(
                        onChange: (DateTime value, selectedIndex) {
                          setState(() {
                            patient.birthdate = value.toString();
                          });  
                        },
                      
                        initialDateTime: DateTime(1980),
                        minDateTime: DateTime(1980),
                        maxDateTime: DateTime(2020),
                        locale: DateTimePickerLocale.ar,
                        pickerTheme: DateTimePickerTheme(
                            showTitle: false,
                            pickerHeight: 60.0,
                            itemTextStyle:
                                TextStyle(color: Colors.black, fontSize: 18))),
                    SizedBox(height: 15.0),
                    Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: 45.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0)),
                        margin: EdgeInsets.only(
                          left: 170.0,
                        ),
                        child: DropdownButtonHideUnderline(child: 
                     DropdownButton<String>(
                       icon: Container(
                         padding: EdgeInsets.only(left:5,right: 2),
                         child: Icon(Icons.arrow_drop_down,size: 24,color: Color(0xFF2B95AF),),
                       ), 
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Tajawal-Medium'),
                          //hint: Text('الجنس'),
                          value: _selectedText,
                         
                          items: <String>['الجنس', 'ذكر', 'أنثى']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                             onChanged: (String val) {
                          //  _selectedText = val;
                            setState(() {            
                                _selectedText = val;
                                patient.gender=val;
                            });   
                            },
                        ))),
                    SizedBox(height: 5.0),
                    userName(),
                    SizedBox(height: 10.0),
                    passwordField(),
                    SizedBox(height: 20.0),
                    registrationButton((){
                      _onPressed();
                      // widget.model.registrationPatient(patient.firstName, patient.lastName,
                      //  patient.gender, patient.birthdate,
                      //   patient.email, patient.userName, patient.password);
                    }),
                    SizedBox(height: 10.0),
                    registrationRow(() {
                      Navigator.pushReplacementNamed(context, "/LoginScreen");
                    })
                  ]),
                ))));
  }


 Widget firstName() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: _firstNameController,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0)),
            labelText: 'الاسم الأول',
            labelStyle: TextStyle(color: Colors.white, fontSize: 18),
          ),
          keyboardType: TextInputType.text,
          cursorColor: Colors.white,
          onSaved: (String value) {
            patient.firstName = value;
            
          },
        ));
  }









 

  Widget lastName() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: _lastNameController,
          decoration: InputDecoration(
              labelText: 'اسم العائلة',
              labelStyle: TextStyle(color: Colors.white, fontSize: 18),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0))),
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.white,
          onSaved: (String value) {
            patient.lastName = value;
          },
        ));
  }

  Widget emailAdress() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'البريد الالكتروني',
            labelStyle: TextStyle(color: Colors.white, fontSize: 18),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0)),
          ),
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.white,
          onSaved: (String value) {
            patient.email = value;
          },
        ));
  }

  Widget userName() {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: _userNameController,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          labelText: 'اسم المستخدم',
          labelStyle: TextStyle(color: Colors.white,fontSize: 18),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2.0)),
        ),
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.white,
        onSaved: (String value){
          setState(() {
              patient.userName=value;
          });
        },
      ));
 }

 Widget passwordField() {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: _passwordController,
          decoration: InputDecoration(
              labelText: 'كلمة المرور',
              labelStyle: TextStyle(color: Colors.white,fontSize: 18),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white,width: 2.0))),
          keyboardType: TextInputType.visiblePassword,
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.white),
          onSaved: (String value){
            setState(() {
              patient.password=value;
            });
          },
          ));
 }

 Widget registrationButton(Function function) {
    return Container(
      height: 43.0,
      child:
    RaisedButton(
        color: Colors.deepOrangeAccent,
        textColor: Colors.white,
        child: Text(
          ' إنشاء حساب',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: function
        // (){  
      // Navigator.pushReplacementNamed(context, "/HomeScreenPatient");
       // }) 
    ));
  }
}
