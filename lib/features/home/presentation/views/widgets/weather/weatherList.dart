import 'package:flutter/material.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/features/home/presentation/views/widgets/weather/weatherItem.dart';

class WeatherList extends StatelessWidget {
  const WeatherList({required this.count,super.key});
  final int count;
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: count,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context,index) {
        return index == 0 || index == count - 1 ? Row(
          children: [
            index == 0 ? const SizedBox(width: 10,) : const SizedBox(),
            const WeatherItem(state: WeatherState.moon),
            index == count - 1 ? const SizedBox(width: 10,) : const SizedBox(),
          ],
        )
        : const WeatherItem(state: WeatherState.moon);
      } 
    );
  }
}