import 'package:allo_doctor/Doctor/ui_widgets/patientCard.dart';
import 'package:flutter/material.dart';

class PatientsScreen extends StatefulWidget {
  @override
  _PatientsScreenState createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  final mainColor = LinearGradient(
    begin: FractionalOffset.bottomCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: mainColor
      ),
      child:
    Scaffold(
      backgroundColor: Color(0xFF00000),
      appBar:  PreferredSize(
            preferredSize: Size(double.infinity, 105), 
            child: AppBar(
              elevation: 0,
              backgroundColor: Color(0xFF0000),
              actions: <Widget>[
                RawMaterialButton(
                    onPressed: () {
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
                             top: 10, bottom: 2, right: 30,),
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
                preferredSize: Size(double.infinity, 75),
                child: Row( 
                mainAxisAlignment: MainAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  SizedBox(width:30),
                  RaisedButton(
                      onPressed: () {},
                      color: Colors.white,
                      textColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(textDirection: TextDirection.rtl, children: [
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
                body: ListView( 
                  children: <Widget>[
                   
                    patientCard(context, true),
                    patientCard(context, true),
                    patientCard(context, false)
                  ],
                ),)
    );
  }
}