import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appStyles.dart';

class LogoBuilder extends StatelessWidget {
  const LogoBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppAssets.logo,
          width: 35,
        ),
        const SizedBox(width: 10,),
        const Text(
          'تطبيق رِواء',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }
}