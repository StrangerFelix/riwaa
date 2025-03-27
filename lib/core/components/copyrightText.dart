import 'package:flutter/material.dart';
import 'package:riwaa/core/utilities/appStyles.dart';

class CopyrightText extends StatelessWidget {
  const CopyrightText({this.isSplash = false,super.key});
  final bool isSplash;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Center(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Text(
            '© 2024 Riwaa. All rights reserved.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSplash ? Colors.white : Colors.grey,
              shadows: isSplash ? AppStyles.mainTextShadows : null,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}