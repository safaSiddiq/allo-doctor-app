import 'package:flutter/material.dart';

class FillQueryDrScreen extends StatefulWidget {
  @override
  _FillQueryDrScreen createState() => _FillQueryDrScreen();
}

class _FillQueryDrScreen extends State<FillQueryDrScreen> {
  bool isOnline = true;
  String _selectedText = "استعلام عام";

  final mainColor=  LinearGradient(
          begin: FractionalOffset.topCenter,
            end: FractionalOffset.center,
          stops: [0.0, 1.0,],
          colors: [
            Color(0xFF87C9BF),
            Color(0xFF2B95AF)
          ],
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
          elevation: 0,
          backgroundColor: Color(0xFF0000),
          actions: <Widget>[
            Container(
                width: 38,
                height: 38,
                padding: EdgeInsets.only(
                  right: 5.0,
                ),
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                        radius: 38,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                            child: SizedBox(
                                width: 32.0,
                                height: 32.0,
                                child: Image.asset('assets/Patient.png',
                                    fit: BoxFit.fill)))),
                    isOnline
                        ? Container(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 13,
                              ),
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
                  ],
                )),
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 25),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 19,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: SizedBox(
                        width: 36.0,
                        height: 36.0,
                        child:
                            Image.asset('assets/Doctor.png', fit: BoxFit.fill),
                        // child: (_image!=null)?Image.file(
                        //   _image,
                        //   fit: BoxFit.fill,
                        // ):Image.network(
                        //   "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                        //   fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text(
                        ' : الاستعلام سيوجه الى الطبيب',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        'احمد خالد',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.only(right: 5),
                  alignment: Alignment.topRight,
                  child: Text(
                    'اختر نوع الاستعلام',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white),
                  )),
              SizedBox(height: 5),
              Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: DropdownButton<String>(
                    iconDisabledColor: Colors.teal,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Tajawal-Medium',
                    ),
                    value: _selectedText,
                    items: <String>["طبيب أسنان", "استعلام عام", 'طبيب عيون']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String val) {
                      _selectedText = val;
                      setState(() {
                        _selectedText = val;
                      });
                    },
                  )),
              SizedBox(height: 20),
              Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    'الاستعلام',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
              SizedBox(height: 5),
              query(),
              SizedBox(height: 15),
              sendButton(() {}),
              SizedBox(height: 15)
            ],
          ),
        )));
  }
}

Widget query() {
  return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
      margin: EdgeInsets.only(
        left: 15.0,
      ),
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextField(
              textDirection: TextDirection.rtl,
              maxLines: 25,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'اكتب الاستعلام',
              ))));
}

Widget sendButton(Function function) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 60.0),
      height: 40.0,
      child: RaisedButton(
          color: Colors.deepOrangeAccent,
          textColor: Colors.white,
          child: Text(
            'ارسال',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          //padding: EdgeInsets.symmetric(horizontal: 60.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          onPressed: function));
}
