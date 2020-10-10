import 'package:flutter/material.dart';

class MarkerModel{
  final double x;
  final double y;
  final String time;
  final String title;
  final String description;

  MarkerModel({
    @required this.x,
    @required this.y,
    @required this.time,
    @required this.title,
    @required this.description,
  });
}