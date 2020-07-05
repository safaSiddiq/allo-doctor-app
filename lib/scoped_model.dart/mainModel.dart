import 'package:allo_doctor/scoped_model.dart/model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model.dart/model.dart';
import 'package:allo_doctor/scoped_model.dart/patientModel.dart';


class MainModel extends Model with  PatientModel,DoctorModel,ConnectedData
//UtilityModel
{

}