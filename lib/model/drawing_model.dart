import 'package:flutter/widgets.dart';

// Data Model for the drawings.
class DrawingModel {
  final String drawingId;
  final String title;
  final String imageUrl;
  final List markers;
  final String time;

  DrawingModel({
    @required this.drawingId,
    @required this.imageUrl,
    @required this.time,
    @required this.title,
    @required this.markers
  });
}
