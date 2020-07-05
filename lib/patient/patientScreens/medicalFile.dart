import 'package:flutter/material.dart';
//import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class MedicalFile extends StatefulWidget {
  @override
  _MedicalFileState createState() => _MedicalFileState();
}

class _MedicalFileState extends State<MedicalFile> {
  bool isOnline=true;
  String _selectedText = "ذكر";
  String _selectedText1 = "A+";
  bool pressure = false;
  bool sugar = false;
  bool clot = false;
  bool heaetDS = false;
  bool chestDS = false;
  bool other = false;

  bool gluten = false;
  bool lactos = false;

  bool panadol = false;
  bool prufen = false;
  bool aspirin = false;

  bool sergury1 = false;


  String title = "";


   final mainColor=  LinearGradient(
          begin: FractionalOffset.topCenter,
          //  end: FractionalOffset.bottomCenter,
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
        centerTitle: false,
        elevation: 0,
        backgroundColor: Color(0xFF0000),
        actions: <Widget>[
          Container(
              padding: EdgeInsets.only(right: 5, top: 5, bottom: 5),
              child:  Stack(
                textDirection: TextDirection.rtl,
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
                                  isOnline
                                ? Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(right: 3,bottom: 5),
                                    child: Container(
                                      height: 10,
                                      width: 10,
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
              ))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: <Widget>[
          Container(
            child: Text(
              '',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          firstName(),
          SizedBox(height: 10),
          fatherName(),
          SizedBox(height: 10),
          grandFatherName(),
          SizedBox(height: 10),
          lastName(),
          SizedBox(height: 10),
          Text(
            'تاريخ الميلاد',
            textDirection: TextDirection.rtl,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          SizedBox(height: 10.0),
          DatePickerWidget(
              //onConfirm: (){},
              initialDateTime: DateTime(1980),
              minDateTime: DateTime(1980),
              maxDateTime: DateTime(2020),
              locale: DateTimePickerLocale.ar,
              pickerTheme: DateTimePickerTheme(
                  showTitle: false,
                  pickerHeight: 60.0,
                  itemTextStyle: TextStyle(color: Colors.black, fontSize: 18))),
          SizedBox(height: 10.0),
          Container(
  
              child: Text(
                'الجنس',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 19, color: Colors.white),
              )),
          SizedBox(height: 4.0),
          Container(
              alignment: Alignment.center,
              height: 50.0,
              width: 40.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0)),
              margin: EdgeInsets.only(
                left: 200.0,
              ),
              child: DropdownButton<String>(
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Tajawal-Medium'),
                value: _selectedText,
                items: <String>['ذكر', 'أنثى'].map((String value) {
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
          SizedBox(height: 15),
          nationality(),
          SizedBox(height: 10),
          adress(),
          SizedBox(height: 10),
          Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text(
                'فصيلة الدم',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(width: 10),
              Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                  //margin: EdgeInsets.only(left: 170.0,),
                  child: DropdownButton<String>(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Tajawal-Medium'),
                    //hint: Text('الجنس'),
                    value: _selectedText1,
                    items: <String>['A+', 'أنثى'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String val) {
                      _selectedText1 = val;
                      setState(() {
                        _selectedText1 = val;
                      });
                    },
                  )),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'الأمراض المزمنة',
            textDirection: TextDirection.rtl,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 10),
          diseaseCheckBok('ضغط دم', pressure, Colors.white),
          diseaseCheckBok('السكر', sugar, Colors.white),
          diseaseCheckBok('جلطة دموية', clot, Colors.white),
          diseaseCheckBok('أمراض قلب', heaetDS, Colors.white),
          diseaseCheckBok('أمراض صدرية', chestDS, Colors.white),
          diseaseCheckBok('اخرى', other, Colors.white),
          SizedBox(height: 10),
          Container(
              //alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.only(bottom: 3, left: 5, right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                          textDirection: TextDirection.rtl,
                          maxLines: 2,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            //hintText: 'اخرى',
                          ))),
                  Container(
                      alignment: Alignment.bottomLeft,
                      child: RaisedButton(
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
                          onPressed: () {}))
                ],
              )),
          SizedBox(height: 20),
          Text(
            'الحساسيات',
            textDirection: TextDirection.rtl,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.only(bottom: 3, left: 5, right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  diseaseCheckBok('حساسية الغلوتين', gluten, Colors.black),
                  diseaseCheckBok('حساسية اللاكتوز', lactos, Colors.black),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                          textDirection: TextDirection.rtl,
                          maxLines: 2,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'حساسية',
                          ))),
                  addDeleteButtons(),
                ],
              )),
          SizedBox(height: 20),
          Text(
            'الأدوية الحالية',
            textDirection: TextDirection.rtl,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 5),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.only(bottom: 3, left: 5, right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                
                  medicineCheckBok(panadol,
                      'بنادول', 'ثلاث مرات يوميًا',),
                  medicineCheckBok(prufen,'بروفين', 'حبة واحدة عند الشعور بألم بالظهر',
             ),
                  medicineCheckBok( aspirin,
                      'اسبرين', 'حبة في اليوم',),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                          textDirection: TextDirection.rtl,
                          maxLines: 2,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'اسم الدواء' '\n' 'الجرعة',
                          ))),
                  addDeleteButtons(),
                ],
              )),
          SizedBox(height: 20),
          Text(
            'جراحات سابقة',
            textDirection: TextDirection.rtl,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 5),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.only(bottom: 3, left: 5, right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  checkBoxWithDate('جراحة مفاصل', 'مستشفى السلام ', sergury1,),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                          textDirection: TextDirection.rtl,
                          maxLines: 2,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText:
                                  'اسم الجراحة' '\n' 'مكان اجراء الجراحة'))),
                  addDeleteButtons(),
                ],
              )),
          SizedBox(height: 20),
          Text(
            'التحاليل السابقة',
            textDirection: TextDirection.rtl,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 5),
          Container(
            
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.only(bottom: 3, left: 5, right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                checkBoxWithDate('تحليل سكر', 'مستشفى السلام', false,),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                          textDirection: TextDirection.rtl,
                          maxLines: 2,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'اسم التحليل' '\n' 'مكان اجراء التحليل',
                          ))),
                  // Container(
                  //     alignment: Alignment.centerLeft,
                  //     margin: EdgeInsets.only(right: 150, top: 5),
                  //     padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(8),
                  //         color: Colors.grey[300]),
                  //     child: RawMaterialButton(
                  //         onPressed: () {},
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           children: <Widget>[
                  //             Icon(Icons.calendar_today),
                  //             SizedBox(width: 10),
                  //             Text('ادخل تاريخ التحليل')
                              // Directionality(
                              //     textDirection: TextDirection.rtl,
                              //     child: TextField(
                              //         textDirection: TextDirection.rtl,
                              //         maxLines: 2,
                              //         decoration: InputDecoration(
                              //           filled: true,
                              //           fillColor: Colors.white,
                              //           hintText: "تاريخ التحليل",
                              //         ))),
                          //   ],
                          // ))),
                  addDeleteButtons(),
                ],
              )),

                SizedBox(height: 20),
          Text(
            'الأشعة السابقة',
            textDirection: TextDirection.rtl,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 5),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.only(bottom: 3, left: 5, right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  checkBoxWithDate(' صورة قلب', 'مستشفى السلام', false,),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                          textDirection: TextDirection.rtl,
                          maxLines: 2,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'نوع الصورة' '\n' 'مكان اجراء التصوير',
                          ))),
                
                  addDeleteButtons(),
                ],
              )),
              SizedBox(height:35),
              saveButton((){}),
              SizedBox(height:10)
        ],
      ),
     ) );
  }

  Widget diseaseCheckBok(String title, bool boolValue, Color color) {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            setState(() {
              switch (title) {
                case "ضغط دم":
                  pressure = value;

                  break;
                case "السكر":
                  sugar = value;
                  break;
                case "جلطة دموية":
                  clot = value;
                  break;
                case "أمراض قلب":
                  heaetDS = value;
                  break;
                case "أمراض صدرية":
                  chestDS = value;
                  break;
                case "اخرى":
                  other = value;
                  break;
                case 'حساسية الغلوتين':
                  gluten = value;
                  break;
                case "حساسية اللاكتوز":
                  lactos = value;
                  break;
              }
            });
          },
        ),
        SizedBox(width: 5),
        Text(
          title,
          style: TextStyle(color: color),
        ),
      ],
    );
  }

  Widget medicineCheckBok(bool boolValue,String title,String subtitle){
    return  CheckboxListTile(value: boolValue, 
    
    title: Text( title,textDirection: TextDirection.rtl,),
    subtitle: Text(subtitle,textDirection: TextDirection.rtl,),
    onChanged:(bool value) {setState(() {
                switch (title) {
                  case 'بنادول':
                    panadol = value;
                    break;
                  case "بروفين":
                    prufen = value;
                    break;
                  case "اسبرين":
                    aspirin = value;
                    break;
                }
              });
    }
    );
  }

  Widget checkBoxWithDate(String title,String subtitle,bool boolValue){
    return
     CheckboxListTile(value: boolValue, 
    title: Text(title,textDirection: TextDirection.rtl,),
    subtitle: Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        
        Text(subtitle),
        Container(
          padding: EdgeInsets.symmetric(horizontal:10,vertical:5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[300]
          ),
          child: Row(
            children: <Widget>[
                Icon(Icons.calendar_today,size: 20,),
                 SizedBox(width:5),
                 Text("22/2/2222"),
             
            ],
          ),
        )

      ],
    ),
    onChanged: (bool value) {
                setState(() {
                  switch (title) {
                    case "جراحة مفاصل":
                      pressure = value;
                      break;
                    case "":
                      sugar = value;
                      break;
                    case "جلطة دموية":
                      clot = value;
                      break;
                    case "أمراض قلب":
                      heaetDS = value;
                      break;
                    case "أمراض صدرية":
                      chestDS = value;
                      break;
                    case "اخرى":
                      other = value;
                      break;
                    case 'حساسية الغلوتين':
                      gluten = value;
                      break;
                    case "حساسية اللاكتوز":
                      lactos = value;
                      break;
                  }
                });
            },
     );
  } 
