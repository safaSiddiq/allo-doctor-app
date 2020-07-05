import 'package:allo_doctor/patient/ui_widgets/queryReplyCard.dart';
import 'package:flutter/material.dart';

class QueriesReplaies extends StatefulWidget {  
  @override

  _QueriesReplaiesState createState() => _QueriesReplaiesState();
}

class _QueriesReplaiesState extends State<QueriesReplaies> {
   String _selectedText =  'اختر نوع الاستعلام';

   final mainColor=  LinearGradient(
          begin: FractionalOffset.topCenter,
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
       appBar: PreferredSize(
            preferredSize: Size(double.infinity, 100), // 44 is the height
            child: AppBar(
              
              elevation: 0,
              shape: UnderlineInputBorder(
                  borderSide:
                      BorderSide(style: BorderStyle.solid, color: Colors.teal)),
              backgroundColor: Color(0XFF0000),
              actions: <Widget>[
              
              Container(
                 width: MediaQuery.of(context).size.width * 0.83,
                margin: EdgeInsets.only(left:0,right:15,top:10,bottom:5),
                padding: EdgeInsets.symmetric(horizontal:20,vertical: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: DropdownButton<String>(
                      iconDisabledColor: Colors.teal,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Tajawal-Medium',
                      ),
                      // hint: Text('اختر التخصص'),
                      value: _selectedText,
                      items: <String>[
                        'اختر نوع الاستعلام',
                        "طبيب باطينية",
                        "طبيب نساء",
                        "طبيب أذن و حنجرة",
                        "طبيب قلب",
                        "طبيب أسنان",
                        'طبيب عيون'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String val) {
                        _selectedText = val;
                        setState(() {
                          _selectedText = val;
                        });
                      },
                    )),       
             
              ],
              bottom:PreferredSize(
                child:bottonsRow() ,
               preferredSize: Size(double.infinity, 90)),
            ),
            ),
            body: ListView(
              children: <Widget>[
              //  Container(
              //    margin: EdgeInsets.only(left:33),
              //  child: bottonsRow()),
                SizedBox(height:30),
                Container(      
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      queryReplyCard(context,"تم القبول",true),
                      queryReplyCard(context,"تم الرفض",true),
                      queryReplyCard(context,"تم الرفض",true),
                      // queryReplyCard("تم القبول",true),
                      // queryReplyCard("في انتظار الرد",true),
                      // queryReplyCard('تم القبول',true),

                    ],
                  ),
                )
            ],),
    ));
  }
}

Widget bottonsRow(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    textDirection: TextDirection.rtl,
    children: <Widget>[
    SizedBox(width:25),
    RaisedButton(
        color: Colors.white,
        textColor: Colors.black,
        child: Text(
          'تم القبول',
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
       // padding: EdgeInsets.symmetric(horizontal: 5.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        onPressed: (){}),
        SizedBox(width:5),
     RaisedButton(
        color: Colors.white,
        textColor: Colors.black,
        child: Text(
          'تم الرفض',
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      //  padding: EdgeInsets.symmetric(horizontal: 50.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        onPressed: (){}),
        SizedBox(width:5),

        RaisedButton(
        color: Colors.white,
        textColor: Colors.black,
        child: Text(
          'في انتظار الرد',
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
       // padding: EdgeInsets.symmetric(horizontal: 50.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        onPressed: (){}) 
  ],);
}