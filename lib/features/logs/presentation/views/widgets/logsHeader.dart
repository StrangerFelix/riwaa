import 'package:flutter/material.dart';
import 'package:riwaa/core/components/gradientText.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';

class LogsHeader extends StatelessWidget {
  const LogsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         SizedBox(height: MediaQuery.paddingOf(context).top + 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: GradientText(
              'الانشطة', 
              gradient: const LinearGradient(
                colors: [
                  Color(0xff406661),
                  Color(0xff4C9B49),
                ]
              ),
              style: AppStyles.titleMedium.copyWith(
                shadows: AppStyles.mainTextShadows
              ),
            ),
          )
      ],
    );
  }
}