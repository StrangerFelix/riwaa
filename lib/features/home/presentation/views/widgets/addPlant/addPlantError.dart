import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/components/customFormButton.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';

class AddPlantError extends StatelessWidget {
  const AddPlantError({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppAssets.warning,
          width: 60,
        ),
        const SizedBox(height: 20,),
        Text(
          'قد يكون الـQR Code غير صالح او تالف!',
          style: AppStyles.bodySmall.copyWith(
            color: Colors.red
          ),
        ),
        const SizedBox(height: 40,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: CustomFormButton(
            onTap: () {
              GoRouter.of(context).pop();
            }, 
            text: 'العودة للصفحة الرئيسية'
          ),
        )
      ],
    );
  }
}