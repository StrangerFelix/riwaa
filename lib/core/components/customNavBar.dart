import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/components/scanButton.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appRouter.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .05),
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomIcon(
                  icon: AppAssets.navBarIcon(0, currentIndex == 0),
                  onTap: () {
                    setState(() => currentIndex = 0);
                    GoRouter.of(context).go(AppRouter.home);
                  },
                ),
                CustomIcon(
                  icon: AppAssets.navBarIcon(1, currentIndex == 1),
                  onTap: () {
                    setState(() => currentIndex = 1);
                    GoRouter.of(context).go(AppRouter.logs);
                  },
                ),
                const ScanButton(),
                CustomIcon(
                  icon: AppAssets.navBarIcon(2, currentIndex == 2),
                  onTap: () {
                    setState(() => currentIndex = 2);
                    GoRouter.of(context).go(AppRouter.notifications);
                  },
                ),
                CustomIcon(
                  icon: AppAssets.navBarIcon(3, currentIndex == 3),
                  onTap: () {
                    setState(() => currentIndex = 3);
                    GoRouter.of(context).go(AppRouter.settings);
                  },
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            height: MediaQuery.paddingOf(context).bottom / 2,
          )
      ],
    );
  }
}

class CustomIcon extends StatelessWidget {
  const CustomIcon({required this.onTap,required this.icon,super.key});
  final String icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.all(7.5),
        color: Colors.transparent,
        child: SvgPicture.asset(
          icon,
        ),
      ),
    );
  }
}