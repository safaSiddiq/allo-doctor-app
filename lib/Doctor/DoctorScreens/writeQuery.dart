

import 'package:allo_doctor/models/query.dart';
import 'package:allo_doctor/pages/ui_widgets/doneWidget.dart';
import 'package:allo_doctor/pages/ui_widgets/onLoading.dart';
import 'package:allo_doctor/pages/ui_widgets/wrongWidget.dart';

import 'package:allo_doctor/patient/patientScreens/medicalFile.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class WriteQuery extends StatefulWidget {
  final MainModel model;
  final Query query ;
  WriteQuery(this.model,this.query);
  @override
  _WriteQueryState createState() => _WriteQueryState();
}

 
class _WriteQueryState extends State<WriteQuery> {
 TextEditingController _queryResultController = TextEditingController();
 

  String medicine = '';
  String note = '';
  bool boolValue = false;
final mainColor = LinearGradient(
    begin: FractionalOffset.bottomCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );

bool _isLoading ;
int statusCode;


Future writeQueryResult({
    
    String queryId,
    int queryType,
    String queryResult,
    String queryResultDate,
    String patientId,
    bool approved,
    bool emergency}

  )async{

 setState(() {
   _isLoading = true;
 });
     final Map<String, dynamic> queryResultData = {
      "queryId": queryId,
      "queryType": queryType,
      "queryResultDate":queryResultDate,
      "queryResult":queryResult,
      "patientId":patientId,
      "approved":approved,
      "emergency":emergency
    };
    final http.Response response = await http.patch("http://34.71.92.1:3000/doctors/1fef50ee-7c82-4a6e-9de5-db5a1ed0ec07/queries",
     headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },body: json.encode(queryResultData)
    ); 
    print("query edit${response.statusCode}");
    print(response.body);
    setState(() {
      statusCode = response.statusCode;
      _isLoading = false;
    });
  }

