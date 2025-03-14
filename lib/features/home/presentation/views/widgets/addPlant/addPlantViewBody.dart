import 'package:flutter/material.dart';
import 'package:riwaa/features/home/presentation/views/widgets/addPlant/addPlantAppBar.dart';
import 'package:riwaa/features/home/presentation/views/widgets/addPlant/addPlantError.dart';
import 'package:riwaa/features/home/presentation/views/widgets/addPlant/addPlantForm.dart';

class AddPlantViewBody extends StatelessWidget {
  const AddPlantViewBody({required this.hash,super.key});
  final String hash;

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        hash == 'wrong' ? const AddPlantError() : AddPlantForm(hash: hash,),
        const AddPlantAppBar(),
      ],
    );
  }
}