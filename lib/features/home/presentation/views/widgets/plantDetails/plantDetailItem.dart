import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riwaa/core/components/fancyProgressBar.dart';
import 'package:riwaa/core/utilities/appStyles.dart';

class PlantDetailItem extends StatelessWidget {
  const PlantDetailItem({super.key, this.percentage = 0.0, required this.icon, required this.title});
  final double percentage;
  final String icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 25,
            ),
            const SizedBox(width: 10,),
            Text(
              title, 
              style: AppStyles.bodySmall.copyWith(
                color: Colors.grey.shade800
              ),  
            ),
          ],
        ),
        const SizedBox(height: 10,),
        FancyProgressBar(
          progress: percentage.toDouble() / 100,
        ),
      ],
    );
  }
}