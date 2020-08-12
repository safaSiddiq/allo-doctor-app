import 'package:allo_doctor/Doctor/ui_widgets/patientCard.dart';
import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/models/patient.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PatientsScreen extends StatefulWidget {
  final MainModel model;
  PatientsScreen(this.model);
  @override
  _PatientsScreenState createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  List<String> ids = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final mainColor = LinearGradient(
    begin: FractionalOffset.bottomCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );
  List<Patient> _patients;
  Future<Doctor> _doctor;
  List<Patient> _list = [];

  void check() {
    for (int i = 0; i <= _patients.length - 1; i++) {
      if (widget.model.patientIds.contains(_patients[i].patientId)) {
        //   patientCard(context, _patients[i])
        ids.add(_patients[i].patientId);
        //  d.add(_patients[i])
        _list.add(_patients[i]);
      }
    }
  }

  @override
  void initState() {
    widget.model.getPatientsData().then((_) {
      setState(() {
        _patients = widget.model.patients;

        check();
      });
    });

    widget.model.getDoctor().then((_) {
      setState(() {
        _doctor = widget.model.getDoctor();
        _list;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // MaterialApp(
        //   localizationsDelegates: [
        //  //   CustomLocalizationDelegate(),
        //   ],
        //   home:

        Container(
            decoration: BoxDecoration(gradient: mainColor),
            child: Scaffold(
                backgroundColor: Color(0xFF00000),
                appBar: PreferredSize(
                    preferredSize: Size(double.infinity, 105),
                    child: AppBar(
                        elevation: 0,
                        backgroundColor: Color(0xFF0000),
                        actions: <Widget>[
                          RawMaterialButton(
                              onPressed: () {
                                showSearch(
                                    context: context,
                                    delegate: DataSearch(_list));
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.78,
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {}))),
                        ],
                        bottom: PreferredSize(
                            preferredSize: Size(double.infinity, 75),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                textDirection: TextDirection.rtl,
                                children: [
                                  SizedBox(width: 30),
                                  RaisedButton(
                                      onPressed: () {},
                                      color: Colors.white,
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
                                              size: 12,
                                              color: Colors.teal,
                                            ),
                                            Icon(
                                              Icons.arrow_downward,
                                              size: 12,
                                              color: Colors.teal,
                                            ),
                                          ])),
                                ])))),
                body: RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: _refresh,
                    child: FutureBuilder(
                        future: _doctor,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: ids.length,
                                itemBuilder: (context, index) =>
                                    patientCard(context, _list[index])
                                //  widget.model.patientIds.contains(_patients[index].patientId) ?
                                //       patientCard(context, _patients[index])
                                //       :null
                                //  if (widget.model.patientIds.contains(_patients[index].patientId)) {
                                //          return  patientCard(context, _patients[index]);
                                //         }

                                );
                          } else {
                            return Center(
                                child: SpinKitFadingCircle(
                              color: Color(0xFF87C9BF),
                              size: 40,
                            ));
                          }
                        }))));
    //  );
  }

  Future _refresh() {
    widget.model.getPatientsData().then((_) {
      setState(() {
        _patients = widget.model.patients;
      });
    });

    widget.model.getDoctor();
    // .then((_) {
    //   setState(() {
    //     _doctor = widget.model.getDoctor();
    //   //  _list;
    //   });
    // });

    return _doctor;
  }
}

class DataSearch extends SearchDelegate<String> {
  final List<Patient> listWords;

  DataSearch(this.listWords)
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
        child: Column(
          children: <Widget>[
            ListView.builder(
              itemBuilder: (context, index) =>
                  patientCard(context, suggestionList[index]),
              itemCount: suggestionList.length,
            )
          ],
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for somethin
    final suggestionList = query.isEmpty
        ? listWords
        : listWords
            .where((p) =>
                p.firstName.contains(RegExp(query, caseSensitive: false))|| p.lastName.contains(RegExp(query, caseSensitive: false))  )
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) =>
          patientCard(context, suggestionList[index]),
      itemCount: suggestionList.length,
    );
  }

  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme:
          theme.primaryIconTheme.copyWith(color: Colors.deepOrangeAccent),
      primaryColorBrightness: Brightness.dark,
      textTheme: theme.textTheme.copyWith(
        title: TextStyle(fontWeight: FontWeight.normal),
      ),
      // these ↓ do not work ☹️
      appBarTheme:
          theme.appBarTheme.copyWith(color: Colors.black12, elevation: 0),
      inputDecorationTheme:
          theme.inputDecorationTheme.copyWith(border: UnderlineInputBorder()),
    );
  }
}
