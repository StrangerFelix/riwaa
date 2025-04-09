import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/core/components/mainButton.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/core/utilities/serviceLocator.dart';
import 'package:riwaa/features/home/data/repositories/plantDetailsRepo.dart';
import 'package:riwaa/features/home/presentation/manager/waterPlant/waterPlantCubit.dart';
import 'package:riwaa/features/home/presentation/manager/waterPlant/waterPlantStates.dart';

class WaterPlantButton extends StatelessWidget {
  const WaterPlantButton({this.deviceId,super.key});
  final String? deviceId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WaterPlantCubit(
        getIt.get<PlantDetailsRepository>()
      ),
      child: BlocBuilder<WaterPlantCubit, WaterPlantStates>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: state is WaterPlantLoading ? const CircularProgressIndicator(color: kPrimaryColor,) 
            : deviceId != null ? MainButton(
              borderRadius: 20,
              color: state is WaterPlantLoading ? Colors.grey : kPrimaryColor,
              onTap: () {
                BlocProvider.of<WaterPlantCubit>(context).waterPlant(deviceId!);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding,vertical: 5),
                child: Text(
                  'ارواء النبتة',
                  style: AppStyles.bodySmall.copyWith(
                    color: Colors.white,
                  ),
                ),
              )
            ) : const SizedBox(),
          );
        },
      ),
    );
  }
}
