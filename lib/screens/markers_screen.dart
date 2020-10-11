import 'package:flutter/material.dart';

class MarkersScreen extends StatelessWidget {
  final List markers;
  MarkersScreen(this.markers);

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
          trailing: Text(markers[index]['time']),
        ),
      )),
    );
  }
}
