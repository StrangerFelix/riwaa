import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/core/utilities/serviceLocator.dart';
import 'package:riwaa/features/home/data/repositories/addPlantRepo.dart';
import 'package:riwaa/features/home/presentation/manager/addPlant/addPlantCubit.dart';
import 'package:riwaa/features/home/presentation/views/widgets/addPlant/addPlantAppBar.dart';
import 'package:riwaa/features/home/presentation/views/widgets/addPlant/addPlantError.dart';
import 'package:riwaa/features/home/presentation/views/widgets/addPlant/addPlantForm.dart';

class AddPlantViewBody extends StatelessWidget {
  const AddPlantViewBody({required this.hash, super.key});
  final String hash;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        hash == 'wrong'
            ? const AddPlantError()
            : BlocProvider(
                create: (context) => AddPlantCubit(
                  getIt.get<AddPlantRepository>(),
                )..checkIfPlantExists(hash),
                child: AddPlantForm(
                  hash: hash,
                ),
              ),
        const AddPlantAppBar(),
      ],
    );
  }
}
