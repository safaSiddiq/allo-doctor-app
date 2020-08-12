import 'package:allo_doctor/pages/ui_widgets/onLoading.dart';
import 'package:allo_doctor/pages/ui_widgets/registrationRow.dart';
import 'package:allo_doctor/pages/ui_widgets/wrongWidget.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

//import 'package:flutter_holo_date_picker/date_time_formatter.dart';
import 'package:scoped_model/scoped_model.dart';

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

  String _selectedText = 'الجنس';

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  DateTime _birthdata;
  String _gender;

  final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );


  //_onPressed(){
  // setState(() {
  //   if(_emailController.text.trim().toLowerCase().isNotEmpty &&
  //       _passwordController.text.trim().isNotEmpty ){
  //     widget.model.registrationPatient(
  //     _firstNameController.text.trim(),
  //     _lastNameController.text.trim(),
  //   _emailController.text.trim().toLowerCase(),
  //      patient.gender,
  //  patient.birthdate,
  //  _userNameController.text,
  // _passwordController.text.trim()).whenComplete((){
  // print(patient.firstName);
  // if(registrationPatient.status){
  //   _showDialog();
  //   msgStatus = 'Check email or password';
  // }else{
  //  Navigator.pushReplacementNamed(context, '/dashboard');
  // }//  });// }//   })// }

  _onPressed() async {
    await widget.model.registrationPatient(
      firstName:_firstNameController.text,
      lastName:_lastNameController.text,
      email: _emailController.text,
      birthdate: _birthdata.toUtc().toIso8601String(),
      gender: "MALE",
      avatar: ""
    );

    if (widget.model.statusCodes == 200) {
      Navigator.pushNamed(context, "/homeScreenPatient");

      
      // registrationDone(context);
      // Future.delayed(Duration(seconds: 1)).then((_) {
      //   Navigator.pop(context);
      // });

    } else if (widget.model.statusCodes != 200) {
      wrongWidget(context);
      Future.delayed(Duration(seconds: 1)).then((_) {
       Navigator.pop(context);
      });
    }
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
                            //"yyyy-MM-ddTHH:mm:ss.mmmuuZ"
                            _birthdata = value;
                          });
                        },
                        initialDateTime: DateTime(1980).toUtc(),
                        minDateTime: DateTime(1980).toUtc(),
                        maxDateTime: DateTime(2020).toUtc(),

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
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                          icon: Container(
                            padding: EdgeInsets.only(left: 5, right: 2),
                            child: Icon(
                              Icons.arrow_drop_down,
                              size: 24,
                              color: Color(0xFF2B95AF),
                            ),
                          ),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Tajawal-Medium'),
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
                              _gender = val;
                            });
                          },
                        ))),
                    SizedBox(height: 5.0),
                    userName(),
                    SizedBox(height: 10.0),
                    passwordField(),
                    SizedBox(height: 20.0),
                    registrationButton(() async {
                    // await  _onPressed().then((_){
                    //       widget.model.login("1b407356-9df5-4079-b978-6a12e216e6e6","usernameaa", "1233@@44password123456",);
                    // });
                   // widget.model.login("ajduemeedcmv", "123456.dASSDpassword", "04d7ec5b-e46c-4651-8b8c-0f26b27faf78");
                     _onPressed();
                      if (widget.model.isLoading == true) {
                        onLoading(context);
                        await Future.delayed(_onPressed().then((_) {
                          Navigator.pushNamed(context, "/homeScreenPatient");
                        }));                     
                     }
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
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
          
            counterStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0)),
            labelText: 'الاسم الأول',
            labelStyle: TextStyle(color: Colors.white, fontSize: 18),
          ),
          keyboardType: TextInputType.text,
          cursorColor: Colors.white,
          onSaved: (String value) {},
        ));
  }

  Widget lastName() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: _lastNameController,
            style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              labelText: 'اسم العائلة',
              labelStyle: TextStyle(color: Colors.white, fontSize: 18),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0))),
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.white,
          onSaved: (String value) {},
        ));
  }

  Widget emailAdress() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: _emailController,
            style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'البريد الالكتروني',
            labelStyle: TextStyle(color: Colors.white, fontSize: 18),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0)),
          ),
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.white,
          onSaved: (String value) {},
        ));
  }

  Widget userName() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: _userNameController,
            style: TextStyle(color: Colors.white),
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            labelText: 'اسم المستخدم',
            labelStyle: TextStyle(color: Colors.white, fontSize: 18),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0)),
          ),
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.white,
          onSaved: (String value) {
            setState(() {
              //    patient.userName=value;
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
              labelStyle: TextStyle(color: Colors.white, fontSize: 18),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0))),
          keyboardType: TextInputType.visiblePassword,
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.white),
          onSaved: (String value) {
            setState(() {
              //  patient.password=value;
            });
          },
        ));
  }

  Widget registrationButton(Function function) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Container(
          height: 43.0,
          child: RaisedButton(
              color: Colors.deepOrangeAccent,
              textColor: Colors.white,
              child: Text(
                ' إنشاء حساب',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              onPressed: function
              // (){
              // Navigator.pushReplacementNamed(context, "/HomeScreenPatient");
              // })
              ));
    });
  }
}
