import 'package:flutter/material.dart';
import 'package:riwaa/core/utilities/constants.dart';

class AppStyles {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: kMainBackgroundColor,
    fontFamily: 'rubik',
    
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'rubik',
  );
  static const titleLarge = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );
  static const titleMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const titleSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const title18 = TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w600,
    height: 1.2
  );
  static const bodySmall = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  static const bodyMedium = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  static const paragraphSmall = TextStyle(
    fontSize: 15,
  );
  static List<Shadow> mainTextShadows = [
    Shadow(
      color: Colors.black.withValues(alpha: 0.25),
      offset: const Offset(0, 2),
      blurRadius: 10,
    )
  ];
  static List<BoxShadow> mainBoxShadows = [
    BoxShadow(
      color: Colors.black.withValues(alpha: .15),
      blurRadius: 10,
      offset: const Offset(0, 0),
    ),
  ];
}