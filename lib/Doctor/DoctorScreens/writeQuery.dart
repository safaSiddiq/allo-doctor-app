

import 'package:allo_doctor/models/Diagnosis.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/models/query.dart';
import 'package:allo_doctor/pages/ui_widgets/doneWidget.dart';
import 'package:allo_doctor/pages/ui_widgets/onLoading.dart';
import 'package:allo_doctor/pages/ui_widgets/wrongWidget.dart';

import 'package:allo_doctor/patient/patientScreens/medicalFile.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WriteQuery extends StatefulWidget {
  final MainModel model;
  final Query query;
  WriteQuery(this.model, this.query);
  @override
  _WriteQueryState createState() => _WriteQueryState();
}

class _WriteQueryState extends State<WriteQuery> {
  int i = 1;
  List<Widget> _listOfWidgets = [];

  List<Widget> _listOfAnalaysis = [];

  TextEditingController _queryResultController = TextEditingController();
//
//  TextEditingController _medicineName = TextEditingController();
//  TextEditingController _dose = TextEditingController();

  var _mControllers = <TextEditingController>[];
  var _dControllers = <TextEditingController>[];

  
  var _xrayControllers = <TextEditingController>[];
  var _xrayNotesController = <TextEditingController>[];

  var _analysisControllers = <TextEditingController>[];
  var _analaysisNotesController = <TextEditingController>[];
  

  // String medicine = '';
  // String note = '';



 List<Widget>_listOfxrays=[];
  final mainColor = LinearGradient(
    begin: FractionalOffset.bottomCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );

  bool _isLoading;
  int statusCode;

