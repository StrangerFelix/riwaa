import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({this.state,super.key});
  final WeatherState? state;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
      child: Column(
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
              '7 PM',
              style: AppStyles.paragraphSmall.copyWith(color: Colors.grey),
            ),
          ),
          const Text(
            '33°C',
            style: AppStyles.bodyMedium,
          )
        ],
      ),
    );
  }
}