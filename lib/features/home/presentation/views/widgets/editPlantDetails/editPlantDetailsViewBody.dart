import 'package:flutter/material.dart';
import 'package:riwaa/features/home/data/models/homeModel.dart';
import 'package:riwaa/features/home/presentation/views/widgets/editPlantDetails/editPlantAppBar.dart';
import 'package:riwaa/features/home/presentation/views/widgets/editPlantDetails/editPlantDetailsForm.dart';

class EditPlantDetailsViewBody extends StatelessWidget {
  const EditPlantDetailsViewBody({required this.plant,super.key});
  final Plant plant;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: EditPlantDetailsForm(
            plant: plant,
          ),
        ),
        const EditPlantAppBar()
      ],
    );
  }
}