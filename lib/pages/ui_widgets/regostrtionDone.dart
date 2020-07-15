import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

registrationDone(BuildContext context) {
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
                    "تم تسجيل الدخول بنجاح",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    textAlign: TextAlign.center,
                  )
                ],
              ))));
}
