import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/home/presentation/views/widgets/myPlants/myPlantDetails.dart';

class MyPlantsBox extends StatelessWidget {
  const MyPlantsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
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
                    'assets/images/pot.png',
                  ),
                ),
              ),
              Text(
                'البيزيا',
                style: AppStyles.titleMedium.copyWith(
                  color: Colors.black.withValues(alpha: 0.75),
                  letterSpacing: 0.95
                ),
              ),
              const SizedBox(height: 10,),
              const MyPlantDetails()
            ],
          ),
          PositionedDirectional(
            top: 5,
            start: 5,
            child: CircularPercentIndicator(
              radius: 30.0,
              lineWidth: 4.0,
              percent: 0.333333,
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
    );
  }
}