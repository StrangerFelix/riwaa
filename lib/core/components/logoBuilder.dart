import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riwaa/core/components/svgWithShadow.dart';
import 'package:riwaa/core/utilities/appAssets.dart';

class LogoBuilder extends StatelessWidget {
  const LogoBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgWithShadow(
          child: SvgPicture.asset(
            AppAssets.splashlogo,
            width: 50,
          ),
        ),
      ],
    );
  }
}