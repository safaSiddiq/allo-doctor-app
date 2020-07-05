import 'package:allo_doctor/pages/invitationAsk.dart';
import 'package:flutter/material.dart';

class InvitationCkech extends StatefulWidget {
  @override
  _InvitationCkech createState() => _InvitationCkech();
}

class _InvitationCkech extends State<InvitationCkech> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.teal,
      body: 
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius:BorderRadius.only(topLeft:Radius.circular(15),topRight: Radius.circular(15))
               
                ),
            child: Column(
         // padding: EdgeInsets.symmetric(horizontal:25),
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height:50.0),
                 
                  Text('إنشاء حساب طبيب' '\n' ' يتطلب رمز دعوة',
                      //textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.black)),
                  SizedBox(height: 10.0),
                  Text(
                    'رمز الدعوة',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  //SizedBox(height: 10.0),
                  invitationCode(),
                  SizedBox(height: 10.0),
                  Container(
                      height: 43.0,
                      child: RaisedButton(
                          color: Colors.teal,
                          textColor: Colors.white,
                          child: Text(
                            'التحقق من الرمز',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 50.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          onPressed: () {
                             InvitationCkech();
                          })),
                        SizedBox(height:10),
                          FlatButton(
                      child: Text('طلب رمز دعوة ',
                     
                          style: TextStyle(
                            decorationStyle: TextDecorationStyle.solid,
                            decorationColor: Colors.black,
                            decorationThickness: 10,
                            color: Colors.grey[700] , fontSize: 15.0,
                             decoration: TextDecoration.underline,)),
                      onPressed: () {
                         Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => InvitationAsk()));
                      })
                ]),
        
      
      ),
    );
  }
}

Widget invitationCode() {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0))),
        onChanged: (String valure) {},
      ));
}

void invitationCheck (){

}
