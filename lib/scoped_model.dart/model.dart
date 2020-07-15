// import 'dart:convert';

// import 'package:allo_doctor/models/doctor.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:http/http.dart' as http;
// //import 'package:shared_preferences/shared_preferences.dart';


// class ConnectedData extends Model{
 
//   List<Doctor> _doctors=[];
//  // bool isLoading= false;
// }

// //class  UserModel extends ConnectedData{
//   //Future<Map<String,dynamic>>
//   // void authinticate(String email,String password)async{
//   //   isLoading=true;
//   //   notifyListeners();
//   //   final Map<String,dynamic> authData={
//   //     "email":email,
//   //     "password":password,
//   //   };
//   // } 
// //}



// class DoctorModel extends ConnectedData {

// //   Future <Null> fetchDoctorData(){
// //     isLoading=true;
// //     notifyListeners();
// //     return http.get("http://34.71.92.1:3000/doctors")
// //     .then((http.Response response){
// //       final List<Doctor> fetchedDoctorList=[];
// //       final Map<String,dynamic> doctorListData= json.decode(response.body);
// //       if(doctorListData ==null){
// //         isLoading = false;
// //         notifyListeners();
// //         return;
// //       }
// //     doctorListData.forEach((String doctorId,dynamic doctorData){
// //       final Doctor doctor= Doctor(
// //         doctorId : doctorId,
// //         firstName:doctorData['first Name'],
// //         lastName:doctorData['last Name'],
// //         major:doctorData["major"],
// //         birthdate:doctorData["birthdate"],
// //         gender:doctorData["gender"],
// //         bio:doctorData["bio"],
// //         avatar:doctorData["avatar"],
// //         email:doctorData["email"],

// //       );
// //       fetchedDoctorList.add(doctor);
// //     });
// //     _doctors=fetchedDoctorList;
// //     isLoading=false;
// //     notifyListeners();
// //     }).catchError((e){
// //        isLoading = false;
// //      notifyListeners();
// //     });

// //   }
// // }
// //  class UtilityModel extends ConnectedData {
// //   bool get isLoading {
// //     return isLoading;
// //   }
// //}

//  void loginData()async {
//    var body =jsonEncode({
//   "firstName": "omar",
//   "lastName": "ali",
//   "birthdate": "2020-06-27T09:57:19.920Z",
//   "gender": "male",
//   "avatar": "aa",
//   "email": "omarAli"

//    }) ;
//    var response = await
//     http.post("http://34.71.92.1:3000/patients",
//     headers: {
//       "Accept": "Application/json",
//       'Content-Type': 'Application/json' 
//     },
//     body: body
//     );
//       print("response stuse :${response.statusCode}");
//       print("response body :${response.body}");
    
//   }
   
// Future  getPatientData()async{
//    //http://34.71.92.1:3000/doctors/6234f0d1-4822-41bb-8aed-15be668dcb04   

  
//      var response = await http.get("http://34.71.92.1:3000/doctors",
//      headers: {
//       "Accept": "Application/json",
//       'Content-Type': 'Application/json' ,
//     },
//      ); 

//    // return Patient.fromJson(json.decode(response.body));
//      print("response stuse :${response.statusCode}");
//       print("response body :${response.body}");

//    }

// //  Future addQuery(String queryType,String queryData,String queryRequestDate) async{
// //    isLoading = true;
// //    notifyListeners();
// //    final Map<String,dynamic> writeQueryData={
// //      "queryType" :queryType,
// //      "queryData": queryData ,
// //      "queryRequestDate":queryRequestDate,
// //    };
// //    try {
// //      final http.Response response= await http.post("http://34.71.92.1:3000/",body: json.encode(writeQueryData));

// //        if (response.statusCode != 200 && response.statusCode != 201) {
// //         isLoading = false;
// //         notifyListeners();
// //         return false;
// //       }
// //   ///final Map<String,dynamic> responseData=json.decode(response.body);

// //    final Query newQuery= Query(
// //      queryType: queryType,
// //      queryData: queryData,
// //      queryRequestDate: queryRequestDate
// //    );
// //    _queries.add(newQuery);
// //    isLoading = true;
// //    notifyListeners();
// //    return true;
// //    }catch (e) {
// //      isLoading = false;
// //      notifyListeners();
// //    }
   
// //  }

   
// }