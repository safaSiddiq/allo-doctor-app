import 'package:flutter/material.dart';

class InvitationAsk extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InvitationAsk();
  }
}

class _InvitationAsk extends State<InvitationAsk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(backgroundColor: Colors.teal, elevation: 0),
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
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  height: 43.0,
                  child: RaisedButton(
                      color: Colors.teal,
                      textColor: Colors.white,
                      child: Text(
                        'إرسال',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      onPressed: () {})),
            ])));
  }
}

Widget _phoneNumber() {
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

Widget _emailAdress() {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
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
