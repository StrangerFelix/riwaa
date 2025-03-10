import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appRouter.dart';
import 'package:riwaa/core/utilities/appStyles.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push(AppRouter.scan),
      child: Container(
        width: 65,  // Avatar size
        height: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: AppStyles.mainBoxShadows,
          gradient: const LinearGradient(
            colors: [
              Color(0xff57D131),
              Color(0xff406661)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(AppAssets.scan),
        ),
      ),
    );
  }
}