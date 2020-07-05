//import 'package:flutter/foundation.dart';

class Doctor {
  String doctorId;
  String firstName;
  String lastName;
  String major;
  String birthdate;
  String gender;
  String bio;
  String avatar;
  String email;

  
  Doctor({this.doctorId, this.firstName, this.lastName, this.major,
      this.birthdate, this.gender, this.bio, this.avatar, this.email});


  Doctor.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctorId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    major = json['major'];
    birthdate = json['birthdate'];
    gender = json['gender'];
    bio = json['bio'];
    avatar = json['avatar'];
    email = json['email'];
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorId'] = this.doctorId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['major'] = this.major;
    data['birthdate'] = this.birthdate;
    data['gender'] = this.gender;
    data['bio'] = this.bio;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    return data;
}
}