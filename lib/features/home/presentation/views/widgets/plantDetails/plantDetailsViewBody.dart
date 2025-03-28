import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riwaa/core/components/svgWithShadow.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/home/data/models/addPlantDroplist.dart';
import 'package:riwaa/features/home/data/models/homeModel.dart';
import 'package:riwaa/features/home/presentation/views/widgets/plantDetails/plantDetailItem.dart';
import 'package:riwaa/features/home/presentation/views/widgets/plantDetails/plantTemperature.dart';

class PlantDetailsViewBody extends StatelessWidget {
  const PlantDetailsViewBody({required this.plant,super.key});
  final Plant plant;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Image(
            image: AssetImage(AppAssets.potImage(plant.type ?? "other")),
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Opacity(
                          opacity: .75,
                          child: Text(
                            plant.name ?? "--",
                            style: AppStyles.titleLarge.copyWith(
                              shadows: AppStyles.mainTextShadows,
                              fontSize: 40.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          plantNaming[plant.type],
                          style: AppStyles.bodySmall.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 15,),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: IconButton(
                        onPressed: () {}, 
                        icon: SvgWithShadow(child: SvgPicture.asset(AppAssets.edit)),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 2.5,
                  width: MediaQuery.sizeOf(context).width * .9,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                
                  ),
                ),
                const SizedBox(height: 30,),
                const PlantDetailItem(
                  icon: AppAssets.drop, 
                  title: 'رطوبة التربة:',
                  percentage: 0.6,
                ),
                const SizedBox(height: 30,),
                const PlantDetailItem(
                  icon: AppAssets.sun, 
                  title: 'رطوبة الجو:',
                  percentage: 0.19,
                ),
                const SizedBox(height: 30,),
                const PlantTemperature(temperature: 50,)
                
              ],
            ),
          )
        )
      ],
    );
  }
}