import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


 onLoading(BuildContext context){
  return showDialog(
    context: context,
    builder:(BuildContext context) {
      return   Container(     
      margin: EdgeInsets.symmetric(vertical:185,horizontal:30),
        child:
       AlertDialog(
         backgroundColor: Colors.grey[300],
         elevation: 5,
      shape:  RoundedRectangleBorder(
        side: BorderSide(color:Colors.white,width: 2),
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SpinKitFadingCircle(
            color: Colors.teal,
            size: 50,
          ))
      );
    }
    );
}