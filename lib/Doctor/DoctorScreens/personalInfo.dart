import 'package:allo_doctor/patient/patientScreens/medicalFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class DrPersonalInfo extends StatefulWidget {
  @override
  _DrPersonalInfoState createState() => _DrPersonalInfoState();
}

class _DrPersonalInfoState extends State<DrPersonalInfo> {
  bool isOnline = true;
  final myController = TextEditingController();
  String inputData = "";
  bool boolValue = false;

   final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
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
        backgroundColor: Color(0xFF0000),
        appBar: AppBar(
          backgroundColor: Color(0xFF0000),
          elevation: 0,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView(
            children: <Widget>[
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
                  )),
                  Positioned(
                      right: 190,
                      top: 170,
                      width: 100,
                      height: 26,
                      child: RaisedButton(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              style: BorderStyle.none,
                            ),
                          ),
                          color: Colors.grey.withOpacity(0.05),
                          //  padding: EdgeInsets.only(top: 150.0, right: 130),
                          child: editButton(),
                          onPressed: () {})),
                  isOnline
                      ? Center(
                          child: Container(
                          alignment: Alignment.bottomRight,
                          margin: EdgeInsets.only(right: 105, top: 170),
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
              SizedBox(height: 20),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Text(
                      'د.  '
                      "احمد علي",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'طبيب متخصص'
                        " - "
                        "طبيب جراحة",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ))
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(right: 25),
                child: Text(
                  'الاسم الأول',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              firstName(),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.only(right: 25),
                child: Text(
                  'اسم العائلة',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              lastName(),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.only(right: 25),
                child: Text(
                  'كلمة المرور',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              password(),
              SizedBox(height: 20.0),
              Container(
                  margin: EdgeInsets.only(right: 25),
                  child: Text(
                    'البريد الالكتروني',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  )),
              SizedBox(height: 5.0),
              Container(
                padding: EdgeInsets.only(top:10,right:5,left:5),
                margin: EdgeInsets.symmetric(horizontal: 20),
               // height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        alignment: Alignment.bottomCenter,
                        child: addDeleteButtons())
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.only(right: 25),
                  child: Text(
                    'أرقام الهواتف',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  )),
              SizedBox(height: 5.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
               padding: EdgeInsets.only(top:10,right:5,left:5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                child: Column(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                CheckboxListTile(
                  title: Text(inputData,textDirection: TextDirection.rtl,),
                  value: boolValue,
                   onChanged: (bool value){
                     setState(() {
                       boolValue = true;
                     });
                   }),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        alignment: Alignment.bottomCenter,
                        child: addDeleteButtons())
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.only(right: 25),
                  child: Text(
                    'تاريخ الميلاد',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  )),
              SizedBox(height: 10.0),
              Container(
                  margin: EdgeInsets.only(right: 25, left: 25),
                  child: DatePickerWidget(

                      //onConfirm: (){},
                      initialDateTime: DateTime(1980),
                      minDateTime: DateTime(1980),
                      maxDateTime: DateTime(2020),
                      locale: DateTimePickerLocale.ar,
                      pickerTheme: DateTimePickerTheme(
                          showTitle: false,
                          pickerHeight: 60.0,
                          itemTextStyle:
                              TextStyle(color: Colors.black, fontSize: 18)))),
              SizedBox(height: 15.0),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(right: 25),
                child: Text(
                  'محل الإقامة',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: Text("")
                //TextField(textDirection: TextDirection.rtl)
              ),
              SizedBox(height: 30),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
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
                  padding: EdgeInsets.only(top:10,right:5,left:5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.bottomCenter,
                          child: addDeleteButtons())
                    ],
                  )),
              SizedBox(height: 30),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(textDirection: TextDirection.rtl, children: [
                    IconButton(
                        icon: Icon(
                          Icons.slideshow,
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
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: Text(''),
              ),
              SizedBox(height: 20),
              saveButton(() {})
            ],
          ),
         )     ));
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

  Widget changeButton() {
    return RawMaterialButton(
        onPressed: () {},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.tealAccent, borderRadius: BorderRadius.circular(8)),
          child: Text('تغيير'),
        ));
  }

  Widget addDeleteButtons() {
    return Container(
        // alignment: Alignment.bottomLeft,
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RaisedButton(
            color: Colors.teal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'اضافة',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.add,
                  color: Colors.white,
                )
              ],
            ),
            onPressed: () {
              return showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                        child: Column( 
                          mainAxisAlignment: MainAxisAlignment.center,         
                      children: <Widget>[
                        AlertDialog(
                          content: TextFormField(
                            controller: myController,
                            textDirection: TextDirection.rtl,
                            onSaved: (String value){
                              saveData(value);
                            },
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.deepOrangeAccent),
                            child: RawMaterialButton(
                              onPressed: () {
                                setState(() {
                               
                                });
                                Navigator.pop(context);
                              },
                              child: Text(
                                "تم",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ))
                      ],
                    ));
                  });
            }),
        RaisedButton(
            color: Colors.red,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'حذف',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 5),
                Container(
                    margin: EdgeInsets.only(bottom: 13),
                    child: Icon(
                      Icons.minimize,
                      color: Colors.white,
                    ))
              ],
            ),
            onPressed: () {})
      ],
    ));
  }

  void saveData(String value){
    setState(() {
      inputData=value;
    });
  }
}
