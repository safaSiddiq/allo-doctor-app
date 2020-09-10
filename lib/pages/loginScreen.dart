//import 'package:flutter/gestures.dart';
import 'package:allo_doctor/pages/registrationScreen.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final MainModel model;
  LoginScreen(this.model);
  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> { 
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  Widget userNameField() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: _userNameController,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              labelText: 'اسم المستخدم',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0))),
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.white,
          onSaved: (String value){
         
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
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0))),
            keyboardType: TextInputType.visiblePassword,
            textDirection: TextDirection.rtl,
            style: TextStyle(color: Colors.white)
            //onSaved: (String value){password=value},
            ));
  }

  Widget button() {
    return RaisedButton(
        color: Colors.deepOrangeAccent,
        textColor: Colors.white,
        child: Text(
          'تسجيل دخول',
        ),
        padding: EdgeInsets.symmetric(horizontal: 55.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: () async {
       // widget.model.login(_userNameController.text, _passwordController.text);//"022d511b-222e-44ee-b99a-cba83238f003"
     await widget.model.logins("ahmed","gPjDRXJqmwhZi.ntSq1HVe1NN401v63pgLtg6.0UTiJdtof5GffvW",);
      //  if (widget.model.patient==null){

      //    print("user does not exist");
       
      //  }
       ///  Navigator.pushNamed(context, "/homeScreenPatient");
        });
  }

  // void _submitForm(){
  //   _formKey.currentState.save();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(gradient: mainColor),
        child: Scaffold(
            backgroundColor: Color(0x0000000),
            body: Container(
                padding: EdgeInsets.only(
                    top: 170.0, left: 60.0, right: 60.0, bottom: 20.0),
                child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        userNameField(),
                        SizedBox(height: 30.0),
                        passwordField(),
                        SizedBox(height: 49.0),
                        button(),
                        SizedBox(height: 15.0),
                        FlatButton(
                            onPressed: () {},
                            child: Text('هل نسيت كلمة المرور ؟',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline,
                                ))),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Text(
                              'ليس لديك حساب ؟',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrationScreen()));
                              },
                              child: Text('إنشاء حساب',
                                  style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline)),
                            )
                          ],
                        )
                      ],
           )
         )
       )
     )
    );
  }
}
