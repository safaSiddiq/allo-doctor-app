
import 'package:allo_doctor/pages/ui_widgets/onLoading.dart';
import 'package:allo_doctor/pages/ui_widgets/registrationRow.dart';
import 'package:allo_doctor/pages/ui_widgets/wrongWidget.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class RegistrationASdoctor extends StatefulWidget {

  final MainModel model;
  RegistrationASdoctor(this.model);
  @override
  _RegistrationASdoctor createState() => _RegistrationASdoctor();
}

class _RegistrationASdoctor extends State<RegistrationASdoctor> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 DateTime _birthdate;

  
   String _selectedText1 = 'الجنس';
   String _selectedText ="اختر التخصص";
   String _major;

 TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _bioController =TextEditingController();
   TextEditingController _majorController = TextEditingController();

  final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF),
     Color(0xFF2B95AF)],
  );

   _onPressed() async {
    await widget.model.registrationDoctor(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      birthdate: _birthdate.toUtc().toIso8601String(),
      gender: "male",
      avatar: "",
      major: _major,
      bio:_bioController.text
    );

    if (widget.model.statusCode == 200) {

      Navigator.pushNamed(context, "/HomeScreenDr");
    } else if (widget.model.statusCode != 200) {
      wrongWidget(context);
      Future.delayed(Duration(seconds: 1)).then((_) {
       Navigator.pop(context);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: mainColor
      ),
    child: Scaffold(
      backgroundColor: Color(0xFF00000),
      appBar: AppBar(elevation: 0,
      backgroundColor: Color(0xFF0000),),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                firstName(),
                SizedBox(height: 20.0),
                lastName(),   
                   SizedBox(height:20),
                 Container(
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                    margin: EdgeInsets.only(
                      left: 120.0,
                    ),
                    child: DropdownButtonHideUnderline(child: 
                     DropdownButton<String>(
                       icon: Container(      
                         padding: EdgeInsets.only(left: 7),
                         child: Icon(Icons.arrow_drop_down,size: 24,color: Color(0xFF2B95AF),),
                       ),          
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Tajawal-Medium',            
                      ),
                      value: _selectedText,
                      items: <String>[
                        'اختر التخصص',
                        'طبيب جراحة',         
                        "طبيب باطينية",
                        "طبيب نساء",
                        "طبيب أذن و حنجرة",
                        "طبيب قلب",
                        "طبيب أسنان",
                        'طبيب عيون'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String val) {       
                        setState(() {
                          _selectedText = val;
                        setState(() {
                          _major =_selectedText;
                        });
                        });
                      },
                    ))),
                
                  //  major(),
                SizedBox(height: 5.0),
                emailAdress(),
                SizedBox(height: 20.0),
                Text(
                  'تاريخ الميلاد',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                SizedBox(height: 10.0),
               DatePickerWidget(
                  onChange:(DateTime value,slectedIndex){
                    setState(() {
                       _birthdate= value;
                    });
                    },
                    initialDateTime: DateTime(1980).toUtc(),
                    minDateTime: DateTime(1980).toUtc(),
                    maxDateTime: DateTime(2020).toUtc(),
                    locale: DateTimePickerLocale.ar,
                    pickerTheme: DateTimePickerTheme(
                        showTitle: false,
                        pickerHeight: 60.0,
                        itemTextStyle:
                            TextStyle(color: Colors.black, fontSize: 18))
                            ),
                  SizedBox(height: 25.0),
                Container(
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                    margin: EdgeInsets.only(
                      left: 200.0,
                    ),
                    child: DropdownButtonHideUnderline(child: 
                     DropdownButton<String>(
                       icon: Container(
                        padding: EdgeInsets.only(right: 2,left: 4),
                         child: Icon(Icons.arrow_drop_down,size: 24,color: Color(0xFF2B95AF),),
                       ),  
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Tajawal-Medium'),
                      value: _selectedText1,
                      items: <String>['الجنس','ذكر', 'أنثى'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String val) {
                        setState(() {
                          _selectedText1 = val;
                        
                        });
                      },
                    ))),
                    SizedBox(height:5.0),
                SizedBox(height: 10.0),
                userName(),
                SizedBox(height: 10.0),
                passwordField(),
                SizedBox(height: 20.0),
                Text(
                  '(BIO) السيرة الذاتية',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 10.0),
                bio(),
                SizedBox(height: 20.0),
                registrationButton(()async{
                     await  _onPressed();
                   if (widget.model.isLoading == true) {
                        onLoading(context);
                        await Future.delayed(_onPressed().then((_) {
                          Navigator.pushNamed(context, "/HomeScreenDr");
                        })); 
                   }   
                }),
                SizedBox(height: 10.0),
                registrationRow(() {
                  Navigator.pushNamed(context, "/LoginScreen");
                })
              ]))),
    ));
  }


Widget firstName() {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
      controller: _firstNameController,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0)),
          labelText: 'الاسم الأول',
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),
        ),
        keyboardType: TextInputType.text,
        cursorColor: Colors.white,
        onSaved: (String value){
       
        },
      ));
}

Widget lastName() {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: _lastNameController,
        decoration: InputDecoration(
            labelText: 'اسم العائلة',
            labelStyle: TextStyle(color: Colors.white,fontSize: 18),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0))),
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.white,
        onSaved: (String value){
      
        },
      ));
}

Widget emailAdress() {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'البريد الالكتروني',
          labelStyle: TextStyle(color: Colors.white,fontSize: 18),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0)),
        ),
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.white,
        onSaved: (String value){
      
        },
      ));
}

Widget userName() {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: _userNameController,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          labelText: 'اسم المستخدم',
          labelStyle: TextStyle(color: Colors.white,fontSize: 18),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2.0)),
        ),
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.white,
        //onSaved: (String value){userName=value},
      ));
}

Widget passwordField() {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: _passwordController,
          decoration: InputDecoration(
              labelText: 'كلمة المرور',
              labelStyle: TextStyle(color: Colors.white,fontSize: 18),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white,width: 2.0))),
          keyboardType: TextInputType.visiblePassword,
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.white)
          //onSaved: (String value){password=value},
          ));
}

Widget bio() {
  return Directionality(textDirection: TextDirection.rtl, child: 
  TextFormField(
    controller: _bioController,
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
    ),
    maxLines: 10,
    onSaved: (String value){
 
    }
  ));
}

 Widget registrationButton(Function function) {
    return Container(
      height: 43.0,
      child:
    RaisedButton(
        color: Colors.deepOrangeAccent,
        textColor: Colors.white,
        child: Text(
          ' إنشاء حساب',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed:function) );
  }

  Widget major() {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
       controller: _majorController,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          labelText: 'التخصص',
          labelStyle: TextStyle(color: Colors.white,fontSize: 18),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2.0)),
        ),
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.white,
        //onSaved: (String value){userName=value},
      ));
}
}