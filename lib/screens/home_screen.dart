import 'package:construction_app/model/drawing_model.dart';
import 'package:construction_app/provider/data_provider.dart';
import 'package:construction_app/screens/add_drawing.dart';
import 'package:construction_app/size_config.dart';
import 'package:construction_app/widgets/drawing_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static final String routeName = '/';
  @override
  Widget build(BuildContext context) {
    final listOfDrawings = Provider.of<DataProvider>(context).drawings;
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawings'),
        centerTitle: true,
      ),
      body: Container(
        height: SizeConfig.blockSizeVertical * 85,
        child: ListView.builder(
          itemCount: listOfDrawings.length,
          itemBuilder: (BuildContext context, int index) =>
              DrawingCardWidget(listOfDrawings[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddDrawingScreen.routeName);
        },
      ),
    );
  }
}
