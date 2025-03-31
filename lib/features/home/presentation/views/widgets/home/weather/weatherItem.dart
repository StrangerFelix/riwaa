import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({this.isNow = false,required this.time,required this.tempUnit,this.tempC = -49,this.tempF = -49,this.state,super.key});
  final WeatherState? state;
  final int? tempF;
  final int? tempC;
  final String tempUnit;
  final String time;
  final bool isNow;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: kContainerBorderRadius,
        color: isNow ? Colors.grey.withValues(alpha: .1) : Colors.transparent
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: kMainBackgroundColor,
            radius: 35,
            child: SvgPicture.asset(
              AppAssets.weatherImage(state),
              width: 40,
            )
          ),
          const SizedBox(height: 5,),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              isNow ? 'Now' : time,
              style: AppStyles.paragraphSmall.copyWith(
                color: Colors.grey,
                fontWeight: isNow ? FontWeight.bold : null
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              '${tempUnit == 'c' ? (tempC! > -49 ? tempC : '-') : (tempF! > -49 ? tempF : '-')}°${tempUnit == 'c' ? 'C' : 'F'}',
              style: AppStyles.bodyMedium,
            ),
          )
        ],
      ),
    );
  }
}