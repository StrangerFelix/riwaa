import 'package:flutter/material.dart';
import 'package:riwaa/features/home/presentation/views/widgets/myPlants/myPlantsCarousel.dart';
import 'package:riwaa/features/home/presentation/views/widgets/myPlants/myPlantsHeader.dart';

class MyPlantsBody extends StatelessWidget {
  const MyPlantsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        MyPlantsHeader(),
        MyPlantsCarousel()
        // MyPlantsList()
      ],
    );
  }
}