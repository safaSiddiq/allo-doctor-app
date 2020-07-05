import 'package:flutter/material.dart';

class DoctorFileScreen extends StatelessWidget {
final bool isOnline = true;

final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.center,
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
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xFF0000),
          actions: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 5, top: 5, bottom: 5),
                child: Stack(
                  children: <Widget>[
                CircleAvatar(
                            radius: 21,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                                child: SizedBox(
                                    width: 40.0,
                                    height: 40.0,
                                    child: Image.asset('assets/Patient.png',
                                        fit: BoxFit.fill)))),
                         isOnline  ? Container(
             // alignment: Alignment.bottomLeft,
              margin: EdgeInsets.only(top:25,left: 34),
              child: Container(
                height: 9,
                width: 9,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
            )
          : Container(),
             ]),
             )
          ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical:15),
          children: <Widget>[
          Column(children: [
            Center(
              child: CircleAvatar(
                  radius: 120,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                      child: SizedBox(
                          width: 235.0,
                          height: 235.0,
                          child: Image.asset('assets/Doctor.png',
                              fit: BoxFit.fill)))),
            ),
            SizedBox(height: 15),
            Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '.د',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  Text(
                    'احمد خالد ',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  )
                ]),
            SizedBox(height: 15),
            Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'طبيب مختص',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'طبيب جراحة',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  )
                ]),
          ]),
          SizedBox(height: 30),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(textDirection: TextDirection.rtl, children: [
                IconButton(
                    icon: Icon(
                      Icons.place,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
                Text(
                  'أماكن العمل',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )
              ])),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Text(''),
          ),
          SizedBox(height: 30),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(textDirection: TextDirection.rtl, children: [
                IconButton(
                    icon: Icon(
                      Icons.library_books,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
                Text(
                  'السيرة الذاتية',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )
              ])),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Text(''),
          ),
        ])));
  }
}
