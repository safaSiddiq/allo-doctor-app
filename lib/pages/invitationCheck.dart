import 'package:allo_doctor/pages/ui_widgets/onLoading.dart';
import 'package:allo_doctor/pages/ui_widgets/wrongWidget.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';

class InvitationCkech extends StatefulWidget {
  final MainModel model;
  InvitationCkech(this.model);
  @override
  _InvitationCkech createState() => _InvitationCkech();
}

class _InvitationCkech extends State<InvitationCkech> {
  TextEditingController _codeController = TextEditingController();



final mainColor=  LinearGradient(
          begin: FractionalOffset.topCenter,
            end: FractionalOffset.center,
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff00000),
      ),
      backgroundColor: Color(0xff0000),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: ListView(
          
             padding: EdgeInsets.symmetric(horizontal:30,vertical: 10),
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
              
              SizedBox(height: 50.0),

              Text('إنشاء حساب طبيب' '\n' ' يتطلب رمز دعوة',
                  //textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, color: Colors.black)),
              SizedBox(height: 60.0),
              Text(
                'رمز الدعوة',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              SizedBox(height: 30.0),
              invitationCode(),
              SizedBox(height: 60.0),
           

               GestureDetector(
                      onTap: ()async {
                        await invitationCheck();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 40.0),
                        height: 50.0,
                        decoration: BoxDecoration(
                            color:  Color(0xFF2B95AF),
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Text(
                          'التحقق من الرمز',
                          style: TextStyle(fontSize: 19, color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                      )),
              SizedBox(height: 70),
              Align(
                alignment: Alignment.bottomCenter,
                child:
              FlatButton(
                  child: Text('طلب رمز دعوة ',
                      style: TextStyle(
                        decorationStyle: TextDecorationStyle.solid,
                        decorationColor: Colors.black,
                        decorationThickness: 10,
                        color: Colors.grey[700],
                        fontSize: 15.0,
                        decoration: TextDecoration.underline,
                      )),
                  onPressed: () {
                    Navigator.pushNamed(context, "/InvitationAsk");
                  }))
            ]),
              
                ],
              )
      ),
     ) );
  }

  Widget invitationCode() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              controller: _codeController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0))),
              onChanged: (String valure) {},
            )));
  }


  doneSend(BuildContext context) {
    return showDialog(
        context: context,
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 185, horizontal: 25),
            child: AlertDialog(
                backgroundColor: Colors.grey[300],
                elevation: 5,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.check_circle,
                      color: Colors.deepOrangeAccent,
                      size: 48,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "تم التحقق بنجاح",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ))));
  }

  void invitationCheck()async {
   
    
  await widget.model.getInvitationCode();
  widget.model.isLoading==true?onLoading(context):null;
   
   if(widget.model.initationCodes.contains("43f21353-9163-4053-8680-c3f29eb8755c")){
  
     doneSend(context);
      await Future.delayed(Duration(seconds: 1)).then((_) {
        Navigator.pushNamed(context, "/RegistrationASdoctor");
        });
   }else{
     wrongWidget(context);
      await Future.delayed(Duration(seconds: 1)).then((_) {
       Navigator.pop(context);
        });
   } 
  }
}