  Future writeQueryResult(
      {String queryId,
      int queryType,
      String queryResult,
      String queryResultDate,
      String patientId,
      bool approved,
      bool emergency}) async {
    setState(() {
      _isLoading = true;
    });
    final Map<String, dynamic> queryResultData = {
      "queryId": queryId,
      "queryType": queryType,
      "queryResultDate": queryResultDate,
      "queryResult": queryResult,
      "patientId": patientId,
      "approved": approved,
      "emergency": emergency
    };
    final http.Response response = await http.patch(
        "http://34.71.92.1:3000/doctors/1fef50ee-7c82-4a6e-9de5-db5a1ed0ec07/queries",
        headers: {
          "Accept": "Application/json",
          'Content-Type': 'Application/json'
        },
        body: json.encode(queryResultData));
    print("query edit${response.statusCode}");
    print(response.body);
    setState(() {
      statusCode = response.statusCode;
      _isLoading = false;
    });
  }

Future<Patient> getPatientsData() async {
 var id =widget.query.patientId;
  http.Response response = await http.get(
   // "http://192.168.1.36:3000/doctors",
    "http://34.71.92.1:3000/patients/$id",

      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
  
      //final Map<String, dynamic> doctorListData = json.decode(response.body);
    var data = json.decode(response.body);
      print("response doctors stuse get patients :${response.statusCode}");
      print("response body :${response.body}");

    
        final  patient = Patient(
          patientId: data["patientId"],
          firstName: data['firstName'],
          lastName: data['lastName'],
       
          birthdate: data["birthdate"],
          gender: data["gender"],
         
          avatar: data["avatar"],
          email: data["email"],
        );
     return patient;

  }


  @override
  void initState() {
     getPatientsData().then((_){

     });
    
    setState(() {
     _listOfWidgets.add(_medicineField());
      _listOfAnalaysis.add(_analaysisField());
      _listOfxrays.add(_xRay());
    });

  getPatientsData();
    // widget.model.writeQueryResult(queryId:widget.query.queryId,queryResult: "hello",patientId: widget.query.patientId,queryType: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(gradient: mainColor),
        child: Scaffold(
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
                          child: Image.asset('assets/Doctor.png',
                              fit: BoxFit.fill)  //:
                          //NetworkImage(_doctor.avatar)
                          )))
            ],
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: ListView(
              children: <Widget>[
                FutureBuilder(
                  future: getPatientsData(),
                  builder: (context,snapShot){
                      if(snapShot.hasData){
                        return 
                   
                 Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Text(" : " "تشخيص المريض  ",
                        style: TextStyle(color: Colors.white, fontSize: 14)),
             
                
                  Text( snapShot.data.firstName +" "+snapShot.data.lastName,
                  style: TextStyle(color:Colors.white),
                  )
            
                  ],
                );
                  }else{
             return  Center(
                        child: SpinKitFadingCircle(
                      color: Color(0xFF87C9BF),           
                      size: 35,
                    ));
           }
                }) ,
                SizedBox(height: 10),
                Container(
                    margin: EdgeInsets.only(right: 80),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Text(" : " "تاريخ  الاستعلام ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                      Text(widget.query.queryDate.substring(0,10),  style:
                                TextStyle(color: Colors.white,))
                      ],
                    )),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text(" : استعلام من نوع "),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(4)),
                          child: widget.query.queryType == null
                              ? Text(
                                  "زيارة طبية",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )
                              : Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ))
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
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Text(
                    widget.query.queryData,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
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
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: _queryResultController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        maxLines: 10,
                        onSaved: (String value) {
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
                  padding: EdgeInsets.only(top: 5, right: 10, left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Column(
                      textDirection: TextDirection.rtl, children: _listOfWidgets
                      // //inputColumn(),
                      // // CheckboxListTile(
                      // ListTile(
                      //     title: medicine == ''
                      //         ? Text(
                      //             "اسم الدواء",
                      //             textDirection: TextDirection.rtl,
                      //           )
                      //         : Text(medicine),
                      //     subtitle: note == ""
                      //         ? Text(
                      //             "\n"
                      //             "الجرعة"
                      //             "\n",

                      //             textDirection: TextDirection.rtl,
                      //           )
                      //         : Text(note),
                      //     // value: boolValue,
                      //     // onChanged: (bool boolValue) {
                      //     //   boolValue = true;
                      //     // }
                      //     ),

                      ),
                ),
            Container(child: addDeleteButtons( () {
              i++;
              if (i <= 5) {
                _addmidicineToList();
              }})),
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
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Column(children: _listOfAnalaysis),
                ),
               Container(child: addDeleteButtons((){
                 _addAnlaysisToList();
               })),
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
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Column(
                    children: _listOfxrays
                    
                  
                  ),
                  
                ),
                Container(child: 
             
               addDeleteButtons((){
                  _addXray();
                })),
                SizedBox(height: 10),
                Text(
                  "العمليات",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 10),
                Container(
                  //height: 140,
                padding: EdgeInsets.symmetric(vertical:5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: TextFormField(
                    maxLines: 10,
                  ),
                ),
                SizedBox(height: 15),
                saveButton(() async {   
                  await writeQueryResult(
                      queryResult: _queryResultController.text,
                      queryId: widget.query.queryId,
                      queryType: 1,
                      patientId: widget.query.patientId,
                      queryResultDate: "2020-07-18T21:30:56.000Z",
                      approved: true,
                      emergency: false);
                  print(_isLoading);
                  _isLoading == true ? onLoading(context) : null;

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

  void _onPressed() async {
    print(_listOfWidgets.length);
    for (int j = 0; j < _listOfWidgets.length; j++) {
      if (_mControllers.elementAt(j).text != null) {
        await addmedicine(
            medicineName: _mControllers.elementAt(j).text,
            dose: _dControllers.elementAt(j).text,
            id: widget.query.patientId);

        //    print(_mControllers.elementAt(j).text);
        // }  }

        // await widget.model.addmedicine(medicineName: _medicineName.text,dose: _dose.text,id:widget.query.patientId ).then((_){
        //    writeQueryResult(queryResult: _queryResultController.text,queryId: widget.query.queryId,queryType: 1,patientId: widget.query.patientId,queryResultDate:"2020-07-18T21:30:56.000Z" ,approved: true,emergency: false);

      }
    }
    writeQueryResult(
        queryResult: _queryResultController.text,
        queryId: widget.query.queryId,
        queryType: 1,
        patientId: widget.query.patientId,
        queryResultDate: DateTime.now().toUtc().toIso8601String(),
        approved: true,
        emergency: false);
  }

  _addmidicineToList() {
    List<Widget> tempList = _listOfWidgets;
    tempList.add(_medicineField());
   // tempList.add(_feild());
    setState(() {
      _listOfWidgets = tempList;
    });
  }

  _medicineField() {
    var _medicineName = TextEditingController();
    var _dose = TextEditingController();

    _mControllers.add(_medicineName);
    _dControllers.add(_dose);
    // RelativeRect buttonMenuPosition(BuildContext c) {
    //   final RenderBox bar = c.findRenderObject();
    //   final RenderBox overlay = Overlay.of(c).context.findRenderObject();
    //   final RelativeRect position = RelativeRect.fromRect(
    //     Rect.fromPoints(
    //       bar.localToGlobal(bar.size.center(Offset.zero), ancestor: overlay),
    //       bar.localToGlobal(bar.size.center(Offset.zero), ancestor: overlay),
    //     ),
    //     Offset.zero & overlay.size,
    //   );
      //return position;
   // }

    return  Container(
        margin: EdgeInsets.only(bottom: 6, top: 6),
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey)),
       child:
    
    
    
    ListTile(
       trailing: Container(
      //  alignment: Alignment.center,
      padding: EdgeInsets.only(top:55),
         child:
        IconButton(
         
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              
              size: 30,
            ),
            onPressed: () {
              setState(() {
              //  _listOfphs.removeAt(index);
              });
            },
          )),
    
     title: 
    //  Container(
    //     margin: EdgeInsets.only(bottom: 6, top: 6),
    //     padding: EdgeInsets.symmetric(horizontal: 5),
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(8),
    //         color: Colors.grey[200],
    //         border: Border.all(color: Colors.grey)),
      //  child: Column(
        //  children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(
                  vertical: 1,
                ),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: _medicineName,
                     
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(hintText: "اسم الدواء",//hintStyle: TextStyle(fontSize: 12)
                      ),
                    ))),
          subtitle:   Column(
            children: <Widget>[

         
          Container(
              padding: EdgeInsets.symmetric(
                vertical: 1,
              ),
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _dose,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      hintText: "الجرعة",
                    ),
                    onSaved: (value) {},
                  )),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 1,
              ),
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _dose,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      hintText: "مدة الاستعمال",
                    ),
                    onSaved: (value) {},
                  )),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 1,
              ),
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _dose,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      hintText: "ملاحظات",
                    ),
                    onSaved: (value) {},
                  )),
            ),
          ],
          )
    )
     );
  }


  _addAnlaysisToList() {
    List<Widget> tempList = _listOfAnalaysis;
    tempList.add(_analaysisField());
    setState(() {
      _listOfAnalaysis = tempList;
    });
  }

  _analaysisField() {

     TextEditingController _analaysis = TextEditingController();
    TextEditingController _notes = TextEditingController();
    _analysisControllers.add(_analaysis);
    _analaysisNotesController.add(_notes);
     int index = _listOfAnalaysis.length;
    return Column(

    children:<Widget>[
     ListTile(

     trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
           _listOfAnalaysis.removeAt(index);
              });
            },
          ),

      title:    Container(
              padding: EdgeInsets.symmetric(
                vertical: 1,
              ),
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _analaysis,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(hintText: "اسم التحليل"),
                  ))),
        subtitle:  Container(
            padding: EdgeInsets.symmetric(
              vertical: 1,
            ),
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                   controller: _notes,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText: "ملاحظات",
                  ),
                  onSaved: (value) {},
                )),
          ),
    
    ),
    Divider()
    ]);
  }

  Widget addDeleteButtons(Function function) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RaisedButton(
            color: Color(0xFF2B95AF),
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
            onPressed: function
           
      
              // return showDialog(
              //     context: context,
              //     builder: (context) {
              //       return Center(
              //           child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: <Widget>[
              //           AlertDialog(content: inputColumn()
              //               // onSaved: (String value){
              //               // saveData(value);
              //               //  },

              //               ),
              //          SizedBox(height: 4),
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
              //     ],
              //   ));
              // });
            ),
      ],
    ));
  }



  Future addAnalysis({String id, String analysisType, String reason,String date}) async {
    final Map<String, dynamic> medicine = {
      "analysisType": analysisType,
      "reason": reason,
      "analysisDate":date
      //"patientId":id
    };

    final http.Response response = await http.post(
        "http://34.71.92.1:3000/patients/ed4059a1-0f06-48f1-ab65-3e543cb08f5b/analysis",
        headers: {
          "Accept": "Application/json",
          'Content-Type': 'Application/json'
        },
        body: json.encode(medicine));

    print("  ${response.statusCode}");
    print(response.body);

    var responseData = json.decode(utf8.decode(response.bodyBytes));

    var _medicineData = Analysis(
      analysisId: responseData["analysisId"],
     analysisType : responseData["analysisType"],
      reason: responseData["reason"],
      patientId: responseData["patientId"],
    );
    return _medicineData;
  }


   Future addmedicine({String id, String medicineName, String dose}) async {
    final Map<String, dynamic> medicine = {
      "medicineName": medicineName,
      "dose": dose,
      //"patientId":id
    };

    final http.Response response = await http.post(
        "http://34.71.92.1:3000/patients/$id/medicines",
        headers: {
          "Accept": "Application/json",
          'Content-Type': 'Application/json'
        },
        body: json.encode(medicine));

    print("mediciiiiine   ${response.statusCode}");
    print(response.body);

    var responseData =json.decode(utf8.decode(response.bodyBytes));

    var _medicineData = Medicine(
      medicineId: responseData["medicineId"],
      medicineName: responseData["medicineName"],
      dose: responseData["dose"],
      patientId: responseData["patientId"],
    );
    return _medicineData;
  }


  _addXray() {
    List<Widget> tempList = _listOfxrays;
    tempList.add(_xRay());
    setState(() {
      _listOfxrays = tempList;
    });
  }

 Widget _xRay(){
    TextEditingController _xray = TextEditingController();
    TextEditingController _notes = TextEditingController();
    _xrayControllers.add(_xray);
    _xrayNotesController.add(_notes);
     int index = _listOfxrays.length;
    return
       Column(
        children: <Widget>[
           ListTile(
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            setState(() {
            _listOfxrays.removeAt(index);
            });
          },
        ),
        title: TextField(
          controller: _xray,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'نوع الصورة',
          ),
        ),
        subtitle: TextField(
            controller: _notes,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'ملاحظات'
            )),
      ),
      Divider(color: Colors.grey[300])
        ],
  
    );
  }
  
  

}
