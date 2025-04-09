import 'package:flutter/material.dart';
import 'package:riwaa/core/utilities/appCache.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/home/data/models/weatherModel.dart';
import 'package:riwaa/features/home/presentation/views/widgets/home/weather/emptyWeatherViewBody.dart';
import 'package:riwaa/features/home/presentation/views/widgets/home/weather/weatherList.dart';
import 'package:riwaa/features/home/presentation/views/widgets/home/weather/weatherSelection.dart';

class WeatherBox extends StatelessWidget {
  const WeatherBox({this.weatherModel,super.key});
  final WeatherModel? weatherModel;
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
        child: Column(
          children: [
            weatherModel != null ? const WeatherSelection() : const SizedBox(),
            Expanded(
              child: weatherModel != null 
                ?  WeatherList(
                count: weatherModel?.forecast?.forecastday?[0].hour?.length ?? 0,
                weatherModel: weatherModel,
                tempUnit: AppCache.getData(key: 'temp_unit') ?? 'c',
                ) : const EmptyWeatherViewBody(),

            ),
            const SizedBox(height: 5,)
          ],
        ),
      ),
    );
  }
}