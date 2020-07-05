import 'package:allo_doctor/patient/input_form/image_input.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isOnline=true;


  final mainColor=  LinearGradient(
          begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
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
       // gradient: mainColor,
        color: Colors.teal[100],
      ),
    child:
    Scaffold(
      
      backgroundColor: Color(0xFF00000),
      appBar: AppBar(
        centerTitle: false ,
        title: Container(
          alignment: Alignment.topRight,
          child:
              Text('احمد علي')),
        
          elevation: 0,
          backgroundColor:   Color(0xFF2B95AF),
          actions: <Widget>[
                 Container(
              alignment: Alignment.center,
                padding: EdgeInsets.only( top: 5, bottom: 5),
                child: Stack(
                textDirection: TextDirection.rtl,
                children: <Widget>[ 
              CircleAvatar(
                  radius: 21,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                      child: SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child: Image.asset('assets/Patient.png',
                              fit: BoxFit.fill)))),
                                  isOnline
                                ? Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(right: 3,bottom: 5),
                                    child: Container(
                                      height: 10,
                                      width: 10,
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
              ),),
             IconButton(icon: Icon(Icons.settings,size: 30,), onPressed: (){}),
          ],
      ),
      body: Column(
        children: <Widget>[
          // _buildMessage("messagaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaae", "5:15", true),
          // _buildMessage("message messagemessagemessagemessagemessagemessagemessagemessage", "6:15", false),
          Expanded(
            child:Container(
              child: ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.only(top: 10.0),
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      //  bool isMe =true;
                      return  _buildMessage('messagsssssssssssse', '3:14', true);
                    },
                  ),
            ) ),
            _buildMessageComposer()
        ],
      ),
    )
    );
 
  }

   Widget _buildMessage(String message,String time, bool isMe) {
    final Widget msg = 
    isMe?
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: <Widget>[
        Container(
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                                child: SizedBox(
                                    width: 30.0,
                                    height: 30.0,
                                    child: Image.asset('assets/Patient.png',
                                        fit: BoxFit.fill)))) ,
        ),
        
        SizedBox(width:3),
    Container(
      margin: EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            ) ,
         
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.50,
      decoration: BoxDecoration(
        color: Colors.white ,
        borderRadius:
            BorderRadius.only(
              bottomRight: Radius.circular(15),
              topRight: Radius.circular(15),
               topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
          
      ),
      child: Container(
         child: Text(
            message,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        
      ),
    ),
    Text(time,style: TextStyle(color:Colors.black54,fontSize:14),)
     ],
    ) :Row(
      mainAxisAlignment: MainAxisAlignment.start,
      textDirection: TextDirection.ltr,
      children: <Widget>[
        Container(
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                                child: SizedBox(
                                    width: 30.0,
                                    height: 30.0,
                                    child: Image.asset('assets/Doctor.png',
                                        fit: BoxFit.fill)))) ,
        ),
        
        SizedBox(width:3),
    Container(
         margin: EdgeInsets.only(
             top: 8.0,
              bottom: 8.0,
             
            ),  
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
    width: MediaQuery.of(context).size.width * 0.60,
      decoration: BoxDecoration(
        color:  Colors.grey[200],
        borderRadius: 
             BorderRadius.only(
               bottomLeft: Radius.circular(15),
               topLeft: Radius.circular(15),
                   topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0)),
          
      ),
      child: Container(
         child: Text(
            message,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        
      ),
    ),
    SizedBox(width:35),
    Text(time,style: TextStyle(color:Colors.black54,fontSize:14),)
     ],
    )
    ;
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
       
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 55.0,
      color:   Color(0xFF2B95AF),
      child: Row(
      
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Expanded(
            child: Directionality(  
              textDirection: TextDirection.rtl, 
            child:  TextField(
              
              onChanged: (value) {},
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "ارسل رسالة",
              ),
            ),)
          ),
           IconButton(
         
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Colors.white,
            onPressed: () {},
          ),
          ImageInput(),
          IconButton(
            icon: Icon(Icons.mic),
            iconSize: 25.0,
            color:Colors.white,
            onPressed: () {},
          ),
          
        ],
      ),
    );
  }


}