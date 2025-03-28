import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/core/utilities/serviceLocator.dart';
import 'package:riwaa/features/home/data/models/homeModel.dart';
import 'package:riwaa/features/home/data/repositories/plantDetailsRepo.dart';
import 'package:riwaa/features/home/presentation/manager/editPlantDetails/editPlantDetailsCubit.dart';
import 'package:riwaa/features/home/presentation/views/widgets/editPlantDetails/editPlantDetailsViewBody.dart';

class EditPlantDetailsView extends StatelessWidget {
  const EditPlantDetailsView({required this.plant, super.key});
  final Plant plant;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditPlantDetailsCubit(
        getIt.get<PlantDetailsRepository>()
      ),
      child: Scaffold(
        body: EditPlantDetailsViewBody(
          plant: plant,
        ),
      ),
    );
  }
}
