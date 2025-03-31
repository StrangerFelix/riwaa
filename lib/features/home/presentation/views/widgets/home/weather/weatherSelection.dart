import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';

class WeatherSelection extends StatelessWidget {
  const WeatherSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            const Text(
              'توقعات الطقس اليوم في ',
              style: AppStyles.bodyMedium,
            ),
            Text(
              'بغداد',
              style: AppStyles.bodyMedium.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
                shadows: AppStyles.mainTextShadows
              ),
            ),
            const SizedBox(width: 5,),
            Transform.rotate(
              angle: pi,
              child: const Icon(Icons.arrow_back_ios_new_rounded,size: 12,)
            )
          ],
        ),
      ),
    );
  }
}