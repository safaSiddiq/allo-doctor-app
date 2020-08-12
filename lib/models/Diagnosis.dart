
class Medicine {
  String medicineId;
  String medicineName;
  String dose;
  String patientId;

  Medicine(
      {this.medicineId, this.medicineName, this.dose, this.patientId});
 
 
 Medicine.fromJson(Map<String, dynamic> json) {
    medicineId = json['medicineId'];
    medicineName = json['medicineName'];
    dose = json['dose'];
    patientId = json['patientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medicineId'] = this.medicineId;
    data['medicineName'] = this.medicineName;
    data['dose'] = this.dose;
    data['patientId'] = this.patientId;
    return data;
  }
}
 
class Analysis {
  String analysisId;
  String patientId;
  String analysisType;
  String analysisDate;
  String reason;

  Analysis(
      {this.analysisId,
      this.patientId,
      this.analysisType,
      this.analysisDate,
      this.reason});

  Analysis.fromJson(Map<String, dynamic> json) {
    analysisId = json['analysisId'];
    patientId = json['patientId'];
    analysisType = json['analysisType'];
    analysisDate = json['analysisDate'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['analysisId'] = this.analysisId;
    data['patientId'] = this.patientId;
    data['analysisType'] = this.analysisType;
    data['analysisDate'] = this.analysisDate;
    data['reason'] = this.reason;
    return data;
  }
}

class Surgery {
  String surgeryId;
  String patientId;
  String surgeryType;
  String surgeryDate;
  String surgeryPlace;

  Surgery(
      {this.surgeryId,
      this.patientId,
      this.surgeryType,
      this.surgeryDate,
      this.surgeryPlace});

  Surgery.fromJson(Map<String, dynamic> json) {
    surgeryId = json['surgeryId'];
    patientId = json['patientId'];
    surgeryType = json['surgeryType'];
    surgeryDate = json['surgeryDate'];
    surgeryPlace = json['surgeryPlace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surgeryId'] = this.surgeryId;
    data['patientId'] = this.patientId;
    data['surgeryType'] = this.surgeryType;
    data['surgeryDate'] = this.surgeryDate;
    data['surgeryPlace'] = this.surgeryPlace;
    return data;
  }
}

class Xray {
  String xrayId;
  String xrayType;
  String xrayDate;
  String reason;
  String patientId;

  Xray(
      {this.xrayId, this.xrayType, this.xrayDate, this.reason, this.patientId});

  Xray.fromJson(Map<String, dynamic> json) {
    xrayId = json['xrayId'];
    xrayType = json['xrayType'];
    xrayDate = json['xrayDate'];
    reason = json['reason'];
    patientId = json['patientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xrayId'] = this.xrayId;
    data['xrayType'] = this.xrayType;
    data['xrayDate'] = this.xrayDate;
    data['reason'] = this.reason;
    data['patientId'] = this.patientId;
    return data;
  }
}