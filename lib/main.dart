import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/models/query.dart';
import 'package:allo_doctor/pages/introScreen.dart';
import 'package:allo_doctor/pages/invitationAsk.dart';
import 'package:allo_doctor/pages/invitationCheck.dart';
import 'package:allo_doctor/pages/loginScreen.dart';
import 'package:allo_doctor/patient/patientScreens/callCenterScreen.dart';
import 'package:allo_doctor/patient/patientScreens/chatScreen.dart';
import 'package:allo_doctor/patient/patientScreens/diagnosisView.dart';
import 'package:allo_doctor/patient/patientScreens/diagnosisesScreesn.dart';
import 'package:allo_doctor/patient/patientScreens/doctorFile.dart';
import 'package:allo_doctor/patient/patientScreens/doctorsSearch.dart';

import 'package:allo_doctor/patient/patientScreens/fillQueryDr.dart';
import 'package:allo_doctor/patient/patientScreens/homeScreeen.dart';
import 'package:allo_doctor/patient/patientScreens/massagesScreen.dart';
import 'package:allo_doctor/patient/patientScreens/medicalFile.dart';
import 'package:allo_doctor/patient/patientScreens/personalInfoScreen.dart';
import 'package:allo_doctor/patient/patientScreens/queriesReplaies.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './scoped_model.dart/mainModel.dart';
import 'Doctor/DoctorScreens/chatScreen.dart';
import 'Doctor/DoctorScreens/diagnosis.dart';
import 'Doctor/DoctorScreens/homeScreen.dart';
import 'Doctor/DoctorScreens/messageScreen.dart';
import 'Doctor/DoctorScreens/patientMidicalFile.dart';
import 'Doctor/DoctorScreens/patientsScreen.dart';
import 'Doctor/DoctorScreens/personalInfo.dart';
import 'Doctor/DoctorScreens/queries.dart';
import 'pages/registrationASdoctor.dart';
import 'pages/registrationASpatient.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final dynamic snapShot = dynamic;
  final Doctor doctor = Doctor();
  final MainModel model = MainModel();
  final Patient patient = Patient();
  final Query query = Query();
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: model,
        child: MaterialApp(
            title: 'Allo Doctor',
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              fontFamily: 'Tajawal-Medium',
              //  primaryTextTheme: TextTheme(body1:TextStyle(color: Colors.white))
            ),
            routes: {
              "/LoginScreen": (BuildContext context) => LoginScreen(model),
              "/RegistrationASpatient": (BuildContext context) =>
                  RegistrationASpatient(model),
              "/RegistrationASdoctor": (BuildContext context) =>
                  RegistrationASdoctor(model),
              "/InvitationAsk": (BuildContext context) => InvitationAsk(model),
              "/InvitationCkech": (BuildContext context) =>
                  InvitationCkech(model),
              "/homeScreenPatient": (BuildContext context) =>
                  HomeScreenPatient(model),

              "/CallCenterScreen": (BuildContext context) => CallCenterScreen(),
              "/ChatScreen": (BuildContext context) => ChatScreen(),
              "/DiagnosisesScreen": (BuildContext context) =>
                  DiagnosisesScreen(model),
              "/DiagnosisViewScreen": (BuildContext context) =>
                  DiagnosisViewScreen(model, query),
              "/DoctorFileScreen": (BuildContext context) =>
                  DoctorFileScreen(model, doctor, snapShot),
              "/DoctorsSearch": (BuildContext context) => DoctorsSearch(model),
              "/FillQueryDrScreen": (BuildContext context) =>
                  FillQueryDrScreen(model, doctor, snapShot),
              "/MassagesScreen": (BuildContext context) => MassagesScreen(),
              "/MedicalFile": (BuildContext context) => MedicalFile(),
              "/PesronalinfoScreen": (BuildContext context) =>
                  PesronalinfoScreen(model),
              "/QueriesReplaies": (BuildContext context) =>
                  QueriesReplaies(model),
              "/HomeScreenDr": (BuildContext context) => HomeScreenDr(model),
              "/DrChatScreen": (BuildContext context) => DrChatScreen(),
              "/Diagnosis": (BuildContext context) => Diagnosis(),
              "/DrMessageScreen": (BuildContext context) => DrMessageScreen(),
              // "/PatientDiagnosises": (BuildContext context) =>
              //     PatientDiagnosises(),
              "/PatientMidicalFile": (BuildContext context) =>
                  PatientMidicalFile(model, patient),
              "/PatientsScreen": (BuildContext context) =>
                  PatientsScreen(model),
              "/DrPersonalInfo": (BuildContext context) =>
                  DrPersonalInfo(model),
              "/Queries": (BuildContext context) => Queries(model),
              //"/QueryView": (BuildContext context) => QueryView(model,query),
              // "/WriteQuery": (BuildContext context) => WriteQuery(),
            },
            home: Directionality(
              textDirection: TextDirection.rtl,
              child: IntroScreen(),
            )));
  }
}
