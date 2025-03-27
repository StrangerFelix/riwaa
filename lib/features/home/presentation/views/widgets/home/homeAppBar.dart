import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riwaa/core/components/svgWithShadow.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({this.userName,super.key});
  final String? userName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Row(
        children: [
          SvgWithShadow(
            child: SvgPicture.asset(
              AppAssets.logo,
              height: 50,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: 2,
            height: 20,
            decoration: const BoxDecoration(
              color: Color(0xffD9D9D9),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'مرحباً ${userName?.split(' ').first ?? ""} 🌱',
            style: AppStyles.titleLarge.copyWith(
              fontWeight: FontWeight.w600,
              shadows: AppStyles.mainTextShadows
            ),
          )
        ],
      ),
    );
  }
}