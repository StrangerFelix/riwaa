import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/core/utilities/serviceLocator.dart';
import 'package:riwaa/features/settings/data/repository/settings/settingsRepo.dart';
import 'package:riwaa/features/settings/presentation/manager/settings/settingsCubit.dart';

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
      create: (context) => SettingsCubit(
        getIt.get<SettingsRepository>()
      ),
      child: const SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsHeader(),
            SizedBox(height: 20),
            UserInfoSetting(),
            SizedBox(height: 25),
            AllowNotificationsSetting(),
            SizedBox(height: 20),
            TempUnitSetting(),
            CopyrightText()
          ],
        ),
      ),
    );
  }
}
