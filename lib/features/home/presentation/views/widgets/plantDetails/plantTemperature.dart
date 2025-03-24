import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';

class PlantTemperature extends StatelessWidget {
  const PlantTemperature({this.temperature = 0,super.key});
  final double temperature;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SvgPicture.asset(
            AppAssets.temp,
            
            width: 15,
          ),
        ),
        const SizedBox(width: 10,),
        Text(
          'درجة الحرارة:', 
          style: AppStyles.bodySmall.copyWith(
            color: Colors.grey.shade800
          ),
        ),
        const SizedBox(width: 10,),
        Opacity(
          opacity: .8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              boxShadow: AppStyles.mainBoxShadows,
              gradient: const LinearGradient(
                colors: [ Color(0xFF6FE08D),kPrimaryColor],
                begin: AlignmentDirectional.centerEnd,
                end: AlignmentDirectional.centerStart,
                
              ),
              borderRadius: kContainerBorderRadius,
            ),
            child: Text(
              '${temperature.toInt()}°C', 
              style: AppStyles.bodySmall.copyWith(
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    offset: const Offset(0, 0),
                    blurRadius: 5,
                  ),
                ]
              ),  
            ),
          ),
        ),
      ],
    );
  }
}