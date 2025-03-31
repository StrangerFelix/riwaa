import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/components/dialog.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/features/home/presentation/manager/home/homeCubit.dart';
import 'package:riwaa/features/home/presentation/manager/plantDetails/plantDetailsCubit.dart';
import 'package:riwaa/features/home/presentation/manager/plantDetails/plantDetailsStates.dart';

class DeletePlantIcon extends StatelessWidget {
  const DeletePlantIcon({this.deviceId, this.userId,super.key});
  final String? userId;
  final String? deviceId;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          myDialog(context, height: 200,
              child: BlocBuilder<PlantDetailsCubit, PlantDetailsStates>(
            builder: (context, state) {
              return MyAlertDialog(
                  titleAlert: 'هل انت متاكد من حذف النبتة؟',
                  bodyAlert: 'حذف النبتة سيحذف جميع البيانات المتعلقة بها',
                  isDisabled: userId == null || deviceId == null,
                  onTap: () {
                    if (userId != null && deviceId != null) {
                      BlocProvider.of<PlantDetailsCubit>(context).deletePlant(
                        userId: userId!, deviceId: deviceId!
                      );
                      GoRouter.of(context).pop();
                      GoRouter.of(context).pop();
                      BlocProvider.of<HomeCubit>(context).getHomeData();
                    } 
                  });
            },
          ));
        },
        icon: SvgPicture.asset(
          AppAssets.delete,
          width: 25,
        ));
  }
}
