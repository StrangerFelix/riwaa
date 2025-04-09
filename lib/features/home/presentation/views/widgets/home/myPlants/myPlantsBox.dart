import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appRouter.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/home/data/models/homeModel.dart';
import 'package:riwaa/features/home/presentation/views/widgets/home/myPlants/myPlantDetails.dart';

class MyPlantsBox extends StatelessWidget {
  const MyPlantsBox({required this.plant,super.key});
  final Plant plant;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(
          AppRouter.plantDetails,
          extra: plant
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: kContainerBorderRadius,
          boxShadow: AppStyles.mainBoxShadows,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      AppAssets.potImage(
                        plant.type ?? "other"
                      ),
                    ),
                  ),
                ),
                Opacity(
                  opacity: .75,
                  child: Text(
                    plant.name ?? "--",
                    style: AppStyles.titleLarge.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                MyPlantDetails(
                  moisture: plant.info?.moisture?.toDouble() ?? -1,
                  humidity: plant.info?.humidity?.toDouble() ?? -1,
                  temperature: plant.info?.temperature?.toDouble() ?? -49,
                )
              ],
            ),
            PositionedDirectional(
              top: 5,
              start: 5,
              child: CircularPercentIndicator(
                radius: 30.0,
                lineWidth: 4.0,
                percent: plant.info?.moisture != null && plant.info?.moisture != -1 ? plant.info!.moisture! / 100 : 0,
                center: SvgPicture.asset(
                  AppAssets.drop,
                  width: 24,
                ),
                progressColor: kPrimaryColor,
                backgroundColor: Colors.grey.withValues(alpha: 0.25),
                circularStrokeCap: CircularStrokeCap.round,
              )
            )
          ],
        ),
      ),
    );
  }
}