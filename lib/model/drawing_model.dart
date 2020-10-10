import 'package:construction_app/model/marker_model.dart';
import 'package:flutter/widgets.dart';

class DrawingModel {
  final String drawingId;
  final String title;
  final String imageUrl;
  final List<MarkerModel> markers;
  final String time;

  DrawingModel({
    @required this.drawingId,
    @required this.imageUrl,
    @required this.time,
    @required this.title,
    @required this.markers
  });
}
