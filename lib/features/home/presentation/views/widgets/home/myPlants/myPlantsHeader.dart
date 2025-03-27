import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/components/gradientText.dart';
import 'package:riwaa/core/components/mainButton.dart';
import 'package:riwaa/core/utilities/appRouter.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';

class MyPlantsHeader extends StatelessWidget {
  const MyPlantsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GradientText(
            'النباتات الخاصة بي', 
            gradient: const LinearGradient(
              colors: [
                Color(0xff406661),
                Color(0xff4C9B49),
              ]
            ), 
            style: AppStyles.titleMedium.copyWith(
              shadows: AppStyles.mainTextShadows
            )
          ),
          MainButton(
            onTap: () {
              GoRouter.of(context).push(
                AppRouter.addPlantScan,
              );
              // For Simulator Testing
              // GoRouter.of(context).push(
              //   AppRouter.addPlant,
              //   extra: 'i1045df8d0b0dc512be141e5c0d96q37' // يحذف
              // );
              
            },
            child: Row(
              children: [
                const Icon(Icons.add,size: 16,),
                const SizedBox(width: 6),
                Text(
                  'إضافة نبتة',
                  style: AppStyles.bodySmall.copyWith(
                    fontSize: 13
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}