//   Widget checkBokWithDate(String title, String subtitle, bool boolValue, String date, Color color) {
//     return Column( children: <Widget>[Row(
//           textDirection: TextDirection.rtl,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Checkbox(
//               value: boolValue,
//               onChanged: (bool value) {                
//             ),
//             SizedBox(width: 5),
//             Text(
//               title,
//               style: TextStyle(color: color),
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           textDirection: TextDirection.rtl,
//           children: <Widget>[
//             Text(
//               subtitle,
//               style: TextStyle(color: Colors.grey, fontSize: 12),
//             ),
//             SizedBox(width: 30),
//             Container(
//                 padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.grey[300]),
//                 child: Row(
//                   children: <Widget>[
//                     Icon(Icons.calendar_today),
//                     SizedBox(width: 10),
//                     Text(date),
//                   ],
//                 ))
//           ],
//         ),], );}
// }

Widget firstName() {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        // textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          labelText: 'الاسم الأول',
          labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
        ),
        keyboardType: TextInputType.text,
        cursorColor: Colors.white,
        //onSaved: (String value){userName=value},
      ));
}

Widget fatherName() {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        // textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          labelText: 'اسم الأب',
          labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
        ),
        keyboardType: TextInputType.text,
        cursorColor: Colors.white,
        //onSaved: (String value){userName=value},
      ));
}