@override
  void initState() {
 
     // widget.model.writeQueryResult(queryId:widget.query.queryId,queryResult: "hello",patientId: widget.query.patientId,queryType: 1);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: mainColor
      ),
    child:
    Scaffold(
      backgroundColor: Color(0xff00000),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff0000),
        actions: <Widget>[
          CircleAvatar(
              radius: 21,
              backgroundColor: Colors.white,
              child: ClipOval(
                  child: SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child:
                          Image.asset('assets/Doctor.png', fit: BoxFit.fill)//:
                          //NetworkImage(_doctor.avatar)
                          )))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView(
          children: <Widget>[
            Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text(": " "تشخيص المريض  ",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              //  Text(_patient.firstName + _patient.lastName)
              ],
            ),
            SizedBox(height: 10),
            Container(
                margin: EdgeInsets.only(right: 80),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Text(": " "تاريخ التشخيص ",
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                   // Text(_query.queryDate)
                  ],
                )),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                Text(" : استعلام من نوع "), 
                 Container(
                      padding: EdgeInsets.symmetric(horizontal:10,vertical:6),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: widget.query.queryType==null?
                      Text("زيارة طبية",style: TextStyle(color:Colors.white,fontSize:14),):
                      Text("",style: TextStyle(color:Colors.white,fontSize:14),)
                    )
                
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "الاستعلام",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 10),
            Container(
              
              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Text(widget.query.queryData,
              style: TextStyle(color:Colors.black,fontSize: 14,),textDirection: TextDirection.rtl,),
            ),
            SizedBox(height: 10),
            Text(
              "التشخيص",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Directionality(textDirection: TextDirection.rtl, child: 
              TextFormField(
                controller: _queryResultController,
                decoration: InputDecoration(contentPadding:EdgeInsets.symmetric(horizontal:10),
                filled: true,
                fillColor: Colors.white,
                ),
                maxLines: 10,
                onSaved: (String value){
                //  _query.queryResult=value;
                },
              )),
            ),
            SizedBox(height: 10),
            Text(
              "الأدوية المطلوبة",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(top: 10, right: 10, left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: Column(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  // inputColumn(),
                  CheckboxListTile(
                      title: medicine == ''
                          ? Text(
                              "اسم الدواء",
                              textDirection: TextDirection.rtl,
                            )
                          : Text(medicine),
                      subtitle: note == ""
                          ? Text(
                              "\n"
                              "الجرعة"
                              "\n"
                              "مدة الدواء"
                              "\n"
                              "ملاحظات"
                              "\n",
                              textDirection: TextDirection.rtl,
                            )
                          : Text(note),
                      value: boolValue,
                      onChanged: (bool boolValue) {
                        boolValue = true;
                      }),
                  addDeleteButtons()
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "التحاليل المطلوبة",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(top: 10, right: 10, left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: Column(
                children: <Widget>[
                  CheckboxListTile(
                      title: Text(
                        "اسم التحليل",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        "ملاحظات",
                        textDirection: TextDirection.rtl,
                      ),
                      value: boolValue,
                      onChanged: null),
                  addDeleteButtons()
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "الأشعة المطلوبة",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(top: 10, right: 10, left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: Column(
                children: <Widget>[
                  CheckboxListTile(
                      title: Text("نوع الصورة",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.black)),
                      subtitle: Text(
                        "تصوير" "\n" "ملاحظات",
                        textDirection: TextDirection.rtl,
                      ),
                      value: boolValue,
                      onChanged: null),
                  addDeleteButtons()
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "العمليات",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 10),
            
            Container(
              height: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: Text(''),
            ),
            SizedBox(height: 15),
            saveButton(() async{
             await writeQueryResult(queryResult: _queryResultController.text,queryId: widget.query.queryId,queryType: 1,patientId: widget.query.patientId,queryResultDate:"2020-07-18T21:30:56.000Z" ,approved: true,emergency: false);
            print(_isLoading);
             _isLoading==true?onLoading(context):null;

               if (statusCode == 200) {
                        doneWidget(context);
                        await Future.delayed(Duration(seconds: 1)).then((_) {
                          Navigator.pushNamed(context, "/HomeScreenDr");
                        });
                      } else if (statusCode != 200) {
                        wrongWidget(context);
                        await Future.delayed(Duration(seconds: 2)).then((_) {
                          Navigator.pop(context);
                        });
                      }
                
            })
          ],
        ),
      ),
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
              // return CheckboxListTile(
              //   title: Text(medicine),
              //   value: boolValue,
              //   onChanged: (bool boolValue){
              //     boolValue = true;
              //   });
              return showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AlertDialog(content: inputColumn()
                            // onSaved: (String value){
                            // saveData(value);
                            //  },

                            ),
                        SizedBox(height: 4),
                        // Container(
                        //     padding: EdgeInsets.symmetric(horizontal: 5),
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(8),
                        //         color: Colors.deepOrangeAccent),
                        //     child: RawMaterialButton(
                        //       onPressed: (){
                        //         setState(() {
                        //         checkTile();
                        //         });
                        //          Navigator.pop(context);
                        //       },

                        //       child: Text(
                        //         "تم",
                        //         style: TextStyle(
                        //             color: Colors.white, fontSize: 16),
                        //       ),
                        //     ))
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

  Widget inputColumn() {
    return Column(
      textDirection: TextDirection.rtl,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(hintText: "اسم الدواء"),
                onSaved: (value) {
                  medicine = value;
                },
              )),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 1),
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                maxLines: 3,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  hintText: "الجرعة" "\n" "مدة الدواء" "\n" "ملاحظات" "\n",
                ),
                onSaved: (value) {
                  note = value;
                },
              )),
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.deepOrangeAccent),
            child: RawMaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "تم",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ))
      ],
    );
  }

// Widget checkTile(String medicine,String note){
//       return CheckboxListTile(
//                  title:Text(medicine,style: TextStyle(color:Colors.black),),
//                  subtitle:Text(note),
//                  value: boolValue,
//                 onChanged: (bool boolValue){
//                        boolValue = true;
//                 }
//                 );

// }

}
