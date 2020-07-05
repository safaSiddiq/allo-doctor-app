import 'package:allo_doctor/patient/patientScreens/doctorFile.dart';
import 'package:allo_doctor/patient/patientScreens/fillQueryDr.dart';
import 'package:flutter/material.dart';

Widget doctorCard(BuildContext context,bool isOnline) {
  return 
   Directionality(
    textDirection: TextDirection.rtl,
    child: Card(
      color: Colors.white,
        //key: ValueKey(record.name),
        elevation: 0.0,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
        child: Container(
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: ListTile(
            contentPadding: EdgeInsets.only(top: 5, bottom: 10, right: 5),
            leading:
                 Container(
                     width: 70,
                   height: 70,
              
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
                                    child: Image.asset('assets/Doctor.png',
                                        fit: BoxFit.fill)))),
                isOnline  ? Container(
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
                  ],
                )),    
            title: Text(
              'محمد خالد',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                SizedBox(width:5),
                Flexible(child:
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          text: 'طبيب جراحة',
                          style: TextStyle(
                              color: Colors.blue, fontFamily: 'Tajawal-Medium'),
                        ),
                        maxLines: 3,
                        softWrap: true,
                      ),
                      SizedBox(height: 5),
                      Row(children: [
                        Container(
                            height: 25,
                            width: 85,
                            child: RaisedButton(
                                color: Colors.deepOrangeAccent,
                                child: Text(
                                  'ملف طبيب',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                onPressed: () {
                                   Navigator.of( context).push(
              MaterialPageRoute(builder: (context) => DoctorFileScreen()));
                                })),
                        SizedBox(width: 20),
                        Container(
                            height: 25,
                            width: 85,
                            child: RaisedButton(
                                color: Colors.deepOrangeAccent,
                                child: Text(
                                  'استعلام',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                onPressed: () {
                                   Navigator.of( context).push(
              MaterialPageRoute(builder: (context) => FillQueryDrScreen()));
                                })),
                      ])
                    ]))
              ],
            ),
          ),
        )),
  );
}