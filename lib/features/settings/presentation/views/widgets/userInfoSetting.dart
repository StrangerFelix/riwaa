import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riwaa/core/components/mainButton.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';

class UserInfoSetting extends StatelessWidget {
  const UserInfoSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .15),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: kPrimaryColor,
              child: SvgPicture.asset(AppAssets.user),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'يحيى محمد',
            style: AppStyles.bodyMedium
          ),
          const SizedBox(height: 5),
          Text(
            'ifelixridge007@gmail.com',
            style: AppStyles.bodySmall.copyWith(
              color: Colors.grey
            )
          ),
          const SizedBox(height: 20),
          MainButton(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'تعديل',
                style: AppStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.normal
                )
              ),
            ) 
          ),
        ],
      ),
    );
  }
}