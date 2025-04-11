import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/core/utilities/firebaseService.dart';
import 'package:riwaa/core/utilities/serviceLocator.dart';
import 'package:riwaa/features/home/presentation/manager/home/homeCubit.dart';
import 'package:riwaa/features/home/presentation/manager/plantDetails/plantDetailsBloc.dart';
import 'package:riwaa/features/home/presentation/manager/plantDetails/plantDetailsEvents.dart';
import 'package:riwaa/features/home/presentation/manager/plantDetails/plantDetailsState.dart';
import 'package:riwaa/features/home/presentation/views/widgets/plantDetails/deletePlantIcon.dart';
import 'package:riwaa/features/home/presentation/views/widgets/plantDetails/plantDetailsViewBody.dart';

class PlantDetailsView extends StatelessWidget {
  const PlantDetailsView({required this.plantId,super.key});
  final String plantId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainBackgroundColor,
        elevation: 0.0,
        title: const Text('تفاصيل النبتة'),
        leading: BlocBuilder<PlantDetailsBloc, PlantDetailsState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
                if (state.changed) {
                  context.read<PlantDetailsBloc>().add(ResetPlantDetailsEvent());
                  BlocProvider.of<HomeCubit>(context).getHomeData();
                }
              },
              icon: const Icon(Icons.close_rounded));
          }
        ),
        actions: [
          DeletePlantIcon(
            userId: getIt.get<FirebaseService>().firebaseAuth.currentUser!.uid,
            deviceId: plantId,
          )
        ],
      ),
      body: PlantDetailsViewBody(plantId: plantId),
    );
  }
}
