import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riwaa/core/components/mainButton.dart';
import 'package:riwaa/core/utilities/appStyles.dart';

class EmptyWeatherViewBody extends StatelessWidget {
  const EmptyWeatherViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'يجب تحديد الموقع لغرض عرض البيانات',
          style: AppStyles.paragraphMedium,
        ),
        const SizedBox(height: 15,),
        MainButton(
          onTap: () {
            Geolocator.openAppSettings();
          },
          child: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'الذهاب للاعدادات',
              style: TextStyle(
                fontWeight: FontWeight.w500
              ),
            ),
          ), 
        )
      ],
    );
  }
}