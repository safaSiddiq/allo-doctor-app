import 'package:flutter/material.dart';

class PatientMidicalFile extends StatefulWidget {
  @override
  _PatientMidicalFileState createState() => _PatientMidicalFileState();
}

class _PatientMidicalFileState extends State<PatientMidicalFile> {
  bool isOnline = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: <Widget>[
           Container(
              padding: EdgeInsets.only(right: 5, top: 5, bottom: 5),
              child:  Stack(
                textDirection: TextDirection.rtl,
                children: <Widget>[ 
              CircleAvatar(
                  radius: 21,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                      child: SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child: Image.asset('assets/Doctor.png',
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
              ))
        ],
      ),
      body:Container(
        margin: EdgeInsets.symmetric(horizontal:20,vertical:5),
      child:
       ListView(
        children: <Widget>[
          Container(
            
            padding: EdgeInsets.only(right:5,bottom: 10),
            child: Text("المعلومات الشخصية",textDirection: TextDirection.rtl,style: TextStyle(color:Colors.white,fontSize:20),),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                 Container(
                     width: 85,
                   height: 85,
              
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
                isOnline  ? Container(
                  margin: EdgeInsets.only(bottom:10,right:8),
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
                SizedBox(width:10),
                Column(
                  
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height:10),
                     Text("محمد علي سالم",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                    SizedBox(height:8),                    
                     textRow("العمر", '50'),
                     textRow("الجنس", 'ذكر'),
                     textRow("الجنسية", 'محل الإقامة'),
                     textRow("محل الإقامة", "مصراتة - ليبيا"),
                     textRow("فصيلة الدم", "A+"),
                      SizedBox(height:10)
                  ],
                )
              ],
            ),
          ),
           Container( 
            padding: EdgeInsets.only(right:5,bottom: 10,top:20),
            child: Text("الأمراض المزمنة",textDirection: TextDirection.rtl,style: TextStyle(color:Colors.white,fontSize:20),),
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white
            ),
          ),
           Container( 
            padding: EdgeInsets.only(right:5,bottom: 10,top:20),
            child: Text("الحساسيات",textDirection: TextDirection.rtl,style: TextStyle(color:Colors.white,fontSize:20),),
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white
            ),
          ),
           Container( 
            padding: EdgeInsets.only(right:5,bottom: 10,top:20),
            child: Text("الأدوية الحالية",textDirection: TextDirection.rtl,style: TextStyle(color:Colors.white,fontSize:20),),
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white
            ),
          ),
           Container( 
            padding: EdgeInsets.only(right:5,bottom: 10,top:20),
            child: Text("الجراحات السابقة",textDirection: TextDirection.rtl,style: TextStyle(color:Colors.white,fontSize:20),),
          ),
          Container(
           
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white
            ),
            child: Column(
              children: <Widget>[
                exData()
              ],
            ),
          ),
           Container( 
            padding: EdgeInsets.only(right:5,bottom: 10,top:20),
            child: Text("التحاليل السابقة",textDirection: TextDirection.rtl,style: TextStyle(color:Colors.white,fontSize:20),),
          ),
          Container(
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white
            ),
            child: Column(
              children: <Widget>[
                exData()
              ],
            ),
          ),
           Container( 
            padding: EdgeInsets.only(right:5,bottom: 10,top:20),
            child: Text("الأشعة السابقة",textDirection: TextDirection.rtl,style: TextStyle(color:Colors.white,fontSize:20),),
          ),
          Container(
          
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white
            ),
            child: Column(
              children: <Widget>[
                exData(),
                exData()
              ],
            ),
          ),
          SizedBox(height: 20,)

        ],
      ),)

    );
  }
}



Widget textRow(String title , String info){
  return  Row(
                textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Text( ": "+ title ,style: TextStyle(color:Colors.teal,fontWeight:FontWeight.bold),),
                        SizedBox(width:5),
                        Text(info)
                      ],
                    );

}

Widget exData(){
  return Container(
    decoration: BoxDecoration(
      border: Border(bottom:BorderSide(color: Colors.teal))
    ),
    padding: EdgeInsets.symmetric(horizontal:10),
    child: 
    Directionality(textDirection: TextDirection.rtl, child: 
        ListTile(       
          title: Text("data"),
          subtitle: Text("data"),
          trailing: Container(
            width: 110,
            height: 46,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey [300]             
            ),
           child:Container(
             padding: EdgeInsets.symmetric(horizontal:5),
             child:
            Row(
             textDirection: TextDirection.rtl,
             children: <Widget>[
               SizedBox(width:5),
             Text("22/2/2020"),
              SizedBox(width:5),
              Icon(Icons.calendar_today),
            ],))
          ),
        ))
  );
}