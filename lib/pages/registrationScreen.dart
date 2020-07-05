
import 'package:allo_doctor/pages/ui_widgets/onLoading.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
    //end: FractionalOffset.center,
  
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );
  @override
  Widget build(BuildContext context) {
    return Container(
decoration: BoxDecoration(
  gradient: mainColor
),
    
    child:
    Scaffold(
      backgroundColor: Color(0xFF00000),
      appBar: AppBar(
        backgroundColor: Color(0xFF0000),
        elevation: 0,
      ),
      body: Container(
          margin: EdgeInsets.only(bottom: 65),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            
              SizedBox(height: 45.0),
              RawMaterialButton(
                  child: _userKindButton('مريض', 'assets/Patient.png'),
                  onPressed: () {
                   Navigator.pushNamed(context, "/RegistrationASpatient");
                  }),
              SizedBox(height: 45.0),
              RawMaterialButton(
                  child: _userKindButton('طبيب', 'assets/Doctor.png'),
                  onPressed: () {
                    onLoading(context);
                   Navigator.pushNamed(context, "/RegistrationASdoctor");
                  }),
            ],
     ) )),
    );
  }
}

Widget _userKindButton(String title, String image) {
  return Row(
    textDirection: TextDirection.rtl,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(right: 60.0),
        height: 65.0,
        width: 65.0,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            )),
      ),
      SizedBox(width: 20.0),
      Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 26.0),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
      )
    ],
  );
}