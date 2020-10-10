import 'package:construction_app/model/drawing_model.dart';
import 'package:construction_app/model/marker_model.dart';
import 'package:flutter/widgets.dart';

class DataProvider with ChangeNotifier {
  List<DrawingModel> _drawings = [
    DrawingModel(
      drawingId: '1',
      imageUrl: 'assets/images/construction.jpg',
      time: '1 Day ago',
      title: 'Hello world',
      markers: [],
    ),
    DrawingModel(
      drawingId: '2',
      imageUrl: 'assets/images/construction.jpg',
      time: '2 Days ago',
      title: 'Bye world',
      markers: [],
    ),
  ];

  List<DrawingModel> get drawings => _drawings;

  void addNewDrawing(String title) {
    drawings.add(
      DrawingModel(
        drawingId: '3',
        imageUrl: 'assets/images/construction.jpg',
        time: DateTime.now().toString(),
        title: title,
        markers: [],
      ),
    );
    notifyListeners();
  }

  void addNewMarker(DrawingModel drawingModel, int index, MarkerModel markerModel){
    _drawings[index].markers.add(markerModel);
    notifyListeners();
  }

  List<MarkerModel> getMarkers(int index){
    return _drawings[index].markers;
  }
}
