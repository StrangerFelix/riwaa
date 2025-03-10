import 'package:flutter/material.dart';

class CopyrightText extends StatelessWidget {
  const CopyrightText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Center(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Text(
            '© 2024 Riwaa. All rights reserved.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}