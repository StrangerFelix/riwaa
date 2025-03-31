import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/core/utilities/firebaseService.dart';
import 'package:riwaa/core/utilities/serviceLocator.dart';
import 'package:riwaa/features/settings/data/repository/settingsRepo.dart';
import 'package:riwaa/features/settings/presentation/manager/settings/settingsCubit.dart';
import 'package:riwaa/features/settings/presentation/manager/settings/settingsStates.dart';

import 'package:riwaa/features/settings/presentation/views/widgets/settings/allowNotificationsSetting.dart';
import 'package:riwaa/core/components/copyrightText.dart';
import 'package:riwaa/features/settings/presentation/views/widgets/settings/settingsHeader.dart';
import 'package:riwaa/features/settings/presentation/views/widgets/settings/tempUnitSetting.dart';
import 'package:riwaa/features/settings/presentation/views/widgets/settings/userInfoSetting.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(getIt.get<SettingsRepository>())
        ..getUserData(
            getIt.get<FirebaseService>().firebaseAuth.currentUser?.uid ?? ""),
      child: BlocBuilder<SettingsCubit, SettingsStates>(
        builder: (context, state) {
          if (state is GetUserDataLoading) {
            return const Center(child: CircularProgressIndicator(color: kPrimaryColor,),);
          }
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SettingsHeader(),
                const SizedBox(height: 20),
                UserInfoSetting(
                  name: state is GetUserDataSuccess ? state.model.name : null,
                  email: state is GetUserDataSuccess ? state.model.email : null
                ),
                const SizedBox(height: 25),
                const AllowNotificationsSetting(),
                const SizedBox(height: 20),
                const TempUnitSetting(),
                const CopyrightText()
              ],
            ),
          );
        },
      ),
    );
  }
}
