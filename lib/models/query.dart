class Query {
  String queryId;
  int queryType;
  String queryData;
  String queryDate;
   String queryResult;
  String queryRequestDate;
  bool emergency;
  bool approved;
  String queryResultDate;
  String patientId;
  String doctorId;

  Query(
      {this.queryId,
      this.queryType,
      this.queryData,
      this.queryDate,
       this.queryResult,
      this.queryRequestDate,
      this.emergency,
      this.approved,
     
      this.queryResultDate,
      this.patientId,
      this.doctorId}); 


   Query.fromJson(Map<String, dynamic> json) {
    queryId = json['queryId'];
    queryType = json['queryType'];
    queryData = json['queryData'];
    queryDate = json['queryDate'];
    emergency = json['emergency'];
    approved = json['approved'];
    queryResult = json['queryResult'];
    queryResultDate = json['queryResultDate'];
    doctorId = json['doctorId'];
    patientId = json['patientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['queryId'] = this.queryId;
    data['queryType'] = this.queryType;
    data['queryData'] = this.queryData;
    data['queryDate'] = this.queryDate;
    data['emergency'] = this.emergency;
    data['approved'] = this.approved;
    data['queryResult'] = this.queryResult;
    data['queryResultDate'] = this.queryResultDate;
    data['doctorId'] = this.doctorId;
    data['patientId'] = this.patientId;
    return data;
  }
   
}
