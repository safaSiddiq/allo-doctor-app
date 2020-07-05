import 'dart:convert';
import 'dart:async';
//import 'dart:js';
import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/models/query.dart';
//import 'package:flutter/material.dart';
import "package:scoped_model/scoped_model.dart";
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PatientModel extends Model {
  List<Patient> _patients = [];
  List<Doctor> _doctors = [];
  List<Query> _queries = [];
  List<Query> _queriesResults = [];
  bool isLoading = false;
  String token;

  List<Patient> get patients {
    return _patients;
  }

  List<Doctor> get doctors {
    return _doctors;
  }

  Future login(String email, String password) async {
    final http.Response response = await http.post("http://192.168.1.36:3000/patients", 
    headers: {
      "Accept": "Application/json",
      'Content-Type': 'Application/json'
    }, body: {
      "email": email,
      "paswword": password
    });
    final Map<String, dynamic> responseData = json.decode(response.body);
    _save(responseData["token"]);
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  Future registrationPatient(
      String firstName,
      String lastName,
      String gender,
      String birthdate,
      String email,
      String userName,
      String password) async {
    final Map<String, dynamic> patient = {
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "birthdate": birthdate,
      "email": email,
      "userName": userName,
      "password": password
    };

    http.Response response = await http.post("http://192.168.1.36:3000/patients",
        headers: {
          "Accept": "Application/json",
         // 'Content-Type': 'Application/json'
        },
        body: patient);
        print("response stuse :${response.statusCode}");
      print("response body :${response.body}");

    var data = json.decode(response.body);
    //  print("response stuse :${response.statusCode}");
    //   print("response body :${response.body}");

    _save(data["token"]);
  }

  Future<Null> writeQuery({
    String queryData,
    int queryType,
    //String queryDate,
  }) async {
    isLoading = true;
    notifyListeners();
    final Map<String, dynamic> query = {
      "queryData": queryData,
      "queryType": queryType,
      // "queryDate":queryDate
    };
    try {
      //final http.Response response =
      await http
          .post("http://192.168.1.36:3000/allo-doctors-queries",
              headers: {
                "Accept": "Application/json",
                'Content-Type': 'Application/json'
              },
              body: json.encode(query))
          .then<Null>((http.Response response) {
        print("response stuse :${response.statusCode}");
        print("response body :${response.body}");
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Query newQuery = Query(
            queryId: responseData["queryId"],
            queryData: queryData,
            // queryDate: queryDate,
            queryType: queryType);
        _queries.add(newQuery);
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future getQueryResultData() async {
    isLoading = true;
    notifyListeners();
    return await http
        .get("http://192.168.1.36:3000/allo-doctors-queries")
        .then<Null>((http.Response response) {
      final List<Query> getQueriesList = [];
      final Map<String, dynamic> queriesList = json.decode(response.body);
      if (queriesList == null) {
        isLoading = false;
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
      isLoading = false;
      notifyListeners();
    }).catchError((Error) {
      isLoading = false;
      notifyListeners();
      return;
    });
  }

  Future<Null> fetchDoctorData() async {
    isLoading = true;
    notifyListeners();
    return await http
        .get("http://192.168.1.36:3000/doctors")
        .then<Null>((http.Response response) {
      final List<Doctor> fetchedDoctorList = [];
      final Map<String, dynamic> doctorListData = json.decode(response.body);
      if (doctorListData == null) {
        isLoading = false;
        notifyListeners();
        return;
      }
      doctorListData.forEach((String doctorId, dynamic doctorData) {
        final Doctor doctor = Doctor(
          doctorId: doctorId,
          firstName: doctorData['first Name'],
          lastName: doctorData['last Name'],
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
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      isLoading = false;
      notifyListeners();
    });
  }
}
