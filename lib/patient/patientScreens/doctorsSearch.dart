//import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
import '../ui_widgets/doctorCard.dart';

class DoctorsSearch extends StatefulWidget {
  final MainModel model;
  DoctorsSearch(this.model);
  @override
  _DoctorsSearchState createState() => _DoctorsSearchState();
}

class _DoctorsSearchState extends State<DoctorsSearch> {
  bool sort = false;
  bool _isDisable = true;
  TextEditingController editingController = TextEditingController();
  String _selectedText1 = "بالتخصص";
  String _selectedText2 = "بالدرجة العلمية";

  final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.center,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );
  List<Doctor> _doctors;
  List<Doctor> _filtered;
  Future<Patient> _patient;

  @override
  initState() {
    widget.model.fetchDoctorsData().then((_) {
      setState(() {
        _doctors = widget.model.doctors;
        filter();
        //   _filtered = _doctors;
      });
    });

    widget.model.getPatient().then((_) {
      setState(() {
        _patient = widget.model.getPatient();
      });
    });
    super.initState();
  }

  void _unsort() {
    if (sort == true) {
      setState(() {
        _doctors.sort((a, b) => a.firstName.compareTo(b.firstName));
      });
    } else if (sort = false) {
      setState(() {
        _doctors = widget.model.doctors;
      });
    }
  }

  void filter() {
    if (_selectedText1 != "بالتخصص") {
      List<Doctor> tmpList = [];
      for (int i = 0; i < _doctors.length; i++) {
        if (_selectedText1 == _doctors[i].major) {
          tmpList.add(_doctors[i]);
        }
      }

      _filtered = tmpList;
    } else if (_selectedText1 == "بالتخصص") {
      _filtered = _doctors;
    }
  }
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Container(
          decoration: BoxDecoration(gradient: mainColor),
          child: Scaffold(
              backgroundColor: Color(0xFF00000),
              appBar: PreferredSize(
                  preferredSize: Size(double.infinity, 120), // 44 is the height
                  child: AppBar(
                    elevation: 0,
                    // shape: UnderlineInputBorder(
                    //     borderSide: BorderSide(
                    //         style: BorderStyle.solid, color: Colors.teal)),
                    backgroundColor: Color(0xFF0000),
                    actions: <Widget>[
                      RawMaterialButton(
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate:
                                    DataSearch(_doctors, widget.model.patient));

                            //  showSearch(
                            //    context: context,
                            //   delegate: CustomSearchDelegate());
                          },
                          child: Container(
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              margin: EdgeInsets.only(
                                top: 10,
                                bottom: 2,
                                right: 30,
                              ),
                              //width: 280,
                              width: MediaQuery.of(context).size.width * 0.78,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {}))),
                    ],
                    bottom: PreferredSize(
                        preferredSize: Size(double.infinity, 80),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              textDirection: TextDirection.rtl,
                              children: [
                                SizedBox(width: 24),
                                RaisedButton(
                                    onPressed: _isDisable == true
                                        ? () {
                                            // _doctors.sort((a, b) =>
                                            //     a.firstName.compareTo(b.firstName));
                                            // setState(() {
                                            //   sort = !sort;
                                            // });

                                            setState(() {
                                              sort = true;
                                              _unsort();
                                              _isDisable = false;
                                            });
                                          }
                                        : null,
                                    // color: sort == false?
                                    color: Colors.white,
                                    //     : Colors.blueGrey[100],
                                    textColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Row(
                                        textDirection: TextDirection.rtl,
                                        children: [
                                          Text(
                                            ' بالـإسم',
                                            style: TextStyle(fontSize: 11),
                                            textAlign: TextAlign.center,
                                          ),
                                          Icon(
                                            Icons.arrow_upward,
                                            size: 13,
                                            color: Color(0xFF2B95AF),
                                          ),
                                          Icon(
                                            Icons.arrow_downward,
                                            size: 13,
                                            color: Color(0xFF2B95AF),
                                          ),
                                        ])),
                                SizedBox(width: 8),
                                Container(
                                    height: 35,
                                    padding: EdgeInsets.only(left: 6),
                                    alignment: Alignment.topRight,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                      icon: Container(
                                        //padding: EdgeInsets.only(left:5,right: 2),
                                        child: Icon(
                                          Icons.arrow_drop_down,
                                          size: 24,
                                          color: Color(0xFF2B95AF),
                                        ),
                                      ),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontFamily: 'Tajawal-Medium'),
                                      value: _selectedText1,
                                      items: <String>[
                                        // 'بالتخصص',
                                        'بالتخصص',
                                        'طبيب جراحة',
                                        "طبيب باطينية",
                                        "طبيب نساء",
                                        "طبيب أذن و حنجرة",
                                        "طبيب قلب",
                                        "طبيب أسنان",
                                        'طبيب عيون'
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String val) {
                                        _selectedText1 = val;
                                        setState(() {
                                          _selectedText1 = val;
                                          filter();
                                        });
                                      },
                                    ))),
                                SizedBox(width: 8),
                                Container(
                                    height: 35,
                                    padding: EdgeInsets.only(left: 6),
                                    alignment: Alignment.topRight,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                      icon: Container(
                                        // padding: EdgeInsets.only(left:2),
                                        child: Icon(
                                          Icons.arrow_drop_down,
                                          size: 24,
                                          color: Color(0xFF2B95AF),
                                        ),
                                      ),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontFamily: 'Tajawal-Medium'),
                                      //hint: Text('الجنس'),
                                      value: _selectedText2,
                                      items: <String>['بالدرجة العلمية', 'أنثى']
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String val) {
                                        _selectedText2 = val;
                                        setState(() {
                                          _selectedText2 = val;
                                        });
                                      },
                                    ))),
                              ]),
                        )),
                  )),
              body: FutureBuilder(
                  future: _patient,
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      if(_filtered.length == 0){
                              return Center(child:Text("لا توجد نتائج"));
                            }else{
                      return ListView.builder(
                          itemCount: _filtered.length, 
                          itemBuilder: (context, index) {
                        
                            return doctorCard(
                              context,
                              _filtered[index],
                              snapShot.data,
                            );
                          });}
                      //         (context, index) {
                      //       if (_selectedText1 != "بالتخصص") {
                      //         //for(int i=0 ;i<=_doctors.length;i++){
                      //     //  if (_selectedText1 == _doctors[index].major) {
                      //     
                      //           return doctorCard(
                      //             context,
                      //              _doctors[index],
                      //             snapShot.data,
                      //           );
                      //         //  } else {
                      //         //    return null;
                      //         //  } //
                      //        // }
                      //       // });
                      //       } 
                      //       return doctorCard(
                      //         context,
                      //         _doctors[index],
                      //         snapShot.data,
                      //       );
                      //   // });
                      // // : (context, index) {

                      // //       return doctorCard(
                      // //         context,
                      // //         _doctors[index],
                      // //         snapShot.data,
                      // //       );

                      //  });
                    }
                    return Center(
                        child: SpinKitFadingCircle(
                      color: Color(0xFF87C9BF),
                      size: 35,
                    ));
                  })));
    });
  }
}

