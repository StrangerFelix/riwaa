import 'package:flutter/material.dart';

class HomeErrorViewBody extends StatelessWidget {
  const HomeErrorViewBody({this.error,super.key});
  final String? error;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          error ?? 'حدث خطأ ما',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}