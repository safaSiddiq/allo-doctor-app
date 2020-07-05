
//import 'package:flutter/foundation.dart'

import 'dart:convert';

class Patient {
   String patientId;
  String firstName;
  String lastName;
  String email;
  String birthdate;
  String gender;
  String avatar;
  String userName;
  String password;
  
  
  Patient({this.patientId, this.firstName, this.lastName,  this.email,
      this.birthdate, this.gender, this.avatar,this.userName,this.password});


 factory Patient.fromJson(Map<String, dynamic> json) {
   return Patient( 
    patientId : json['patientId'],
    firstName : json['firstName'],
    lastName :json['lastName'],
    email : json['email'],
    birthdate : json['birthdate'],
    gender : json['gender'],
    avatar : json['avatar'],
    userName: json["userName"],
    password: json["password"]
   );
  }

  Map<String, dynamic>  toJson()=> {
   // final Map<String, dynamic> data = new Map<String, dynamic>();
    "patientId" : patientId,
    "firstName" : firstName,
    "lastName" : lastName,
    "email" : email,
    "birthdate" : birthdate,
    "gender" : gender,
   " avatar" : avatar,
   "userName":userName,
   "password":password
  };
}