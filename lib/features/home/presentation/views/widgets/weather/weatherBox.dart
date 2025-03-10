import 'package:flutter/material.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/home/presentation/views/widgets/weather/weatherList.dart';
import 'package:riwaa/features/home/presentation/views/widgets/weather/weatherSelection.dart';

class WeatherBox extends StatelessWidget {
  const WeatherBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: kHorizontalPadding),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: AppStyles.mainBoxShadows,
        ),
        height: 200,
        width: double.infinity,
        child: const Column(
          children: [
            WeatherSelection(),
            Expanded(
              child: WeatherList(count: 10,)
            )
          ],
        ),
      ),
    );
  }
}