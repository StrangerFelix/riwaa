import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/home/data/models/homeModel.dart';
import 'package:riwaa/features/home/presentation/views/widgets/plantDetails/deletePlantIcon.dart';
import 'package:riwaa/features/home/presentation/views/widgets/plantDetails/plantDetailsViewBody.dart';

class PlantDetailsView extends StatelessWidget {
  const PlantDetailsView({required this.plant, super.key});
  final Plant plant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainBackgroundColor,
        elevation: 0.0,
        title: const Text('تفاصيل النبتة'),
        leading: IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(Icons.close_rounded)),
        actions: const [DeletePlantIcon()],
      ),
      body: PlantDetailsViewBody(
        plant: plant,
      ),
    );
  }
}
