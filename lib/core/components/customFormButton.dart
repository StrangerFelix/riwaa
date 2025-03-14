import 'package:flutter/material.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';

class CustomFormButton extends StatelessWidget {
  const CustomFormButton({required this.onTap,required this.text,super.key});
  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          boxShadow: AppStyles.mainBoxShadows,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Center(
          child: Text(
            text,
            style: AppStyles.paragraphMedium,
          ),
        ),
      ),
    );
  }
}