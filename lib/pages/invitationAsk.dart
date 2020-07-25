import 'package:allo_doctor/pages/ui_widgets/onLoading.dart';
import 'package:allo_doctor/pages/ui_widgets/wrongWidget.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';

class InvitationAsk extends StatefulWidget {
  final MainModel model;
  InvitationAsk(this.model);
  @override
  State<StatefulWidget> createState() {
    return _InvitationAsk();
  }
}

class _InvitationAsk extends State<InvitationAsk> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _majorController = TextEditingController();

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
            backgroundColor: Color(0xff00000),
            appBar: AppBar(backgroundColor: Color(0xff0000), elevation: 0),
            body: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: ListView(children: [
                  SizedBox(height: 10.0),
                  Container(
                      margin: EdgeInsets.only(left: 100.0),
                      child: Text('رجاء تعبئة البيانات' '\n' "حتى يصل لك الرمز",
                          style: TextStyle(color: Colors.black, fontSize: 20))),
                  SizedBox(height: 30.0),
                  Container(
                      margin: EdgeInsets.only(right: 30.0),
                      child: Text('رقم الهاتف',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.black))),
                  _phoneNumber(),
                  SizedBox(height: 15),
                  Container(
                      margin: EdgeInsets.only(right: 30.0),
                      child: Text(
                        'البريد الالكتروني',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.black),
                      )),
                  _emailAdress(),
                  SizedBox(height: 15),
                  Container(
                      margin: EdgeInsets.only(right: 30.0),
                      child: Text('التخصص الطبي',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.black))),
                  _medicalMajor(),
                  SizedBox(height: 15),
                  Container(
                      margin: EdgeInsets.only(right: 30.0),
                      child: Text('الدرجة العلمية',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.black))),
                  _medicalDegree(),
                  SizedBox(height: 15),
                  GestureDetector(
                      onTap: ()async {

                         await  widget.model.creatinvitationCode(_emailController.text);
                      if( widget.model.isLoading == true){
                        onLoading(context);
                      }
                        if (widget.model.statusCode == 200) {
                           doneSend(context);
                           Future.delayed(Duration(seconds: 1)).then((_) {
                              Navigator.pushNamed(context, "/InvitationCkech");
                          });
                        
                        } else {
                          wrongWidget(context);
                          Future.delayed(Duration(seconds: 1)).then((_) {
                             Navigator.pop(context);
                          });
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        height: 43.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF2B95AF) ,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                            child: Text(
                          'إرسال',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                      )),
                ]))));
  }

  Widget _phoneNumber() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          controller: _phoneNumberController,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0))),
          onChanged: (String valure) {},
        ));
  }

  Widget _emailAdress() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
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

  Widget _medicalMajor() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          controller: _majorController,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0))),
          onChanged: (String valure) {},
        ));
  }

  Widget _medicalDegree() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0))),
          onChanged: (String valure) {},
        ));
  }

  doneSend(BuildContext context) {
    return showDialog(
        context: context,
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 185, horizontal: 25),
            child: AlertDialog(
                backgroundColor: Colors.grey[300],
                elevation: 5,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.check_circle,
                      color: Colors.deepOrangeAccent,
                      size: 48,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "تم الإرسال بنجاح",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "انتظر الرمز للدخول",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      textAlign: TextAlign.center,
                    )
                  ],
                ))));
  }
}