class DataSearch extends SearchDelegate<String> {
  final List<Doctor> listWords;

  final Patient _patient;
  DataSearch(this.listWords, this._patient)
      : super(
          searchFieldLabel: "بحث",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for app bar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    final suggestionList = listWords;

    return Container(
        color: Colors.teal,
        child: FutureBuilder(
            //  future: _patient,
            builder: (context, snapShot) {
          if (snapShot.hasData) {
            ListView.builder(
              itemBuilder: (context, index) => doctorCard(
                context,
                suggestionList[index],
                snapShot.data,
              ),
              itemCount: suggestionList.length,
            );
          }
          ;

          return Center(
              child: SpinKitFadingCircle(
            color: Color(0xFF87C9BF),
            //  color: Color(0xFF2B95AF),
            size: 35,
          ));
        }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? listWords
        : listWords
            .where((p) =>
                p.firstName.contains(RegExp(query, caseSensitive: false)) ||
                p.lastName.contains(RegExp(query, caseSensitive: false)))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => doctorCard(
        context,
        suggestionList[index],
        _patient,
      ),
      itemCount: suggestionList.length,
    );
  }

  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Color(0xFF2B95AF),

      cardColor: Colors.red,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),

      primaryColorBrightness: Brightness.light,
      textTheme: theme.textTheme.copyWith(
        title: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
      ),
      // these ↓ do not work ☹️
      appBarTheme:
          theme.appBarTheme.copyWith(color: Colors.white, elevation: 0),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          border: UnderlineInputBorder()),
    );
  }
}
