import 'package:construction_app/model/drawing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DrawingScreen extends StatefulWidget {
  static final String routeName = '/drawingScreen';
  final DrawingModel drawingModel;
  final int index;
  DrawingScreen({this.drawingModel, this.index});

  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drawingModel.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height - 85.0,
          width: width,
          child: Stack(
            children: [
              Image.asset(
                widget.drawingModel.imageUrl,
                width: width,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
