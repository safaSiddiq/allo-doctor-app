import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _passwordController = TextEditingController();
  final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.bottomCenter,
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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF0000),
        ),
        body: Container(
        margin: EdgeInsets.symmetric(horizontal:30),
          child: 
        
        
        ListView(
       
          // textDirection: TextDirection.rtl,
          // mainAxisAlignment: MainAxisAlignment.start,
           physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            SizedBox(height:20),
            Container(
                alignment: Alignment.topRight,
                child: Text('كلمة المرور الحالية',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white,
                    fontSize: 18
                    ))),
            SizedBox(height: 5),
            password(),
            SizedBox(height: 30),
            //Container(
              Align(
                alignment: Alignment.topRight,
                
                child:

                 Text('كلمة المرور الجديدة',
                
                    style: TextStyle(color: Colors.white, fontSize: 18))),//),
            SizedBox(height: 5),
            newPassword(),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.topRight,
                child: Text('إعادة كلمة المرور الجديدة',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white, fontSize: 18))),
            SizedBox(height: 5),
            reNewpassword(),
            SizedBox(height:40),
            GestureDetector(
              child: Container(
              //  alignment: Alignment.bottomLeft,
                margin:EdgeInsets.only(right: 190),
                padding: EdgeInsets.only(right:30,top: 15,bottom:15,left: 30),
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Text("حفظ",style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),
              ),
              ),
              onTap: (){

              },
            )
          ],
        ),
      ),
    ));
  }

  Widget password() {
    // if (_patient == null && _passwordController.text.trim() == '') {
    //   _passwordController.text = '';
    // } else if (_patient != null && _passwordController.text.trim() == '') {
    //   _passwordController.text = snapShot.lastName;
    // } else if (_patient != null && _passwordController.text.trim() != '') {
    //   _passwordController.text = _passwordController.text;
    // } else if (_patient == null && _passwordController.text.trim() != '') {
    //   _passwordController.text = _passwordController.text;
    // } else {
    //   _passwordController.text = '';
    // }

    return Container(
     //   margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          controller: _passwordController,
          style: TextStyle(color: Colors.black),
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0))),
          onSaved: (String value) {
            setState(() {});
          },
        ));
  }

  Widget newPassword() {
    return Container(
      //  margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          controller: _passwordController,
          style: TextStyle(color: Colors.black),
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0))),
          onSaved: (String value) {
            setState(() {});
          },
        ));
  }

  Widget reNewpassword() {
    return Container(
       // margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          controller: _passwordController,
          style: TextStyle(color: Colors.black),
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0))),
          onSaved: (String value) {
            setState(() {});
          },
        ));
  }
}
