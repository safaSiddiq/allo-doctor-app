import 'package:allo_doctor/patient/ui_widgets/recentMessegas.dart';
import 'package:flutter/material.dart';



class MassagesScreen extends StatefulWidget {
  @override
  _MassagesScreenState createState() => _MassagesScreenState();
}

class _MassagesScreenState extends State<MassagesScreen> {
  bool unread = true;

  final mainColor=  LinearGradient(
          begin: FractionalOffset.bottomCenter,
          //  end: FractionalOffset.bottomCenter,
          stops: [0.0, 1.0,],
          colors: [
            Color(0xFF87C9BF),
            Color(0xFF2B95AF)
          ],
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

                  // CircleAvatar(
                  //           radius: 20,
                  //           backgroundColor: Colors.white,
                  //           child: ClipOval(
                  //             child: SizedBox(
                  //               width: 40.0,
                  //               height: 40.0,
                  //               child: Image.asset('assets/Patient.png',
                  //                   fit: BoxFit.fill),
                  //               // child: (_image!=null)?Image.file(
                  //               //   _image,
                  //               //   fit: BoxFit.fill,
                  //               // ):Image.network(
                  //               //   "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                  //               //   fit: BoxFit.fill,
                  //             ),
                  //           ),)
                ],
              ),
              Divider(
                color: Colors.teal,
                thickness: 1,
              ),
              // recentChats(context, 'احمد', "تمام", "2:33", false)
              recentMessage(
                  context, 'احمد عمر', "يرجى زيارة المستشفى", '1:34', true,true),
              recentMessage(
                  context, 'خالد علي', ' "يرجى زيارة المستشفى"', '9:00', true,true),
              recentMessage(context, "اخمد يوسف", "يرجى بتتن ىسيتاهيييييييييييييييييييييييييييييييييييييييييييعالا ى", "2:24", false,true)    
            ],
          )),
    ));
  }

//"يرجى زيارة المستشفى"

}
