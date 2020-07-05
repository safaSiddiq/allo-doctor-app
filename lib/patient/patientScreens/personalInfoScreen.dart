import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class PesronalinfoScreen extends StatefulWidget {
  @override
  _PesronalinfoScreen createState() => _PesronalinfoScreen();
}

class _PesronalinfoScreen extends State<PesronalinfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isOnline=true ;


   final mainColor=  LinearGradient(
          begin: FractionalOffset.topCenter,
            //end: FractionalOffset.bottomCenter,
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
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey,
              child: ListView(children: <Widget>[
               
                Stack(

                 // mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Align(
                        child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: SizedBox(
                          width: 195.0,
                          height: 195.0,
                          child: Image.asset('assets/Patient.png',
                              fit: BoxFit.fill),
                          // child: (_image!=null)?Image.file(
                          //   _image,
                          //   fit: BoxFit.fill,
                          // ):Image.network(
                          //   "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                          //   fit: BoxFit.fill,
                        ),
                      ),
                    )),
                 Positioned(
                     right: 150,
                     top: 170,
                     width: 100,
                     height: 26,
                     child:
                    RaisedButton(  
                      
                       padding: EdgeInsets.symmetric(horizontal: 12.0),
                      shape:RoundedRectangleBorder(
                        side: BorderSide(style: BorderStyle.none,
                        
                        ),),
                        
                    color: Colors.black.withOpacity(0.05),
                   //  padding: EdgeInsets.only(top: 150.0, right: 130),
                      child: editButton(),    
                      onPressed: (){}
                    )),
                     isOnline
                            ? Center(
                                  
                                  child:Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(right: 82,top: 165),
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ))
                                : Container(),
                    ],
                ),
                SizedBox(height: 20.0),
                Container(
                    margin: EdgeInsets.only(right: 30.0),
                    child: Text('الاسم الأول',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.white))),
                firstName(),
                SizedBox(height: 15),
                Container(
                    margin: EdgeInsets.only(right: 30.0),
                    child: Text(
                      'اسم العائلة',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.white),
                    )),
                lastName(),
                SizedBox(height: 10),
                Container(
                    margin: EdgeInsets.only(right: 30.0),
                    child: Text('البريد الإلكتروني',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.white))),
                SizedBox(height: 5),
                emailAdress(),
                SizedBox(height:10.0),
                Container(
                    margin: EdgeInsets.only(right: 30.0),
                    child: Text('كلمة المرور',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.white))),
                SizedBox(height: 5),
                password(),
                SizedBox(height: 10.0),
               Container(
                 margin: EdgeInsets.only(right:25,left:20),
                 child:  Text(
                  'تاريخ الميلاد',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                )),
                SizedBox(height: 10.0),
                
               Container(
                 margin: EdgeInsets.only(right:22,left:22),
                  child: 
                DatePickerWidget(
                    //onConfirm: (){},
                    initialDateTime: DateTime(1980),
                    minDateTime: DateTime(1930),
                    maxDateTime: DateTime(2020),
                    locale: DateTimePickerLocale.ar,
                    pickerTheme: DateTimePickerTheme(
                        showTitle: false,
                        pickerHeight: 60.0,
                        itemTextStyle:
                            TextStyle(color: Colors.black, fontSize: 18)))),
                SizedBox(height: 25.0),
                saveButton((){}),
                SizedBox(height:15)
              ]),
    ))));
  }
}

Widget firstName() {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
       // initialValue: '',
       textDirection: TextDirection.rtl,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0))),
        onChanged: (String valure) {},
      ));
}

Widget lastName() {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        //initialValue: '',
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0))),
        onChanged: (String valure) {},
      ));
}

Widget emailAdress() {
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

Widget password() {
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

Widget editButton() {
  return Row(textDirection: TextDirection.rtl,
      // padding: EdgeInsets.only(top: 170.0,left:120),
      children: <Widget>[
        
          //padding: EdgeInsets.only(top: 170.0,left:120),
         
          Icon(
            Icons.edit,
            size: 15.0,
            color: Colors.white,
          ),
          // onPressed: () {
          //   //getImage();
          // },
        Text(
          'تغيير الصورة',
          textAlign: TextAlign.end,
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),

      ]);
}

Widget saveButton(Function function) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60.0),
      height: 40.0,
      
      child:
    RaisedButton(
        color: Colors.deepOrangeAccent,
        textColor: Colors.white,
        child: Text(
          'حفظ',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        //padding: EdgeInsets.symmetric(horizontal: 60.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        onPressed: function) );
  }

