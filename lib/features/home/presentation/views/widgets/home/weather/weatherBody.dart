import 'package:flutter/material.dart';
import 'package:riwaa/features/home/presentation/views/widgets/home/weather/weatherBox.dart';
import 'package:riwaa/features/home/presentation/views/widgets/home/weather/weatherHeader.dart';

class WeatherBody extends StatelessWidget {
  const WeatherBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        WeatherHeader(),
        WeatherBox()
      ],
    );
  }
}