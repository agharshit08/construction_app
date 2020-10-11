import 'package:construction_app/functions/custom_functions.dart';
import 'package:flutter/material.dart';

class MarkersScreen extends StatelessWidget {
  final List markers;
  MarkersScreen(this.markers);

  /// Show the list of markers in form of List View.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Markers'),
      ),
      body: Container(
          child: ListView.builder(
        itemCount: markers.length,
        itemBuilder: (BuildContext buildContext, int index) => ListTile(
          title: Text(markers[index]['title']),
          subtitle: Text(markers[index]['description']),
          trailing: Text(CustomFunctions.getDateInSocialFormat(markers[index]['time'])),
        ),
      )),
    );
  }
}
