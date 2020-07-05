//import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';



class ImageInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  // File _imageFile;

  // void _getImage(BuildContext context, ImageSource source) {
  //   ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image) {
  //     setState(() {
  //       _imageFile = image;
  //     });
  //     Navigator.pop(context);
  //   });
  // }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(            
              color: Colors.grey[100]
            ),
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
                //  _getImage(context, ImageSource.camera);
                },
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text(' البوم الكاميرا'),
                onPressed: () {
                  //_getImage(context, ImageSource.gallery);
                },
              )
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(Icons.photo,
    color: Colors.white,
    size: 25,), 
    onPressed: (){
      _openImagePicker(context);
    });
    
  }
}
