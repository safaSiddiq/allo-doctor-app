import 'package:flutter/material.dart';

class CallCenterScreen extends StatefulWidget {
  @override
  _CallCenterScreenState createState() => _CallCenterScreenState();
}

class _CallCenterScreenState extends State<CallCenterScreen> {
  bool isOnline = true;

  final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
    // end: FractionalOffset.bottomCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
          decoration: BoxDecoration(gradient: mainColor),
          child: Scaffold(
            backgroundColor: Color(0xFF00000),
            appBar: PreferredSize(
              preferredSize:
                  Size.fromHeight(350), // Size(double.infinity, 200),
              child: AppBar(
                centerTitle: false,
                elevation: 0,
                backgroundColor: Color(0xFF0000),
                actions: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 5, top: 5, bottom: 5),
                    child: CircleAvatar(
                        radius: 21,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                            child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: Image.asset('assets/Patient.png',
                                    fit: BoxFit.fill)))),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize:
                      Size.fromHeight(200), // Size(double.infinity, 250),
                  child: Column(textDirection: TextDirection.rtl, children: [
                    Container(
                        child: CircleAvatar(
                            radius: 90,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                                child: SizedBox(
                                    width: 176.0,
                                    height: 176.0,
                                    child: Image.asset('assets/Call_Center.png',
                                        fit: BoxFit.fill))))),
                    SizedBox(height: 15),
                    Center(
                        child: Text(
                      'مركز الهلال',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    )),
                    SizedBox(height: 15),
                    Center(
                        child: Text(
                      '092 0299 94848 38',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    )),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: TabBar(isScrollable: false, tabs: [
                          Tab(
                            icon: Icon(Icons.message),
                          ),
                          Tab(
                            icon: Icon(Icons.call),
                          ),
                        ])),
                  ]),
                ),
              ),
            ),
            body: TabBarView(children: [Container(), Container()]),
          //   body: ListView(
            //     children: <Widget>[
            //       Column(
            //         children:[
            //        Stack(
            //             textDirection: TextDirection.rtl,
            //             children: <Widget>[
            //            Center(
            //           child:  CircleAvatar(
            //                   radius: 120,
            //                   backgroundColor: Colors.white,
            //                   child: ClipOval(
            //                     child: SizedBox(
            //                       width: 235.0,
            //                       height: 235.0,
            //                       child: Image.asset('assets/Call_Center.png',
            //                           fit: BoxFit.fill))))),
            //                              isOnline
            //                             ? Center(

            //                               child:Container(
            //                                 alignment: Alignment.bottomRight,
            //                                 margin: EdgeInsets.only(right: 95,top: 200),
            //                                 child: Container(
            //                                   height: 25,
            //                                   width: 25,
            //                                   decoration: BoxDecoration(
            //                                     border: Border.all(
            //                                       color: Colors.white,
            //                                       width: 1,
            //                                     ),
            //                                     shape: BoxShape.circle,
            //                                     color: Colors.green,
            //                                   ),
            //                                 ),
            //                               ))
            //                             : Container(),
            //         ]),

            //          SizedBox(height:15),
            //         Center(child:Text('مركز الهلال',style: TextStyle(fontSize:17,color:Colors.white),)),
            //         SizedBox(height:15),
            //         Center(child:Text('092 0299 94848 38',style: TextStyle(fontSize:17,color:Colors.white),))
            //         ]),

            //         SizedBox(height:30),
            //         Container(
            //           margin: EdgeInsets.symmetric(horizontal:20),
            //           child:Text('الاستعلامات المرسلة',textDirection: TextDirection.rtl,style: TextStyle(color:Colors.white,fontSize:18),)
            //         ),
            //         Container(
            //           margin: EdgeInsets.symmetric(horizontal:5),
            //           padding: EdgeInsets.symmetric(vertical:5),
            //           //height: 150,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             color: Colors.white
            //           ),
            //           child:
            //           Column(
            //             children: <Widget>[
            //               // queryReplyCard(context,"تم القبول",true),
            //               // queryReplyCard(context,"تم الرفض",true),
            //               // queryReplyCard(context,"في انتظار الرد",true)
            //             ],
            //           )
            //         ),
            //         SizedBox(height:15),
            //         Container(
            //           margin: EdgeInsets.symmetric(horizontal:20),
            //           child:Text('ردود الاستعلامات المستقبلة',textDirection: TextDirection.rtl,style: TextStyle(color:Colors.white,fontSize:18),)
            //         ),
            //          Container(
            //            margin: EdgeInsets.symmetric(horizontal:5),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             color: Colors.white
            //           ),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             children: <Widget>[
            //               // diagnosisPreview(context,Colors.white),

            //               // diagnosisPreview(context,Colors.white)
            //             ],
            //           )
            //         ),
            //     ],
            //  )
          )),
    );
  }
}
