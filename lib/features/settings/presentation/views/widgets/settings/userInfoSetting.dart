import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/components/mainButton.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appRouter.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/settings/presentation/manager/settings/settingsCubit.dart';
import 'package:riwaa/features/settings/presentation/manager/settings/settingsStates.dart';

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
          const Text('يحيى محمد', style: AppStyles.bodyMedium),
          const SizedBox(height: 5),
          Text('ifelixridge007@gmail.com',
              style: AppStyles.bodySmall.copyWith(color: Colors.grey)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainButton(
                  color: Colors.grey,
                  onTap: () {
                    // GoRouter.of(context).push(AppRouter.editProfile);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.edit,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text('تعديل', style: AppStyles.bodySmall),
                      ],
                    ),
                  )),
              const SizedBox(
                width: 10,
              ),
              BlocConsumer<SettingsCubit, SettingsStates>(
                listener: (context, state) {
                  if (state is SignOutSuccess) {
                    GoRouter.of(context).pushReplacement(AppRouter.login);
                  }
                },
                builder: (context, state) {
                  return MainButton(
                      onTap: () {
                        BlocProvider.of<SettingsCubit>(context).signOut();
                      },
                      color: state is SignOutLoading ? Colors.grey : Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('تسجيل الخروج',
                                style: AppStyles.bodySmall
                                    .copyWith(color: Colors.white)),
                          ],
                        ),
                      ));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
