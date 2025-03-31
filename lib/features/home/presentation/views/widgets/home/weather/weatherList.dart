import 'package:flutter/material.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appIntl.dart';
import 'package:riwaa/features/home/data/models/weatherModel.dart';
import 'package:riwaa/features/home/presentation/views/widgets/home/weather/weatherItem.dart';

class WeatherList extends StatelessWidget {
  const WeatherList({this.tempUnit = 'c',this.weatherModel,required this.count,super.key});
  final int count;
  final WeatherModel? weatherModel;
  final String tempUnit;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      
      itemCount: count,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context,index) {
        Hour? hourCast = weatherModel?.forecast?.forecastday?[0].hour?[index];
        return index == 0 || index == count - 1 ? Row(
          children: [
            index == 0 ? const SizedBox(width: 10,) : const SizedBox(),
            WeatherItem(
              state: AppAssets.getWeatherState(
                hourCast?.condition?.text ?? "",
                hourCast?.isDay == 0,
              ),
              tempC: hourCast?.tempC?.toInt(),
              tempF: hourCast?.tempF?.toInt(),
              tempUnit: tempUnit,
              time: hourCast?.timeEpoch != null ? AppIntl.formatTime(hourCast!.timeEpoch!.toInt()) : '--',
              isNow: hourCast?.timeEpoch == AppIntl.getCurrentHourEpoch(),
            ),
            index == count - 1 ? const SizedBox(width: 10,) : const SizedBox(),
          ],
        )
        : WeatherItem(
          state: AppAssets.getWeatherState(
            hourCast?.condition?.text ?? "",
            hourCast?.isDay == 0,
          ),
          tempC: hourCast?.tempC?.toInt(),
          tempF: hourCast?.tempF?.toInt(),
          tempUnit: tempUnit,
          time: hourCast?.timeEpoch != null ? AppIntl.formatTime(hourCast!.timeEpoch!.toInt()) : '--',
          isNow: hourCast?.timeEpoch == AppIntl.getCurrentHourEpoch(),
        );
      } 
    );
  }
}