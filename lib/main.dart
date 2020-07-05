import 'package:allo_doctor/pages/introScreen.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './scoped_model.dart/mainModel.dart';

void main() async {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
 final MainModel model = MainModel();
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: model,
        child: MaterialApp(
            title: 'Allo Doctor',
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              fontFamily: 'Tajawal-Medium',
              //  primaryTextTheme: TextTheme(body1:TextStyle(color: Colors.white))
            ), 
            home: Directionality(
              textDirection: TextDirection.rtl,
              child: IntroScreen(),
            )));
  }
}
