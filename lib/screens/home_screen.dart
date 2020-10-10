import 'package:construction_app/model/drawing_model.dart';
import 'package:construction_app/size_config.dart';
import 'package:construction_app/widgets/drawing_card_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static final String routeName = '/';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawings'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        height: SizeConfig.blockSizeVertical * 85,
        child: ListView(
          children: [
            DrawingCardWidget(
              new DrawingModel(
                drawingId: '1',
                imageUrl: 'assets/images/construction.jpg',
                time: '1 Day ago',
                title: 'Hello world',
                markers: [],
              ),
            ),
            DrawingCardWidget(
              new DrawingModel(
                drawingId: '2',
                imageUrl: 'assets/images/construction.jpg',
                time: '2 Days ago',
                title: 'Bye world',
                markers: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
