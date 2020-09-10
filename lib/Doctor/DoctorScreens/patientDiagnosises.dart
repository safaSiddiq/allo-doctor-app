import 'package:allo_doctor/Doctor/ui_widgets/diagnosisPreview.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/models/query.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;

class PatientDiagnosises extends StatefulWidget {
  final MainModel model;
  final String patientId;
  PatientDiagnosises(this.patientId,this.model);
  @override
  _PatientDiagnosisesState createState() => _PatientDiagnosisesState();
}

class _PatientDiagnosisesState extends State<PatientDiagnosises> {
final mainColor = LinearGradient(
    begin: FractionalOffset.bottomCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );


  List<Query>_queriesResults = [];

 Future getQueryResultData() async {
//List<Query>_queriesResultsdata=[];
    await http.get(//ed4059a1-0f06-48f1-ab65-3e543cb08f5b   //${widget.patientId}
      "http://34.71.92.1:3000/patients/ed4059a1-0f06-48f1-ab65-3e543cb08f5b/queries",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    ).then<Null>((http.Response response) {
      final List<Query> getQueriesList = [];
      final List<dynamic> queriesList = json.decode(
          utf8.decode(response.bodyBytes)); // json.decode(response.body);
  
      queriesList.forEach((dynamic queryData) {
        final query = Query(
            queryId: queryData["queryId"],
            queryData: queryData['queryData'],
            queryDate: queryData['queryDate'],
            queryType: queryData["queryType"],
            queryResult: queryData["queryResult"],
            queryRequestDate: queryData["queryRequestDate"],
            queryResultDate: queryData["queryResultDate"],
            emergency: queryData["emergency"],
            approved: queryData["approved"],
            patientId: queryData["patientId"],
            doctorId: queryData["doctorId"]);
        getQueriesList.add(query);
      });

      _queriesResults = getQueriesList;
    
    });
     return _queriesResults;
  }


Patient _patient;

Future<Patient> getPatientDr() async {
    http.Response response = await http.get(
      //  "http://192.168.1.36:3000/patients/$_patientId",
      "http://34.71.92.1:3000/patients/${widget.patientId}",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
    print("response stuse get info :${response.statusCode}");
    print("response body :${response.body}");
 
    var _patientData = json
        .decode(utf8.decode(response.bodyBytes)); //json.decode(response.body);
    var _newPatient = Patient(
      //  patientId: _patientId,
      patientId: _patientData['patientId'],
      firstName: _patientData['firstName'],
      lastName: _patientData['lastName'],
      birthdate: _patientData["birthdate"],
      gender: _patientData["gender"],
      avatar: _patientData["avatar"],
      email: _patientData["email"],
    );

    _patient = _newPatient;
    return _newPatient;
    // return Patient.fromJson(json.decode(response.body));
  }

  
@override
  void initState() {
    getQueryResultData().then((_){
      setState(() {
        _queriesResults;
      });
    });

  getPatientDr().then((_){
    setState(() {
      _patient;
    });
  });
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
      appBar:  PreferredSize(
            preferredSize: Size(double.infinity, 105), 
            child:  AppBar(
        backgroundColor: Color(0xff0000),
        elevation: 0,
       
        actions: <Widget>[
           Row(
             children: <Widget>[
                Text("تشخيصات المريض",style: TextStyle(fontSize:20),),
                SizedBox(width:15),
            Container(
            padding: EdgeInsets.only(right:5,top:5,bottom:5),
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
                          child: Image.asset('assets/Doctor.png',
                              fit: BoxFit.fill)))),
                                  
            ],
              ),),
            
        ],
           )
        ],
        bottom: PreferredSize(
            preferredSize: Size(double.infinity, 95), 
            child:Container(
              margin: EdgeInsets.symmetric(vertical:10),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: TextDirection.rtl,
              children: <Widget>[
             FutureBuilder(
               future: getPatientDr(),
               builder: (context,snapShpt){
               if (snapShpt.hasData) {
                 return 
              
                Text(snapShpt.data.firstName + " "+snapShpt.data.lastName,style:TextStyle(color: Colors.white,fontSize:14))
                ;
                 }else {
            return Center(
                child: SpinKitFadingCircle(
              color: Color(0xFF87C9BF),
              size: 15,
            ));
          }
             }),
                SizedBox(width:15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal:18,vertical:10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.deepOrangeAccent
                  ),
                  child: Text("الملف الطبي",style:TextStyle(color: Colors.white,fontSize: 12)),
                ),
               
              ],
            ),
        )))),
      body:Container(
        padding: EdgeInsets.symmetric(vertical:10,horizontal:15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
        ),
        child: ListView.builder(
          itemCount: _queriesResults.length,
          itemBuilder: (context,index)=>
        diagnosisPreview(context,_queriesResults[index])
        )
        
        //  ListView(          
        // children: <Widget>[
        //   diagnosisPreview(context),
        //   SizedBox(height:10),
        //   diagnosisPreview(context),
          
        // ],)
      ),
    ));
  }
}