import 'package:allo_doctor/Doctor/ui_widgets/queryCard.dart';
import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/query.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
//import 'package:allo_doctor/models/query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Queries extends StatefulWidget {
  final MainModel model;
  Queries(this.model);
  @override
  _QueriesState createState() => _QueriesState();
}


class _QueriesState extends State<Queries> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
     GlobalKey<RefreshIndicatorState>();
   MainModel _model;
  String _selectedText =  'اختر نوع الاستعلام';
 // List<Query> _queries =[];
  final mainColor = LinearGradient(
    begin: FractionalOffset.bottomCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );
List<Query>_queries;

   Future<Doctor> _doctor;
  @override
  void initState() {
    widget.model.getDoctor().then((_) {
      setState(() {
        _doctor = widget.model.getDoctor();
      });
    });
    widget.model.getQueries().then((_){
      setState(() {
        _queries = widget.model.queries;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: mainColor
      ),
    child:Scaffold(
      backgroundColor: Color(0xFF00000),
       appBar: PreferredSize(
            preferredSize: Size(double.infinity, 100),
            child: AppBar(
              elevation: 0,
              // shape: UnderlineInputBorder(
              //     borderSide:
              //         BorderSide(style: BorderStyle.solid, color: Colors.teal)),
              backgroundColor: Color(0xFF0000),
              actions: <Widget>[              
              Container(
                 width: MediaQuery.of(context).size.width * 0.80,
                margin: EdgeInsets.only(right:24,top:10,bottom:5),
                padding: EdgeInsets.symmetric(horizontal:20,vertical: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: DropdownButtonHideUnderline(
                            child: 
                     DropdownButton<String>(
                      iconDisabledColor: Colors.teal,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Tajawal-Medium',
                      ),
                      value: _selectedText,
                      items: <String>[
                        'اختر نوع الاستعلام',     
                        "طبيب أسنان",
                        'طبيب عيون'
                      ].map((String value) {
                        return 
                        DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String val) {
                        _selectedText = val;
                        setState(() {
                          _selectedText = val;
                        });
                      },
                    ))),       
             
              ],
              bottom:PreferredSize(

                child:bottonsRow() ,
               preferredSize: Size(double.infinity, 90)),
            ),
            ),
            body: RefreshIndicator(
    key: _refreshIndicatorKey,
    onRefresh: _refresh,
    child:
            FutureBuilder(
              future: _doctor,
              builder: (context,snapShot){
                if (snapShot.hasData){
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: _queries.length,
                    itemBuilder: (context,index)=>QueryCard(_model,
                      _queries[index],snapShot.data,_queries[index].patientId,_queries[index].queryId
                    ));
                }else{
                  return Center(
                        child: SpinKitFadingCircle(
                      color: Color(0xFF87C9BF),           
                      size: 35,
                    ));
                }}
            )
    )));
  }
  Future _refresh(){
   widget.model.getDoctor().then((_) {
      setState(() {
        _doctor = widget.model.getDoctor();
      });
    });
    widget.model.getQueries().then((_){
      setState(() {
        _queries = widget.model.queries;
      });
    });

    return _doctor;
 
  }
  
}


Widget bottonsRow(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    textDirection: TextDirection.rtl,
    children: <Widget>[
    SizedBox(width:25),
    RaisedButton(
        color: Colors.white,
        textColor: Colors.black,
        child: Text(
          'تم القبول',
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
       // padding: EdgeInsets.symmetric(horizontal: 5.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        onPressed: (){}),
        SizedBox(width:5),
     RaisedButton(
        color: Colors.white,
        textColor: Colors.black,
        child: Text(
          'تم الرفض',
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      //  padding: EdgeInsets.symmetric(horizontal: 50.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        onPressed: (){}),
        SizedBox(width:5),

        RaisedButton(
        color: Colors.white,
        textColor: Colors.black,
        child: Text(
          'في انتظار الرد',
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
       // padding: EdgeInsets.symmetric(horizontal: 50.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        onPressed: (){}) 
  ],);
}

 