Widget grandFatherName() {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        // textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          labelText: 'اسم الجد',
          labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
        ),
        keyboardType: TextInputType.text,
        cursorColor: Colors.white,
        //onSaved: (String value){userName=value},
      ));
}

Widget lastName() {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        // textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          labelText: 'اسم العائلة',
          labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
        ),
        keyboardType: TextInputType.text,
        cursorColor: Colors.white,
        //onSaved: (String value){userName=value},
      ));
}

Widget nationality() {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        // textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: ' الجنسية',
          labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
        ),
        keyboardType: TextInputType.text,
        cursorColor: Colors.white,
        //onSaved: (String value){userName=value},
      ));
}

Widget adress() {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        // textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'محل الإقامة',
          labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
        ),
        keyboardType: TextInputType.text,
        cursorColor: Colors.white,
        //onSaved: (String value){userName=value},
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
                           // controller: myController,
                            textDirection: TextDirection.rtl,
                            onSaved: (String value){
                          setState(() {
                            title = value;
                          });
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

} 
Widget saveButton(Function function){
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



 //     String title, String subtitle, bool boolValue, Color color) {
  //   return Column(children: <Widget>[
  //     Row(
  //       textDirection: TextDirection.rtl,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: <Widget>[
  //         Checkbox(
  //           value: boolValue,
  //           onChanged: (bool value) {
  //             setState(() {
  //               switch (title) {
  //                 case 'بنادول':
  //                   panadol = value;
  //                   break;
  //                 case "بروفين":
  //                   prufen = value;
  //                   break;
  //                 case "اسبرين":
  //                   aspirin = value;
  //                   break; } }); }, ),
  //         SizedBox(width: 5),
  //         Text(title,style: TextStyle(color: color),),],),
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       textDirection: TextDirection.rtl,
  //       children: <Widget>[
  //         Text(
  //           subtitle,
  //           style: TextStyle(color: Colors.grey, fontSize: 12),
  //         )
  //       ],
  //     )
  //   ]);
  // }
