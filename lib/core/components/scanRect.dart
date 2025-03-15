import 'package:flutter/material.dart';

Rect scanRect (BuildContext context){
  final size = MediaQuery.of(context).size;
  return size.width > size.height ? 
    Rect.fromCenter(
        center: Offset(
          size.width / 2, 
          size.height / 2
        ),
        width: size.height * 0.85,
        height: size.height * 0.85,
      )
    : Rect.fromCenter(
        center: Offset(
          size.width / 2, 
          size.height / 2
        ),
        width: size.width * 0.85,
        height: size.width * 0.85
    );
}