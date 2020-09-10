import 'package:allo_doctor/Doctor/ui_widgets/queryCards.dart';
import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/query.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
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
  String _selectedText = 'اختر نوع الاستعلام';
  // List<Query> _queries =[];
  final mainColor = LinearGradient(
    begin: FractionalOffset.bottomCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );
  List<Query> _queries;
  List<Query> _filteredQuery = [];
  int _type = null;
  int _pressed = 0;
  List<Query> _approved = [];
  List<Query> _unapproved = [];
  List<Query> _waiting = [];

   List _list = [];

  Future<Doctor> _doctor;
  @override
  void initState() {
    widget.model.getDoctor().then((_) {
      setState(() {
        _doctor = widget.model.getDoctor();
      });
    });

    widget.model.getQueries().then((_) {
      setState(() {
        _queries = widget.model.queries;
        _filterQuery();
         _approv();
        _unapprov();
        _wait();
      
      });
       
    });
    super.initState();
  }

  void _approv() {
    //  List<Query> tmpList = [];
    for (int i = 0; i < _filteredQuery.length; i++) {
      if (_filteredQuery[i].approved == true) {
        _approved.add(_filteredQuery[i]);
      }
    }
    // setState(() {
    //   _approved = tmpList;
    // });
  }

  void _unapprov() {
    //  List<Query> tmpList = [];
    for (int i = 0; i < _filteredQuery.length; i++) {
      if (_filteredQuery[i].approved == false) {
        _unapproved.add(_filteredQuery[i]);
      }
    }
    // setState(() {
    //   _unapproved = tmpList;
    // });
  }

  void _wait() {
      List<Query> tmpList = [];
    for (int i = 0; i < _filteredQuery.length; i++) {
      if (_filteredQuery[i].approved == null) {
        tmpList.add(_filteredQuery[i]);
      }
      setState(() {
        _waiting = tmpList;
      });
    }
  }

  _filterQuery() {
  //  if (_selectedText != "اختر نوع الاستعلام") {
      if (_type != null) {
      List<Query> tmpList = [];
      for (int i = 0; i < _queries.length; i++) {
        if (0==_queries[i].queryType ) {
          tmpList.add(_queries[i]);
        }
      }
      setState(() {
        _filteredQuery = tmpList;
      });
    //} else if (_selectedText == "اختر نوع الاستعلام") {
       } else if (_type == null) {
      _filteredQuery = _queries;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(gradient: mainColor),
        child: Scaffold(
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
                      margin: EdgeInsets.only(right: 24, top: 10, bottom: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                        iconDisabledColor: Colors.teal,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Tajawal-Medium',
                        ),
                        value: _selectedText,
                        items: <String>[
                          'اختر نوع الاستعلام',
                          "استعلام عام",
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String val) {
                          _selectedText = val;
                          _pressed = 0;
                          setState(() {
                         //   _selectedText = val;
                            // _pressed = 0;

                            if (_selectedText == "استعلام عام") {
                              _type = 0;
                            }
                          });
                        },
                      ))),
                ],
                bottom: PreferredSize(
                    child: bottonsRow(),
                    preferredSize: Size(double.infinity, 90)),
              ),
            ),
            body: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _refresh,
                child: FutureBuilder(
                    future: _doctor,
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                       return  
              
                        _pressed == 0
                            ? _filteredQuery.length == 0
                                ? Center(
                                    child: Text("لا توجد ردود استعلامات  "))
                                : ListView.builder(
                                    itemCount: _filteredQuery
                                        .length, // _queriesResults.length,
                                    itemBuilder: (context, index) => QueryCards(
                                        _model,
                                        _filteredQuery[index],
                                        snapShot.data,
                                        _filteredQuery[index].patientId,
                                        _filteredQuery[index].queryId))
                            : _pressed ==
                                    1  && _pressed != 0// && _pressed !=2 && _pressed !=3
                                ? _approved.length == 0
                                    ? Center(
                                        child:
                                            Text("لا توجد استعلامات تم قبولها"))
                                    : ListView.builder(
                                        itemCount: _approved.length,
                                        //  itemBuilder: (context, index) =>
                                        itemBuilder: (context, index) =>
                                       
                                             QueryCards(
                                                _model,
                                                _approved[index],
                                                snapShot.data,
                                                _approved[index].patientId,
                                                _approved[index].queryId)
                                          
                                        )
                                : _pressed == 2 &&
                                    _pressed != 3 &&
                                    _pressed != 1 &&
                                    _pressed != 0
                                    ? _unapproved.length == 0
                                        ? Center(
                                            child: Text(
                                                "لا توجد استعلامات تم رفضها"))
                                        : ListView.builder(
                                            itemCount: _unapproved.length,
                                            itemBuilder: (context, index) =>
                                              QueryCards(
                                                    _model,
                                                    _unapproved[index],
                                                    snapShot.data,
                                                    _unapproved[index].patientId,
                                                    _unapproved[index].queryId)
                                          
                                            )
                                    : _waiting.length == 0
                                        ? Center(
                                            child: Text(
                                                "لا توجد استعلامات في انتظار الرد عليها "))
                                        : ListView.builder(
                                            itemCount: _waiting.length,
                                            itemBuilder: (context, index) =>QueryCards(
                                                    _model,
                                                    _waiting[index],
                                                    snapShot.data,
                                                    _waiting[index].patientId,
                                                    _waiting[index].queryId)
                                           
                                            );
                      } else {
                        return Center(
                            child: SpinKitFadingCircle(
                          color: Color(0xFF87C9BF),
                          size: 35,
                        ));
                      }
                    })

            
                )));
  }

  Widget bottonsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: <Widget>[
        SizedBox(width: 25),
        RaisedButton(
            color: Colors.white,
            textColor: Colors.black,
            child: Text(
              'تم القبول',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            // padding: EdgeInsets.symmetric(horizontal: 5.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            onPressed: () {
              setState(() {
              
                _pressed = 1 ;
                _list;
            });
            }),
        SizedBox(width: 5),
        RaisedButton(
            color: Colors.white,
            textColor: Colors.black,
            child: Text(
              'تم الرفض',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            //  padding: EdgeInsets.symmetric(horizontal: 50.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            onPressed: () {
              setState(() {
                _list;
                _pressed = 2;
              });
            }),
        SizedBox(width: 5),
        RaisedButton(
            color: Colors.white,
            textColor: Colors.black,
            child: Text(
              'في انتظار الرد',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            // padding: EdgeInsets.symmetric(horizontal: 50.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            onPressed: () {
              // for (int i = 0; i < _filteredQuery.length; i++) {
              //   print("filtt"+_list[i].queryId);
              // }
              //    for (int i = 0; i < _approved.length; i++) {
              //   print("appr"+_approved[i].approved.toString());
              // }
              //    for (int i = 0; i < _unapproved.length; i++) {
              //   print("unss"+_unapproved[i].approved.toString());
              // }
              setState(() {
                
                _pressed = 3;
              });
            })
      ],
    );
  }

  Future _refresh() {
    widget.model.getDoctor().then((_) {
      setState(() {
        _doctor = widget.model.getDoctor();
      });
    });
    widget.model.getQueries().then((_) {
      setState(() {
        _queries = widget.model.queries;
      });
    });

    return widget.model.getQueries();
  }

}
