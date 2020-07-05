import 'package:allo_doctor/Doctor/ui_widgets/messageCard.dart';
import 'package:flutter/material.dart';

class DrMessageScreen extends StatefulWidget {
  @override
  _DrMessageScreenState createState() => _DrMessageScreenState();
}

class _DrMessageScreenState extends State<DrMessageScreen> {

  final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
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
       backgroundColor: Color(0xFF0000),
      body: Container(
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  RawMaterialButton(
                      onPressed: () {
                        //  showSearch(
                        //    context: context,
                        //   delegate: CustomSearchDelegate());
                      },
                      child: Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.only(
                            top: 4,
                            bottom: 2,
                          ),
                          width: 280,
                          child: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              onPressed: () {}))),
                ]),
                 Divider(
                color: Colors.teal,
                thickness: 1,
              ),
              messageCard(context, true, "name", "latestMessage", true, "2:14"),
               messageCard(context, false, "name", "latestMessage", false, "2:14")
               ],
          )),
    ));
  }
}