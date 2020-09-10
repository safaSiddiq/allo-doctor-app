import 'dart:convert';
import 'dart:async';
//import 'package:path/path.dart';
//import 'package:http_parser/http_parser.dart';
//import 'dart:js';
import 'package:allo_doctor/models/Diagnosis.dart';
import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/models/query.dart';
//import 'package:mime/mime.dart';
//import 'package:flutter/cupertino.dart';
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
  var _statusCodes;
  Medicine _medicine;

  Medicine get medicine {
    return _medicine;
  }

  get statusCodes {
    return _statusCodes;
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

  List<Query> get queriesResults {
    return _queriesResults;
  }
}

class UtilityModel extends ConnectedData {
  bool get isLoading {
    return _isLoading;
  }
}

class PatientModel extends ConnectedData {
  Future login(String username, String password, String patientid) async {
    print(_patientId);
    final http.Response response =
        await http.post("http://34.71.92.1:3000/allo-doctors-logins",
            headers: {
              "Accept": "Application/json",
              'Content-Type': 'Application/json',
              // "Authorization": "Bearer <$token>",
            },
            body: json.encode({
              "patientId": patientid,
              "username": username,
              "password": password,
            }));
    print("response stuse login :${response.statusCode}");
    print("response body :${response.body}");

    final Map<dynamic, dynamic> responseData = json.decode(response.body);

    // Patient patient = Patient.fromJson(responseData);
    // _patient = patient;

    //print("token ::${responseData}");
    _saveId(responseData["patientId"]);
  }

   Future logins(String username, String password, ) async {
    print(_patientId);
    final http.Response response =
        await http.post("http://34.71.92.1:3000/allo-doctors-logins",
            headers: {
              "Accept": "Application/json",
              'Content-Type': 'Application/json',
              // "Authorization": "Bearer <$token>",
            },
            body: json.encode({
              "username": username,
              "password": password,
            })
            );
    print("response stuse login :${response.statusCode}");
    print("response body :${response.body}");
  
     Map<String,dynamic> responseData = json.decode(response.body);
  print(responseData["userName"]);
    // Patient patient = Patient.fromJson(responseData);
    // _patient = patient;

    //print("token ::${responseData}");
    _saveId(responseData["patientId"]);
    _saveToken(responseData["token"]);
  }


