import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_app/model/drawing_model.dart';
import 'package:construction_app/provider/data_provider.dart';
import 'package:construction_app/screens/markers_screen.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:positioned_tap_detector/positioned_tap_detector.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class DrawingScreen extends StatefulWidget {
  static final String routeName = '/drawingScreen';
  final DrawingModel drawingModel;
  DrawingScreen({this.drawingModel});

  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  // To switch from zoom mode or markers mode.
  bool _switchOn = false;

  // To hold title and description for new Marker to be added.
  String _title = '';
  String _description = '';

  // Liat of all the markers in the drawing.
  List _markers;

  /// To change the orientation of phone to landscape mode to better visualize drawing.
  @override
  void initState() {
    super.initState();
    _markers = widget.drawingModel.markers;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  /// To change orientaion of phone again to Portrait mode when leaving the page.
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

  /// Show small alert if validation fails.
  void _showFlushbar(String message) {
    Flushbar(
      message: message,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  /// Add new marker by entering data in bottom sheet and pop off the sheet after done.
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
                    // Validate wheter fields are filled or not then setState to update the UI with new marker and add it to Database as well behind the scenes.
                    if (_title.isEmpty || _description.isEmpty) {
                      _showFlushbar('Please fill all the fields.');
                      return;
                    }
                    Map marker = {
                      'x': position.global.dx,
                      'y': position.global.dy,
                      'time': DateTime.now().toString(),
                      'title': _title,
                      'description': _description,
                    };
                    setState(() {
                      _markers.add(marker);
                    });
                    Provider.of<DataProvider>(context, listen: false)
                        .addNewMarker(widget.drawingModel, _markers);
                    // Pop off bottom sheet.
                    Navigator.of(context).pop();
                  },
                  child: Text('Done'),
                )
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

  /// Show marker details in bottom sheet.
  void _showMarkerDetails(Map marker) {
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
              child: Text('Title: ' + marker['title']),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Description: ' + marker['description']),
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
    final List markersList = _markers;
    List<Widget> markersWidget = [];

    /// Create markers widget to be displayed at appropriate positions.
    markersList.forEach((marker) {
      markersWidget.add(
        Positioned(
          left: marker['x'],
          top: marker['y'],
          child: IconButton(
            icon: Icon(Icons.location_city_sharp),
            color: Colors.red,
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
          child: Image(
            image: CachedNetworkImageProvider(widget.drawingModel.imageUrl),
            fit: BoxFit.cover,
            width: width,
          ),
        ),
        ...markersWidget /// 
      ],
    );
  }

  PhotoView _buildZoomableImage() {
    return PhotoView(
      imageProvider: CachedNetworkImageProvider(
        widget.drawingModel.imageUrl,
      ),
    );
  }

  /// Switch from zoom to not zoom status.
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

  /// Navigate to markers list.
  Widget _buildShowMarkersButton() {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MarkersScreen(_markers)));
      },
      child: Text(
        'View Markers',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drawingModel.title),
        actions: [_switchZoomStatus(), _buildShowMarkersButton()],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height - 85.0,
          width: width,
          child:
              _switchOn ? _buildZoomableImage() : _buildImageWithMarkers(width),
        ),
      ),
    );
  }
}
