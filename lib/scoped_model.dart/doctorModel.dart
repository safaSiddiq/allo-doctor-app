import 'dart:convert';

import 'package:allo_doctor/models/Diagnosis.dart';
import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/models/query.dart';
//import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ConnectedDatas extends Model{

  Doctor _doctor;
  List<Patient>_patients = [];
  List<Query> _queries = [];
  //List<Query> _queriesResults = [];
  
  bool _isLoading = false;
  String _doctorId;
  String invitationCode;
  List _invitationCodes=[];
  Medicine _newMedicine;
  List<String> _patientIds = [];

  List<dynamic> _rating;

  List<dynamic> get rating{
    return _rating;
  }
   
   List<String> get patientIds{
     return _patientIds;
   }
  


  String get doctorId{
    return _doctorId;
  }
List<String >get initationCodes {
  return _invitationCodes;
}
   var _statusCode;

   get statusCode{
    return _statusCode;
  } 
    List<Patient> get patients {
    return _patients;
  }
  Doctor get doctor {
    return _doctor;
  }
  
List<Query> get queries{
  return _queries;
}


Medicine get newMedicine{
  return _newMedicine;
}
}

class UtilityModels extends ConnectedDatas {
  bool get isLoadings {
    return _isLoading;
  }}

class DoctorModel extends ConnectedDatas{

  Future creatinvitationCode(String email)async{

    _isLoading = true;
    notifyListeners();

    Map<String,dynamic> data ={
      "email":email,
      "callcenter":true
    };
final http.Response response = await http.post("http://34.71.92.1:3000/allo-doctors-invitations",
  headers: {
              "Accept": "Application/json",
              'Content-Type': 'Application/json',
            },
  body: json.encode(data)
);
_statusCode =response.statusCode;
final Map<dynamic, dynamic> responseData = json.decode(response.body);

print("statusCode invetation${response.statusCode}");

print("body invetation${response.body}");  
   _saveInvitation(responseData["invitationCode"]);

   _isLoading =false;
   notifyListeners();
  }

  _saveInvitation(String _invitationCode ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "invitationCode";
    final value = _invitationCode;

    prefs.setString(key, value);
    invitationCode = prefs.getString("invitationCode");
    ;
  }


  Future getInvitationCode()async{
    _isLoading = true;
    notifyListeners();

    final http.Response response = await http.get("http://34.71.92.1:3000/allo-doctors-invitations",
     headers: {
              "Accept": "Application/json",
              'Content-Type': 'Application/json',
            },
    );

    List<String>fetchedCodes=[];
    List<dynamic> responseData = json.decode(response.body);
    print("statusCode invetation${response.statusCode}");
   // print("body invetation${response.body}");  
    responseData.forEach((dynamic data){
      final invitationCode = data["invitationCode"];
      fetchedCodes.add(invitationCode);

    });
      _invitationCodes = fetchedCodes;
     // print(_invitationCodes);
     _isLoading =false;
     notifyListeners();
  }

    _saveId(String doctorId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "doctorId";
    final value =doctorId;

    prefs.setString(key, value);
    _doctorId = prefs.getString("doctorId");
    ;
  }



