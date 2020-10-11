import 'package:construction_app/model/drawing_model.dart';
import 'package:construction_app/model/marker_model.dart';
import 'package:construction_app/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:positioned_tap_detector/positioned_tap_detector.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class DrawingScreen extends StatefulWidget {
  static final String routeName = '/drawingScreen';
  final DrawingModel drawingModel;
  final int index;
  DrawingScreen({this.drawingModel, this.index});

  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  bool _switchOn = false;
  String _title;
  String _description;

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

  void _addMarker(TapPosition position) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Add Marker',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Expanded(child: Container()),
                FlatButton(
                    onPressed: () {
                      MarkerModel markerModel = MarkerModel(
                          x: position.global.dx,
                          y: position.global.dy,
                          time: DateTime.now().toString(),
                          title: _title,
                          description: _description);
                      // Provider.of<DataProvider>(context, listen: false)
                      //     .addNewMarker(
                      //         widget.drawingModel, widget.index, markerModel);
                      Navigator.of(context).pop();
                    },
                    child: Text('Done'))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(hintText: 'Enter title'),
                onChanged: (value) {
                  _title = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                minLines: 1,
                decoration: InputDecoration(hintText: 'Enter description'),
                onChanged: (value) {
                  _description = value;
                },
              ),
            )
          ],
        );
      },
    );
  }

  void _showMarkerDetails(MarkerModel marker) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Title: ' + marker.title),
            ),
            SizedBox(
              height: 20.0
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Description: ' + marker.description),
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        );
      },
    );
  }

  Stack _buildImageWithMarkers(double width) {
    final List<MarkerModel> markersList = widget.drawingModel.markers;

    List<Widget> markersWidget = [];

    markersList.forEach((marker) {
      markersWidget.add(
        Positioned(
          left: marker.x,
          top: marker.y,
          child: IconButton(
            icon: Icon(Icons.location_city_sharp),
            color: Colors.purple,
            onPressed: () {
              _showMarkerDetails(marker);
            },
          ),
        ),
      );
    });

    return Stack(
      children: [
        PositionedTapDetector(
          onDoubleTap: (position) => _addMarker(position),
          child: Image.asset(widget.drawingModel.imageUrl,
              width: width, fit: BoxFit.cover),
        ),
        ...markersWidget
      ],
    );
  }

  PhotoView buildZoomableImage() {
    return PhotoView(
        imageProvider: AssetImage(
      widget.drawingModel.imageUrl,
    ));
  }

  Row _switchZoomStatus() {
    return Row(
      children: [
        Text('Zoom Image'),
        Switch(
          value: _switchOn,
          onChanged: (value) {
            setState(
              () {
                _switchOn = value;
                print(_switchOn);
              },
            );
          },
          activeColor: Colors.red.withOpacity(0.5),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drawingModel.title),
        actions: [
          _switchZoomStatus(),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height - 85.0,
          width: width,
          child:
              _switchOn ? buildZoomableImage() : _buildImageWithMarkers(width),
        ),
      ),
    );
  }
}
