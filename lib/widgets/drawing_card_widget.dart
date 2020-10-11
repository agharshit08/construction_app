import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_app/model/drawing_model.dart';
import 'package:construction_app/screens/drawing_screen.dart';
import 'package:construction_app/size_config.dart';
import 'package:flutter/material.dart';

class DrawingCardWidget extends StatelessWidget {
  final DrawingModel drawingModel;
  DrawingCardWidget(this.drawingModel);

  final TextStyle textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15.0,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DrawingScreen(
              drawingModel: drawingModel,
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: drawingModel.imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Center(child: Text('Loading Image...')),
              height: SizeConfig.blockSizeVertical * 30,
              width: SizeConfig.blockSizeVertical * 90,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Text(drawingModel.title, style: textStyle),
            Text(
              drawingModel.time,
              style: textStyle,
            ),
            Text(
              'Markers: ' + drawingModel.markers.length.toString(),
              style: textStyle,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
          ],
        ),
      ),
    );
  }
}
