import 'package:flutter/material.dart';
import 'package:riwaa/core/utilities/appStyles.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "اهلا بالعالم!!",
        style: AppStyles.titleLarge,
      ),
    );
  }
}