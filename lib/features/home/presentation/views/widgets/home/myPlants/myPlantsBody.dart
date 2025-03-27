import 'package:flutter/material.dart';
import 'package:riwaa/features/home/data/models/homeModel.dart';
import 'package:riwaa/features/home/presentation/views/widgets/home/myPlants/myPlantsCarousel.dart';
import 'package:riwaa/features/home/presentation/views/widgets/home/myPlants/myPlantsHeader.dart';

class MyPlantsBody extends StatelessWidget {
  const MyPlantsBody({this.plants,super.key});
  final List<Plant>? plants;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MyPlantsHeader(),
        MyPlantsCarousel(plants: plants ?? [],)
        // MyPlantsList()
      ],
    );
  }
}