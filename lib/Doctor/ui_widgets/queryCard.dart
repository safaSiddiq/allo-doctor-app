import 'package:allo_doctor/Doctor/DoctorScreens/patientMidicalFile.dart';
import 'package:allo_doctor/Doctor/DoctorScreens/queryView.dart';
import 'package:flutter/material.dart';


class QueryCard extends StatefulWidget {
  @override
  _QueryCardState createState() => _QueryCardState();
}

class _QueryCardState extends State<QueryCard> {
  bool isOnline = true;
  int value = 0;
  bool _isDisabled = false;
  
//     void initState(){
//     _isDisabled = false;
// } 
//   void disabledButton(){
//     _isDisabled = true;
//   }




  Widget acceptQuery() {
    return Container(
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.teal,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  value = 1;
                  _isDisabled = true;
                Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QueryView())); 
                });
              }),
          IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.red,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  value = 2;
                  _isDisabled =false;
                });
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child:
         Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.teal))),
          child: Card(
            color: Colors.white,
            //key: ValueKey(record.name),
            elevation: 0,
            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
            child: Container(
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child:                  
                ListTile(
                  contentPadding: EdgeInsets.only(top: 1, bottom: 1, right: 5),
                  leading:PreferredSize(
                preferredSize: Size(double.infinity, 120),
                child:               
                  Container(
                      width: 65,
                      height: 65,
                      padding: EdgeInsets.only(
                        right: 10.0,
                      ),
                      child: Stack(
                        children: <Widget>[                 
                          CircleAvatar(
                              radius: 41,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                  child: SizedBox(
                                      width: 70.0,
                                      height: 70.0,
                                      child: Image.asset('assets/Patient.png',
                                          fit: BoxFit.fill)))),
                          isOnline
                              ? Container(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                  ),
                                )
                              : Container(),
                                  value == 0 && (value != 1 && value != 2)? 
                                  Positioned(
                                    right: 0.5,
                                    child:
                                Container(
                                 // margin: EdgeInsets.only(left: 50)
                                 
                                      height: 10,
                                      width: 10, 
                                       decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,    
                                      )),
                                    ):Container(),
                        ],
                      ),
                       
                )),
                  title: Text(
                    'محمد خالد',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(children: [
                    Flexible(
                        child: Column(
                      children: <Widget>[
                        Text('22/2/2020'),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.teal,
                            ),
                            child: Text(
                              'زيارة طبية',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ))
                      ],
                    ))
                  ]),
                  trailing: Column(
                    children: <Widget>[
                      Container(
                          height: 25,
                          width: 92,
                          child: RaisedButton(
                              color: _isDisabled? Colors.green:Colors.grey,
                              child: Text(
                                'ملف طبي',
                                style:
                                    TextStyle(fontSize: 10, color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              onPressed:_isDisabled?
                               () {
                                  Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PatientMidicalFile())); 
                              }:null)),
                      SizedBox(height: 1),
                      value == 0 && (value != 1 && value != 2)
                          ? Container(
                              height: 30,
                              width: 110,
                              child: acceptQuery(),
                            )
                          : Container(
                              height: 30,
                              width: 110,
                              child: value == 1 && value != 0
                                  ? acceptButton()
                                  : declineButton())
                      // Container(
                      //   height: 30,
                      //   width: 110,
                      //  child: acceptQuery(),
                      // )
                    ],
                  ),
                )
                
                ))
                ,
          ),
            
        );
  }


Widget acceptButton() {
  return RawMaterialButton(onPressed: (){
     Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QueryView())); 
  },
    child:Container(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    height: 25,
    width: 95,
    decoration: BoxDecoration(
        color: Colors.green, borderRadius: BorderRadius.circular(8)),
    child: 
     Text(
      'تم القبول',
      style: TextStyle(fontSize: 10, color: Colors.white),
      textAlign: TextAlign.center,
    ),)
  );
}

Widget declineButton() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    decoration: BoxDecoration(
        color: Colors.red, borderRadius: BorderRadius.circular(8)),
    child: Center(
        child: Text(
      'تم الرفض',
      style: TextStyle(fontSize: 10, color: Colors.white),
    )),
  );
}
}