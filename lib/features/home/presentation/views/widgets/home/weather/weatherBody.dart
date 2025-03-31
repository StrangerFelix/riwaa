import 'package:flutter/material.dart';
import 'package:riwaa/features/home/data/models/weatherModel.dart';
import 'package:riwaa/features/home/presentation/views/widgets/home/weather/weatherBox.dart';
import 'package:riwaa/features/home/presentation/views/widgets/home/weather/weatherHeader.dart';

class WeatherBody extends StatelessWidget {
  const WeatherBody({this.weatherModel,super.key});
  final WeatherModel? weatherModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const WeatherHeader(),
        WeatherBox(weatherModel: weatherModel,)
      ],
    );
  }
}