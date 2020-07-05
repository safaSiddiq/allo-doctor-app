import 'package:flutter/material.dart';
Widget registrationRow(Function function){
 return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Text(
                      ' لديك حساب ؟' ,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    FlatButton(
                      onPressed: function
                      ,
                      child: Text('تسجيل دخول',
                          style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline)),
                    )
                  ],
                );}