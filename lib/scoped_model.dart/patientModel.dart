import 'dart:convert';
import 'dart:async';
//import 'dart:js';
import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/models/query.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
import "package:scoped_model/scoped_model.dart";
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ConnectedData extends Model {
  Patient _patient;

  List<Doctor> _doctors = [];
  List<Query> _queries = [];
  List<Query> _queriesResults = [];
  bool _isLoading = false;
  String token;
  String _patientId;
  var _statusCode;

   get statusCode{
    return _statusCode;
  } 

  Patient get patient {
    return _patient;
  }

  // String get patientId {
  //   return _patientId;
  // }

  List<Doctor> get doctors {
    return _doctors;
  }
}

class UtilityModel extends ConnectedData {
  bool get isLoading {
    return _isLoading;
  }
}

class PatientModel extends ConnectedData {
  Future login(String username, String password) async {
    final http.Response response =
        await http.post("http://192.168.1.36:3000/allo-doctors-logins",
            headers: {
              "Accept": "Application/json",
              'Content-Type': 'Application/json',
              "Authorization": "Bearer <$token>"
            },
            body: json.encode({
              "username": username,
              "password": password,
            }));
    print("response stuse :${response.statusCode}");
    print("response body :${response.body}");

    final Map<dynamic, dynamic> responseData = json.decode(response.body);

    Patient patient = Patient.fromJson(responseData);
    _patient = patient;

    //print("token ::${responseData}");
    _saveId(responseData["patientId"]);
  }

  _saveId(String patientId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "patientId";
    final value = patientId;

    prefs.setString(key, value);
    _patientId = prefs.getString("patientId");
    ;
  }

  _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;

    prefs.setString(key, value);
  }

  Future registrationPatient(
      {String firstName,
      String lastName,
      String gender,
      String birthdate,
      String email,
      String avatar
      //String userName,
      //String password
      }) async {
    _isLoading = true;
    notifyListeners();
    //final Map<String, dynamic>
    var patient = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "birthdate": birthdate,
      "gender": gender,
      "avatar": avatar
      // "userName": userName,
      //"password": password
    };
    var jsonData = json.encode(patient);
    // var data = json.decode(response.body);
    try {
      final http.Response response = await http.post(
         "http://192.168.1.36:3000/patients",
        //  "http://34.71.92.1:3000/patients",
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
        _saveId(data["patientId"]);
        _patientId = _saveId(data["patientId"]).toString();
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

  // Future getPatient() async {
  // await  http.get(
  //     "http://192.168.1.36:3000/patients/$_patientId",
  //     //  "http://34.71.92.1:3000/patients/$_patientId",
  //     headers: {
  //       "Accept": "Application/json",
  //       'Content-Type': 'Application/json'
  //     },
  //   ).then<Null>((http.Response response) {
  //     print("response stuse get info :${response.statusCode}");
  //     print("response body :${response.body}");
  //   _statusCode =response.statusCode;
  //     var _patientData = json.decode(response.body);

  //     final Patient newPatient = Patient(
  //     //  patientId: _patientId,
  //       patientId: _patientData['patientId'],
  //       firstName: _patientData['firstName'],
  //       lastName: _patientData['lastName'],
  //       birthdate: _patientData["birthdate"],
  //       gender: _patientData["gender"],
  //       avatar: _patientData["avatar"],
  //       email: _patientData["email"],
  //     );
  //    _patient = newPatient;
    
      
  //     notifyListeners();
  //   }).catchError((e) {
   
  //     _isLoading = false;
  //     notifyListeners();
  //   });
  
  // }



  Future<Patient> getPatient() async {
   http.Response response = await http.get(
      "http://192.168.1.36:3000/patients/$_patientId",
      //  "http://34.71.92.1:3000/patients/$_patientId",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
      print("response stuse get info :${response.statusCode}");
      print("response body :${response.body}");
    _statusCode =response.statusCode;
     var _patientData = json.decode(response.body);
  var  _newPatient =Patient(
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
       return  _newPatient;
     // return Patient.fromJson(json.decode(response.body));
  
  }
  Future<Null> writeQuery ({
    String doctorId,
    String queryData,
    int queryType,
    String queryDate,
  }) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> query = {
      "queryData": queryData,
      "queryType": queryType,
      "queryDate":queryDate,
      "doctorId":doctorId
    };
    try {
      //final http.Response response =
      await http
          .post("http://192.168.1.36:3000/patients/${_patientId}/queries",
              headers: {
                "Accept": "Application/json",
                'Content-Type': 'Application/json'
              },
              body: json.encode(query))
          .then<Null>((http.Response response) {
        print("response stuse send query :${response.statusCode}");
        print("response body :${response.body}");
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Query newQuery = Query(
            queryId: responseData["queryId"],
            queryData: queryData,
            queryDate: queryDate,
            queryType: queryType);
        _queries.add(newQuery);
        _statusCode =response.statusCode;
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future getQueryResultData() async {
    _isLoading = true;
    notifyListeners();
    return await http
        .get("http://192.168.1.36:3000/allo-doctors-queries")
        .then<Null>((http.Response response) {
      final List<Query> getQueriesList = [];
      final Map<String, dynamic> queriesList = json.decode(response.body);
      if (queriesList == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      queriesList.forEach((String queryId, dynamic queryData) {
        final query = Query(
            queryId: queryId,
            queryResult: queryData["queryData"],
            queryResultDate: queryData['queryData']);
        getQueriesList.add(query);
      });

      _queriesResults = getQueriesList;
      _isLoading = false;
      notifyListeners();
    }).catchError((Error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  Future fetchDoctorsData() async {
    _isLoading =true;
    notifyListeners();
    await http.get(
    "http://192.168.1.36:3000/doctors",
    //"http://34.71.92.1:3000//doctors",

      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    ).then<Null>((http.Response response) {
      final List<Doctor> fetchedDoctorList = [];
      //final Map<String, dynamic> doctorListData = json.decode(response.body);
      final List<dynamic> doctorListData = json.decode(response.body);
      print("response doctors stuse get doctors :${response.statusCode}");
      print("response body :${response.body}");

      doctorListData.forEach((dynamic doctorData) {
        final Doctor doctor = Doctor(
          doctorId: doctorData["doctorId"],
          firstName: doctorData['firstName'],
          lastName: doctorData['lastName'],
          major: doctorData["major"],
          birthdate: doctorData["birthdate"],
          gender: doctorData["gender"],
          bio: doctorData["bio"],
          avatar: doctorData["avatar"],
          email: doctorData["email"],
        );
        fetchedDoctorList.add(doctor);
      });
      _doctors = fetchedDoctorList;
    });
    _isLoading =false;
    notifyListeners();
  }
}
