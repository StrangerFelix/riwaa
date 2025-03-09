import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riwaa/core/components/svgWithShadow.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appStyles.dart';

class LogoBuilder extends StatelessWidget {
  const LogoBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgWithShadow(
          child: SvgPicture.asset(
            AppAssets.logo,
            width: 50,
          ),
        ),
        const SizedBox(width: 10,),
        Text(
          'تطبيق رِواء',
          style: TextStyle(
            fontSize: 30,
            shadows: AppStyles.mainTextShadows,
            fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }
}