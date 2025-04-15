import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/core/components/mainButton.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/home/presentation/manager/plantDetails/plantDetailsBloc.dart';
import 'package:riwaa/features/home/presentation/manager/plantDetails/plantDetailsEvents.dart';
import 'package:riwaa/features/home/presentation/manager/plantDetails/plantDetailsState.dart';

class WaterPlantButton extends StatelessWidget {
  const WaterPlantButton({this.deviceId,super.key});
  final String? deviceId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantDetailsBloc, PlantDetailsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: deviceId != null ? MainButton(
            borderRadius: 20,
            color: state.status == PlantDetailsStatus.watering ? Colors.grey : kPrimaryColor,
            onTap: state.status != PlantDetailsStatus.watering ? () {
              context.read<PlantDetailsBloc>().add(WaterPlantEvent(deviceId ?? ""));
            }: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding,vertical: 5),
              child: Text(
                'إرواء النبتة',
                style: AppStyles.bodySmall.copyWith(
                  color: Colors.white,
                ),
              ),
            )
          ) : const SizedBox(),
        );
      },
    );
  }
}
