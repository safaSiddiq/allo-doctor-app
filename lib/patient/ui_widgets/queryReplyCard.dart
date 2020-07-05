import 'package:allo_doctor/patient/patientScreens/diagnosisView.dart';
import 'package:flutter/material.dart';

Widget queryReplyCard(BuildContext context,String state,bool isOnline) {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
     
          elevation: 0.0,
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
          margin: EdgeInsets.only(top: 5, right: 10, left: 10,bottom: 5),
          child: Container(
              decoration:
                  BoxDecoration(color: Colors.white, 
                  border: Border(bottom:BorderSide(color: Colors.teal))
                  //shape: BoxShape.circle
                  ),
              child: ListTile(
                contentPadding: EdgeInsets.only(top: 1, bottom: 1, right: 5),
                leading:
                 Container(
                   height: 70,
                    width: 70,
                    padding: EdgeInsets.only(
                      right: 10.0,
                    ),
                    child:Stack(
                  children: <Widget>[
                      CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                                child: SizedBox(
                                    width: 65.0,
                                    height: 65.0,
                                    child: Image.asset('assets/Doctor.png',
                                        fit: BoxFit.fill)))),
                    //  CircleAvatar(
                    //   radius: 40,
                    //   backgroundImage: AssetImage('assets/Doctor.png'),
                    // ),
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
                ))
                ,
                title:
                Text('تميم ابوغرسة'),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
   Flexible(
                        child: Column(
                      children: <Widget>[
                        Text('22/2/2020'),
                        SizedBox(height: 5),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.teal,
                          ),
                          child: Text(
                            'زيارة طبية',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        )
                      ],
                    )),
                  ],
                ),
                trailing: 
                       Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 25,
                            child:

                          RaisedButton(
                              // padding: EdgeInsets.symmetric(
                              //     horizontal: 15, vertical: 10),
                              color: (state == "تم القبول")? Colors.green:Colors.grey,
                              child: Text(
                                "تشخيص",
                                style: TextStyle(
                                    fontSize: 11, color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              onPressed: (state == "تم القبول")?
                              () {
                                  Navigator.of(context).push(MaterialPageRoute(
                        builder:
                         (BuildContext context) => DiagnosisViewScreen()));
                              }:null)),
                        
                              stateButton(state)
                        ],
                      ),
                    ),
              )));
}

Widget stateButton(String state) {
 if (state == "تم القبول") {
    return Container(
      height: 25,
      width: 85,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration:   BoxDecoration(
        borderRadius: BorderRadius.circular(5),
          color: Colors.green)
      ,
      child: Text(
        state,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 11, color: Colors.white),
      ));
 } else if (state == "تم الرفض"){
       return Container(
      height: 25,
      width: 85,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration:   BoxDecoration(
        borderRadius: BorderRadius.circular(5),
          color: Colors.red)
      ,
      child: Text(
        state,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 11, color: Colors.white),
      ));
 } else {
    return Container(
      height: 25,
      width: 85,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration:   BoxDecoration(
        borderRadius: BorderRadius.circular(5),
          color: Colors.grey)
      ,
      child: Text(
        state,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 11, color: Colors.white),
      ));
 }
  
  
}
