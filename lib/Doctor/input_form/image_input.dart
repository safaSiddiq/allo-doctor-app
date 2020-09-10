import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ImageInputDr extends StatefulWidget {
   final Function setImage;
  //final Patient patient;

  ImageInputDr(this.setImage,);
  @override
  State<StatefulWidget> createState() {
    return _ImageInputDrState();
  }
}


class _ImageInputDrState extends State<ImageInputDr> {
 // ignore: unused_field
 File _imageFile;

  void _getImage(BuildContext context, ImageSource source) {
     ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image) {
      setState(() {
      _imageFile = image;

      });
       widget.setImage(image);
      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(color: Colors.grey[100]),
            height: 170.0,
            padding: EdgeInsets.all(10.0),
            child: Column(children: [
              Text(
                'اختر صورة',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('التقط صورة'),
                onPressed: () {
                    _getImage(context, ImageSource.camera);
                },
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text(' البوم الكاميرا'),
                onPressed: () {
                  _getImage(context, ImageSource.gallery);
                },
              )
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget editButton() {
      return Container(
          //padding: EdgeInsets.only(bottom: 4,right:12),
          child: Row(textDirection: TextDirection.rtl, children: <Widget>[
            Icon(
              Icons.edit,
              size: 16.0,
              color: Colors.white,
            ),
            Text(
              'تغيير الصورة',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          ]));
    }

    return Column(children: <Widget>[

    Container(
      padding: EdgeInsets.only(left:10,),
      child:  RaisedButton(
        padding: EdgeInsets.only(top:5,right:18,),
    
          shape: RoundedRectangleBorder(
            side: BorderSide(
              style: BorderStyle.none,
            ),
          ),
          color: Colors.grey.withOpacity(0.05),
          child: editButton(),
          onPressed: () {
            _openImagePicker(context);
          }))
    ]);
  }
}
