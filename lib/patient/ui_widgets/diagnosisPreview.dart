import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/query.dart';
import 'package:allo_doctor/patient/patientScreens/diagnosisView.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';


Future<Doctor> getDoctorData(String id) async {  
   http.Response response = await http.get(
   "http://34.71.92.1:3000/doctors/$id",
      headers: {
        "Accept": "Application/json",
        'Content-Type': 'Application/json'
      },
    );
    var _doctorData = json.decode(utf8.decode(response.bodyBytes));
  var  _newDoctor =Doctor(
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
    return  _newDoctor;
     // return Patient.fromJson(json.decode(response.body));
  }



Widget diagnosisPreview(BuildContext context, Query _query){
   MainModel model;
    return Container(
    margin: EdgeInsets.symmetric(vertical:5),
      padding: EdgeInsets.only(top:10,bottom:5,right:25,left:10),
      decoration: BoxDecoration(
     // border: Border(bottom:BorderSide(style: BorderStyle.solid,color:Colors.black)),
        borderRadius: BorderRadius.circular(15),
        color:Colors.grey[200]
      ),
      child: 
      FutureBuilder(
        future: getDoctorData(_query.doctorId),
      builder: (context,snapShot){
        if(snapShot.hasData){
          return 
      
       Column( 
      mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         Row(
           textDirection: TextDirection.rtl,
           children:[
            Text(" : تشخيص طبيب",style: TextStyle(fontSize:13,color:Colors.black),),
            Text(snapShot.data.firstName+" "+ snapShot.data.lastName)
          
           ]),
           Row(
             textDirection: TextDirection.rtl,
           children:[
            Text("  : طبيب مختص",style: TextStyle(fontSize:13,color:Colors.black),),
            Text(snapShot.data.major + "  ")
           ]),
              _query.queryRequestDate !=null?
           Row(
             textDirection: TextDirection.rtl,
           children:[
        
            Text('  : تاريخ التشخيص',style: TextStyle(fontSize:13,color:Colors.black),),
         Text(_query.queryResultDate.substring(0,10))
           ]):Container(),
           Container(
             alignment: Alignment.topLeft,
             child: RaisedButton(
               onPressed:(){
           
                // Navigator.pushNamed(context, "/DiagnosisViewScreen");
                  Navigator.of( context).push(
              MaterialPageRoute(builder: (context) => DiagnosisViewScreen(model,_query)));
              },
             color:  Color(0xFF2B95AF),
             shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
             child: Text('عرض التشخيص',style: TextStyle(color:Colors.white,fontSize:11),),
             ),
           ),
        //   Divider(thickness: 1,color: Colors.teal,),
        ],
      );
        }
         return Center(
                    child: SpinKitFadingCircle(
                  color: Color(0xFF87C9BF),
                  size: 35,
                ));
      }
      ));
    
}