  Future registrationDoctor(
      {String firstName,
      String lastName,
      String gender,
      String major,
      String birthdate,
      String email,
      String avatar,
      String bio
      //String userName,
      //String password
      }) async {
    _isLoading = true;
    notifyListeners();
    //final Map<String, dynamic>
    var patient = {
      "firstName": firstName,
      "lastName": lastName,
      "major":major,
       "birthdate": birthdate,
    "bio":bio,
     "avatar":avatar,
      "gender": gender,
        "email": email,
      // "userName": userName,
      //"password": password
    };//json.decode(utf8.decode(response.bodyBytes))
    var jsonData =utf8.encode(json.encode(patient));
    // var data = json.decode(response.body);
    try {
      final http.Response response = await http.post(
      //   "http://192.168.1.36:3000/patients",
         "http://34.71.92.1:3000/doctors",
          headers: {
            "Accept": "Application/json",
            "Content-Type": "application/json"
          },
          body: jsonData);
      print("response stuse registration :${response.statusCode}");
      print("response body :${response.body}");
      _statusCode = response.statusCode;
      if (response.statusCode == 200) {
        _isLoading = false;
        notifyListeners();

        var data = json.decode(response.body); 
        _doctorId = data["doctorId"];
         
        _saveId(data["doctorId"]);
        _doctorId = _saveId(data["doctorId"]).toString();
        // _saveToken(data["token"]);
      }

       _isLoading = false;
        notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
   
  }



  

  Future<Doctor> getDoctor() async {
   var id ="d44adeef-03fe-4af6-8ef0-b6c7db377d2f";
   http.Response response = await http.get(
    //  "http://192.168.1.36:3000/patients/$_patientId",
  
    // "http://34.71.92.1:3000/doctors/$_doctorId",//1fef50ee-7c82-4a6e-9de5-db5a1ed0ec07
   "http://34.71.92.1:3000/doctors/$id",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
    _statusCode =response.statusCode;
     var _doctorData =json
        .decode(utf8.decode(response.bodyBytes));
        print(_doctorData);
  var  _newDoctor =Doctor(
      //  patientId: _patientId,
        doctorId: _doctorData['doctorId'],
        firstName: _doctorData['firstName'],
        lastName: _doctorData['lastName'],
        birthdate: _doctorData["birthdate"],
        gender: _doctorData["gender"],
        major: _doctorData["major"],
        avatar: _doctorData["avatar"],
        bio: _doctorData["bio"],
        email: _doctorData["email"],

      );
      _doctor = _newDoctor;
       return  _newDoctor;
     // return Patient.fromJson(json.decode(response.body));
  }




  Future getQueries()async{

      await http.get(
        "http://34.71.92.1:3000/doctors/d44adeef-03fe-4af6-8ef0-b6c7db377d2f/queries",
// "http://34.71.92.1:3000/allo-doctors-queries/4bf9db8d-142b-4d3b-bf16-c09a599b0713",   
     headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    ).then<Null>((http.Response response){
      List<Query> fetchedQueries =[];
       final List<dynamic> queryListData =   json.decode(utf8.decode(response.bodyBytes));// json.decode(response.body);
      print("response doctors stuse get queries :${response.statusCode}");
      print("response body :${response.body}");

     queryListData.forEach((dynamic queryData) {
        final Query query = Query(
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
          doctorId: queryData["doctorId"]
        );
        fetchedQueries.add(query);
        _patientIds.add(query.patientId);
      });

      _queries = fetchedQueries;
      _isLoading = false;
      notifyListeners();
    });
  }


  Future writeQueryResult({
    
    String queryId,
    int queryType,
    String queryResult,
    String queryResultDate,
    String patientId,
    bool approved,
    bool emergency}

  )async{


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
  }



 Future getPatientsData() async {
    _isLoading =true;
    notifyListeners();
    await http.get(
   // "http://192.168.1.36:3000/doctors",
    "http://34.71.92.1:3000/patients",

      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    ).then<Null>((http.Response response) {
      final List<Patient> patientsList = [];
      //final Map<String, dynamic> doctorListData = json.decode(response.body);
      final List<dynamic> doctorListData = json.decode(response.body);
      print("response doctors stuse get patients :${response.statusCode}");
      print("response body :${response.body}");

      doctorListData.forEach((dynamic doctorData) {
        final Patient patient = Patient(
          patientId: doctorData["patientId"],
          firstName: doctorData['firstName'],
          lastName: doctorData['lastName'],
       
          birthdate: doctorData["birthdate"],
          gender: doctorData["gender"],
         
          avatar: doctorData["avatar"],
          email: doctorData["email"],
        );
        patientsList.add(patient);
      });
      _patients = patientsList;
    });
    _isLoading =false;
    notifyListeners();
  }

Future<Patient> getPatientDr(String patientId) async {
    http.Response response = await http.get(
      //  "http://192.168.1.36:3000/patients/$_patientId",
      "http://34.71.92.1:3000/patients/$patientId",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
    print("response stuse get info :${response.statusCode}");
    print("response body :${response.body}");
    _statusCode = response.statusCode;
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

    
    return _newPatient;
    // return Patient.fromJson(json.decode(response.body));
  }
Future updateDoctorData({
  String firstName,
      String lastName,
      String email,
       String avatar,
     String birthdate,
     String bio
    // String gender
})async{

  _isLoading = true;
  notifyListeners();
final Map<String,dynamic> updateData = {
   "firstName": firstName,
      "lastName": lastName,
    //  "email": email,
       "birthdate": birthdate,
       "bio":bio,
      // "gender": gender,
       "avatar": avatar
};

String id ="d44adeef-03fe-4af6-8ef0-b6c7db377d2f";
  final http.Response response = await http.patch("http://34.71.92.1:3000/doctors/$id",
    headers: {
                "Accept": "Application/json",
                'Content-Type': 'Application/json',
              },
              body: json.encode(updateData)
  );

 _statusCode =response.statusCode;


}


Future getRating()async{
   http.Response response =await http.get("http://34.71.92.1:3000/doctors/d44adeef-03fe-4af6-8ef0-b6c7db377d2f/ratings",
     headers: {
                "Accept": "Application/json",
                'Content-Type': 'Application/json',
              },
  
   );

     List<dynamic> _ratingData =json.decode(response.body);
        print(_ratingData);
        List _ratings=[];

        _ratingData.forEach((dynamic data){
          final item = data["ratingStars"];

          _ratings.add(item);

        });
        _rating = _ratings;
        return _ratings;


}



Future addmedicine({String id,String medicineName ,String  dose} )async{

  final Map<String,dynamic> medicine = {
    "medicineName": medicineName,
    "dose":dose,
    //"patientId":id

};

  final http.Response response = await http.post("http://34.71.92.1:3000/patients/$id/medicines",
     headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
      body: json.encode(medicine)
  );

  print("mediciiiiine   ${response.statusCode}");
  print(response.body);

  var responseData = json.decode(response.body);

  var _medicineData = Medicine(
    medicineId: responseData["medicineId"],
    medicineName: responseData["medicineName"],
    dose: responseData["dose"],
    patientId: responseData["patientId"],
  );
  _medicineData = _newMedicine;
  return _medicineData;

}

}