  _saveId(dynamic patientId) async {
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
    var jsonData = utf8.encode(
        json.encode(patient)); // json.decode(utf8.decode(response.bodyBytes));
    // var data = json.decode(response.body);
    try {
      final http.Response response = await http.post(
          //   "http://192.168.1.36:3000/patients",
          "http://34.71.92.1:3000/patients",
          headers: {
            "Accept": "Application/json",
            "Content-Type": "application/json"
          },
          body: jsonData);
      print("response stuse registration :${response.statusCode}");
      print("response body :${response.body}");
      _statusCodes = response.statusCode;
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
      //  "http://192.168.1.36:3000/patients/$_patientId",
      "http://34.71.92.1:3000/patients/$_patientId",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
    print("response stuse get info :${response.statusCode}");
    print("response body :${response.body}");
    _statusCodes = response.statusCode;
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

  Future<Null> writeQuery({
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
      "queryDate": queryDate,
      "doctorId": doctorId
    };
    try {
      print(_patientId);
      //final thttp.Response response =
      await http
          //.post("http://192.168.1.36:3000/patients/${_patientId}/queries",
          .post("http://34.71.92.1:3000/patients/${_patientId}/queries",
              headers: {
                "Accept": "Application/json",
                'Content-Type': 'Application/json'
              },
              // json.decode(utf8.decode(response.bodyBytes));
              body: utf8.encode(json.encode(query)))

          ///json.encode(utf8.encode(query)))
          .then<Null>((http.Response response) {
        print("response stuse send query :${response.statusCode}");
        print("response body :${response.body}");
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Query newQuery = Query(
            queryId: responseData["queryId"],
            queryData: responseData["queryData"],
            queryDate: responseData["queryDate"],
            queryType: responseData["queryType"],
            doctorId: responseData["doctorId"],
            patientId: responseData["patientId"]);
        _queries.add(newQuery);
        _statusCodes = response.statusCode;
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
//   Future<Map<String, dynamic>> uploadImage(File image) async {
//     String fileName = image.path.split('/').last;

//     FormData data = FormData.fromMap({
//       "avatar": await MultipartFile.fromFile(
//         image.path,
//         filename: fileName,
//         contentType: MediaType("image", "jpg"),
//       ),
//       "type": "image/jpg"
//     });

//     Dio dio = Dio();

//     dio
//         .post(
//           "http://34.71.92.1:3000/patients",

//           data: data,
//           options: Options(
//             contentType: " Application/json",
//             method: 'POST',
//             headers: {
//               //    "Accept": "/",
//               'Content-Type': 'multipart/form-data',
//               //  contentType: Headers.jsonContentType,
//               //  "Accept": "Application/json",
//               //    'Content-Type': 'Application/json',
//               // 'Authorization' :    'Bearer ${token}'
//             },
//             //  responseType: ResponseType.json,
//           ),
//         )
//         .then((response) => print(response.statusCode));
// // var uri = Uri.parse('https://example.com/create');
// // var request = http.MultipartRequest('POST', uri)
// //   ..fields['user'] = 'nweiz@google.com'
// //   ..files.add(await http.MultipartFile.fromPath(
// //       'package', 'build/package.tar.gz',
// //       contentType: MediaType('application', 'x-tar')));
// // var response = await request.send();
// // if (response.statusCode == 200) print('Uploaded!');
//   }

  Future updatePatientData({
    String firstName,
    String lastName,
    String email,
    String avatar,
    String birthdate,
  }) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      "patientId":_patientId,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "birthdate": birthdate,
      "gender":"MALE",    
   // "avatar":utf8.encode(avatar.path)//==null?"": imageUrl
    "avatar": avatar
    };

    final http.Response response =
        await http.patch("http://34.71.92.1:3000/patients/$_patientId",
            headers: {
              "Accept": "Application/json",
              'Content-Type': 'Application/json',
            },
            body: utf8.encode(json.encode(updateData)) // json.encode(updateData)
            );
    _statusCodes = response.statusCode;
//  return  Patient.fromJson(json.decode(response.body));
  }

  Future getQueryResultData() async {
    _isLoading = true;
    notifyListeners();
    await http.get(//ed4059a1-0f06-48f1-ab65-3e543cb08f5b
      "http://34.71.92.1:3000/patients/ed4059a1-0f06-48f1-ab65-3e543cb08f5b/queries",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    ).then<Null>((http.Response response) {
      final List<Query> getQueriesList = [];
      final List<dynamic> queriesList = json.decode(
          utf8.decode(response.bodyBytes)); // json.decode(response.body);
      // print("response doctors stuse get queries :${response.statusCode}");
      // print("response body :${response.body}");
      // if (queriesList == null) {
      //   _isLoading = false;
      //   notifyListeners();
      //   return;
      // }
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
      _isLoading = false;
      notifyListeners();
    });
  }

  Future fetchDoctorsData() async {
    _isLoading = true;
    notifyListeners();
    await http.get(
      // "http://192.168.1.36:3000/doctors",
      "http://34.71.92.1:3000//doctors",

      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    ).then<Null>((http.Response response) {
      var arab = utf8.decode(response.bodyBytes);

      final List<Doctor> fetchedDoctorList = [];
      //final Map<String, dynamic> doctorListData = json.decode(response.body);
      final List<dynamic> doctorListData =
          json.decode(arab); //json.decode(response.body);
      // print("response doctors stuse get doctors :${response.statusCode}");
      // print("response body :${response.body}");
      print("arab" + utf8.decode(response.bodyBytes));

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
    _isLoading = false;
    notifyListeners();
  }

  Future<Null> writeQueryDr({
    String patientId,
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
      "queryDate": queryDate,
      "doctorId": doctorId
    };
    try {
      //final thttp.Response response =
      await http
          //.post("http://192.168.1.36:3000/patients/${_patientId}/queries",
          .post("http://34.71.92.1:3000/patients/${patientId}/queries",
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
            queryData: responseData["queryData"],
            queryDate: responseData["queryDate"],
            queryType: responseData["queryType"],
            doctorId: responseData["doctorId"],
            patientId: responseData["patientId"]);
        _queries.add(newQuery);
        _statusCodes = response.statusCode;
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Doctor> getDoctorData(String id) async {
    http.Response response = await http.get(
      "http://34.71.92.1:3000/doctors/$id",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
    
    var _doctorData = json.decode(utf8.decode(response.bodyBytes));

    var _newDoctor = Doctor(
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
    return _newDoctor;
    // return Patient.fromJson(json.decode(response.body));
  }

  Future<Medicine> getMedicine() async {
    final http.Response response = await http.get(
      "http://34.71.92.1:3000/patients/${_patientId}/medicines",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
    print("response mediccciiiinnnn :${response.statusCode}");
    print("response body :${response.body}");

    var responseData = json
        .decode(utf8.decode(response.bodyBytes)); //json.decode(response.body);
    var _medicineData = Medicine(
      medicineId: responseData["medicineId"],
      medicineName: responseData["medicineName"],
      dose: responseData["dose"],
      patientId: responseData["patientId"],
    );

    _medicineData = _medicine;
    return _medicineData;
  }
}
