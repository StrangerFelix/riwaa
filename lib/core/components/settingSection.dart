import 'package:flutter/material.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';

class SettingSection extends StatelessWidget {
  const SettingSection({required this.child,super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),      
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: Colors.white,
          boxShadow: AppStyles.mainBoxShadows
        ),
        child: child,
      ),
    );
  }
}