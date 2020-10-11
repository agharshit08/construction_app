import 'package:flutter/material.dart';

/// This is helpful for responsive UI design according to different screens.
/// This convert screen height and width to grid of 100x100, so now if we specify height of Widget as blockSizeVertical*10 that widget would take 10% of height of screen.
class SizeConfig {
 static MediaQueryData _mediaQueryData;
 static double screenWidth;
 static double screenHeight;
 static double blockSizeHorizontal;
 static double blockSizeVertical;
 
 void init(BuildContext context) {
  _mediaQueryData = MediaQuery.of(context);
  screenWidth = _mediaQueryData.size.width;
  screenHeight = _mediaQueryData.size.height;
  blockSizeHorizontal = screenWidth / 100;
  blockSizeVertical = screenHeight / 100;
 }
}