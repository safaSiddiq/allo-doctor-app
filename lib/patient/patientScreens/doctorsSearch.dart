//import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:allo_doctor/models/doctor.dart';
import 'package:allo_doctor/pages/ui_widgets/onLoading.dart';
import 'package:allo_doctor/scoped_model.dart/mainModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../ui_widgets/doctorCard.dart';

class DoctorsSearch extends StatefulWidget {
  final MainModel model;
  DoctorsSearch(this.model);
  @override
  _DoctorsSearchState createState() => _DoctorsSearchState();
}

class _DoctorsSearchState extends State<DoctorsSearch> {

  TextEditingController editingController = TextEditingController();
  String _selectedText1 = "بالتخصص";
  String _selectedText2 = "بالدرجة العلمية";

  final mainColor = LinearGradient(
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.center,
    stops: [
      0.0,
      1.0,
    ],
    colors: [Color(0xFF87C9BF), Color(0xFF2B95AF)],
  );
  List<Doctor> _doctors ;
  @override
  initState() {
    widget.model.fetchDoctorsData();
       _doctors = widget.model.doctors;
  setState(() {
    
  });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Container(
          decoration: BoxDecoration(gradient: mainColor),
          child: Scaffold(
              backgroundColor: Color(0xFF00000),
              appBar: PreferredSize(
                  preferredSize: Size(double.infinity, 120), // 44 is the height
                  child: AppBar(
                    elevation: 0,
                    // shape: UnderlineInputBorder(
                    //     borderSide: BorderSide(
                    //         style: BorderStyle.solid, color: Colors.teal)),
                    backgroundColor: Color(0xFF0000),
                    actions: <Widget>[
                      RawMaterialButton(
                          onPressed: () {
                            //  showSearch(
                            //    context: context,
                            //   delegate: CustomSearchDelegate());
                          },
                          child: Container(
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              margin: EdgeInsets.only(
                                top: 10,
                                bottom: 2,
                                right: 30,
                              ),
                              //width: 280,
                              width: MediaQuery.of(context).size.width * 0.78,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {}))),
                    ],
                    bottom: PreferredSize(
                      preferredSize: Size(double.infinity, 80),
                      child: Container(
                                  padding: EdgeInsets.only(bottom:6),
                                  child:
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: [
                            SizedBox(width: 24),
                            RaisedButton(
                                onPressed: () {},
                                color: Colors.white,
                                textColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: 
                                Row(  
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Text(
                                        ' بالـإسم',
                                        style: TextStyle(fontSize: 11),
                                        textAlign: TextAlign.center,
                                      ),
                                      Icon(
                                        Icons.arrow_upward,
                                        size: 13,
                                        color: Color(0xFF2B95AF),
                                      ),
                                      Icon(
                                        Icons.arrow_downward,
                                        size: 13,
                                        color: Color(0xFF2B95AF),
                                      ),
                                    ])),
                            SizedBox(width: 8),
                            Container(
                                height: 35,
                                padding: EdgeInsets.only(left: 6),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                  icon: Container(
                                    //padding: EdgeInsets.only(left:5,right: 2),
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      size: 24,
                                      color: Color(0xFF2B95AF),
                                    ),
                                  ),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontFamily: 'Tajawal-Medium'),
                                  //hint: Text('الجنس'),
                                  value: _selectedText1,
                                  items: <String>['بالتخصص', 'أنثى']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String val) {
                                    _selectedText1 = val;
                                    setState(() {
                                      _selectedText1 = val;
                                    });
                                  },
                                ))),
                            SizedBox(width: 8),
                            Container(
                                height: 35,
                                padding: EdgeInsets.only(left: 6),
                                alignment: Alignment.topRight,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                  icon: Container(
                                    // padding: EdgeInsets.only(left:2),
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      size: 24,
                                      color: Color(0xFF2B95AF),
                                    ),
                                  ),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontFamily: 'Tajawal-Medium'),
                                  //hint: Text('الجنس'),
                                  value: _selectedText2,
                                  items: <String>['بالدرجة العلمية', 'أنثى']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String val) {
                                    _selectedText2 = val;
                                    setState(() {
                                      _selectedText2 = val;
                                    });
                                  },
                                ))),
                          ]),
                     ) ),
                  )),
              body:ListView.builder(
                itemCount: _doctors.length,
                
                itemBuilder: (context,index)=>
                  doctorCard(context,_doctors[index], true)
             
                )
              //  ListView(
              //   children: <Widget>[
              //     SizedBox(height: 10),
              //     Divider(),
              //     doctorCard(context, true),
              //     doctorCard(context, true),
              //     doctorCard(context, true),
              //     doctorCard(context, true),
              //     doctorCard(context, true)],)
              )
              );
    });
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return null;
  }
}

//  SearchBar<Post>(

//           searchBarStyle: SearchBarStyle(

//               padding: EdgeInsets.symmetric(horizontal: 20),
//               backgroundColor: Colors.grey[200]),
//           onSearch: search,
//           onItemFound: (Post post, int index) {
//             return ListTile(
//               title: Text(''),
//               subtitle: Text(''),
//             );
//           },
