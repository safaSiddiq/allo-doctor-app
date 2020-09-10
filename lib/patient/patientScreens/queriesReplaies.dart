
import 'package:allo_doctor/models/query.dart';
import 'package:allo_doctor/patient/ui_widgets/queryReplyCard.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';

class QueriesReplaies extends StatefulWidget {
  final MainModel model;
  QueriesReplaies(this.model);
  @override
  _QueriesReplaiesState createState() => _QueriesReplaiesState();
}

class _QueriesReplaiesState extends State<QueriesReplaies> {



 final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
     GlobalKey<RefreshIndicatorState>();







  String _selectedText = 'اختر نوع الاستعلام';
List<Query> _queriesResults = [];
List<Query> _filteredQuery = [];
int _type = null;
int _pressed =0;
 List<Query> _approved = [];
  List<Query> _unapproved = [];
   List<Query> _waiting = [];

  final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );

  @override
  void initState() {
   widget.model.getQueryResultData().then((_){
     setState(() {
       _queriesResults = widget.model.queriesResults;
        _filterQuery();
        _approv();
        _unapprov();
        _wait();
     });
   });
   
   
  
    super.initState();
  }

  void _approv(){
     for(int i =0 ;i<_filteredQuery.length;i++){
           if(_filteredQuery[i].approved == true){
             _approved.add(_filteredQuery[i]);
           }}
  }

  void _unapprov(){
          
         for(int i =0 ;i<_filteredQuery.length;i++){
           if(_filteredQuery[i].approved == false){
             _unapproved.add(_filteredQuery[i]);
           }}
  }
  void _wait(){
    for(int i =0 ;i<_filteredQuery.length;i++){
           if(_filteredQuery[i].approved == null){
             _waiting.add(_filteredQuery[i]);
           }}
  }



void _filterQuery(){
   // if (_selectedText != "اختر نوع الاستعلام") {
        if ( _type != null  ) {
      List<Query> tmpList = [];
      for (int i = 0; i < _queriesResults.length; i++) {
        if ( 0 ==_queriesResults[i].queryType) {
         
          tmpList.add(_queriesResults[i]);
        }
      }
      setState(() {
         _filteredQuery = tmpList;
      });
     
    // } else if (_selectedText == "اختر نوع الاستعلام") {
      } else if (_type == null) {
      _filteredQuery = _queriesResults;
    }
}


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(gradient: mainColor),
        child: Scaffold(
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
                    margin:
                        EdgeInsets.only(left: 0, right: 15, top: 10, bottom: 5),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: DropdownButtonHideUnderline(
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
                        "استعلام عام",
                    
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
                          _pressed =0;
                          // if(_selectedText == "'اختر نوع الاستعلام"){
                          //   _type = null;
                          // }
                         if (_selectedText == "استعلام عام") {
                            _type = 0;
                          }
                          // else{
                          //   _type = 1;
                          // }
                        });
                      },                      
                    ))),
              ],
              bottom: PreferredSize(
                  child: bottonsRow(),
                  preferredSize: Size(double.infinity, 90)),
            ),
          ),body:  RefreshIndicator(
    key: _refreshIndicatorKey,
    onRefresh: _refresh,
    child: Container(child:
          
          
           _pressed == 0?
           _filteredQuery.length == 0 ? Center(child:Text("لا توجد ردود استعلامات  ")): ListView.builder(
                itemCount:   _filteredQuery.length ,// _queriesResults.length,
                itemBuilder: (context,index)=>
                 queryReplyCard(context,_filteredQuery[index]))
                // queryReplyCard(context,_queriesResults[index])),
                :_pressed == 1 && _pressed != 0?
                _approved.length == 0 ? Center(child:Text("لا توجد استعلامات تم قبولها")):
                 ListView.builder(
                  itemCount:_approved.length ,
                  itemBuilder: (context,index)=>
                 queryReplyCard(context,_approved[index])):
                 _pressed ==2 && _pressed != 3 && _pressed != 1  && _pressed != 0 ?
                 _unapproved.length == 0 ? Center(child:Text("لا توجد استعلامات تم رفضها")):
                 ListView.builder(
                  itemCount:_unapproved.length ,
                  itemBuilder: (context,index)=>
                 queryReplyCard(context,_unapproved[index])):
                 _waiting.length == 0 ? Center(child:Text("لا توجد استعلامات في انتظار الرد عليها ")):
                 ListView.builder(
                  itemCount:_waiting.length ,
                  itemBuilder: (context,index){
                
               return  queryReplyCard(context,_waiting[index]);
               
               })
        ))));
  }

  Future  _refresh(){
    widget.model.getQueryResultData().then((_){
     setState(() {
       _queriesResults = widget.model.queriesResults;
     });
    });
 return widget.model.getQueryResultData();
  }


Widget bottonsRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    textDirection: TextDirection.rtl,
    children: <Widget>[
      SizedBox(width: 25),
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
          onPressed: () {
           setState(() {
             _pressed = 1;
           });
         
          }),
      SizedBox(width: 5),
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
          onPressed: () {
        
           setState(() {
             _pressed = 2;
           });
          }),
      SizedBox(width: 5),
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
          onPressed: () {
            print(_filteredQuery.length);
            print(_approved.length);
            print(_waiting.length);
              
         
           setState(() {
             _pressed = 3;
           });
          })
    ],
  );
}
}