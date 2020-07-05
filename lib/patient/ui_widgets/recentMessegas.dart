import 'package:allo_doctor/patient/patientScreens/chatScreen.dart';
import 'package:flutter/material.dart';


  Widget recentMessage(BuildContext context ,String name,String latestMessage,String time,bool unread,bool isOnline){
  return    GestureDetector(
                onTap: (){
                    Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ChatScreen()));
                },
              child: Container(
                  padding:EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                     border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: Row( 
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Stack(
                            textDirection: TextDirection.rtl,
                            children: <Widget>[  
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/Doctor.png'),
                          ),
        
                        //  CircleAvatar(
                        //     radius: 21,
                        //     backgroundColor: Colors.white,
                        //     child: ClipOval(
                        //         child: SizedBox(
                        //             width: 40.0,
                        //             height: 40.0,
                        //             child: Image.asset('assets/Patient.png',
                        //                 fit: BoxFit.fill)))),
                                           isOnline  ? Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(top:52,right: 4),
              child: Container(
                height: 14,
                width: 14,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
            )
          : Container(),
           ],
                          ),
           
                        
                             SizedBox(width: 10.0),
                          Column(
                            textDirection: TextDirection.rtl,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text( name,
                              textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                alignment: Alignment.topRight,
                               // width: 200,
                                width: MediaQuery.of(context).size.width * 0.55,
                               // width: MediaQuery.of(context).size.width * 0.45,
                                child: Text(
                                 latestMessage,
                                 textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width:20),
                          Container(
                           
                            child:
                             Column(   
                               textDirection: TextDirection.rtl,
                               //crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,   
                        children: <Widget>[
                          Text(time, 
                           style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          unread ? 
                              Container(
                                  width: 40.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrangeAccent,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'جديد',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Text(''),
                        ],
                      ),
                          )

                          ]),
                          ])
                          ));
}