import 'package:flutter/material.dart';
import 'package:riwaa/features/home/presentation/views/widgets/addPlant/addPlantViewBody.dart';

class AddPlantView extends StatelessWidget {
  const AddPlantView({required this.hash, super.key});
  final String hash;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddPlantViewBody(
        hash: hash,
      ),
    );
  }
}
