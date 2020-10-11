import 'dart:io';

import 'package:construction_app/provider/data_provider.dart';
import 'package:construction_app/size_config.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class AddDrawingScreen extends StatefulWidget {
  static final String routeName = '/addDrawingScreen';

  @override
  _AddDrawingScreenState createState() => _AddDrawingScreenState();
}

class _AddDrawingScreenState extends State<AddDrawingScreen> {
  String _title;
  File _image;

  void _showFlushbar(String message) {
    Flushbar(
      message: message,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  Padding _buildTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        minLines: 1,
        maxLines: 3,
        decoration: InputDecoration(hintText: 'Enter title'),
        onChanged: (value) {
          _title = value;
        },
      ),
    );
  }

  Future getImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image == null) {
      _showFlushbar('Please choose thumbnail.');
    } else {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Widget _buildThumbnailArea() {
    return _image == null
        ? Container()
        : Container(
            padding: EdgeInsets.all(10.0),
            child: Image.file(
              _image,
              height: SizeConfig.blockSizeVertical * 40,
              width: SizeConfig.blockSizeHorizontal * 80,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Drawing'),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () async {
              if (_image == null) {
                _showFlushbar('Please choose thumbnail');
                return;
              }
              if (_title.isEmpty) {
                _showFlushbar('Please enter title');
                return;
              }
              // Add to db and list here.
              final ProgressDialog pr = ProgressDialog(context);
              pr.style(
                message: 'Uploading...',
              );
              await pr.show();
              await Provider.of<DataProvider>(context, listen: false)
                  .addNewDrawing(_title, _image);
              await pr.hide();
              Navigator.of(context).pop();
              print('Submitted');
            },
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            _buildTextField(),
            _buildThumbnailArea(),
            SizedBox(height: SizeConfig.blockSizeVertical * 5),
            RaisedButton(
              onPressed: getImage,
              child:
                  _image == null ? Text('Choose Image') : Text('Change Image'),
            ),
          ],
        ),
      ),
    );
  }
}
