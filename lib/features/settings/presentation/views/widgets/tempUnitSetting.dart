import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riwaa/core/components/customSwitch.dart';
import 'package:riwaa/core/components/settingSection.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appStyles.dart';

class TempUnitSetting extends StatefulWidget {
  const TempUnitSetting({super.key});

  @override
  State<TempUnitSetting> createState() => _TempUnitSettingState();
}

class _TempUnitSettingState extends State<TempUnitSetting> {
  @override
  Widget build(BuildContext context) {
    return SettingSection(
      child: Row(
        children: [
          SvgPicture.asset(AppAssets.tempunit),
          const SizedBox(width: 15),
          const Text(
            'وحدة الحرارة',
            style: AppStyles.paragraphMedium,
          ),
          const Spacer(),
          CustomToggleSwitch(
            optionOne: '°F', 
            optionTwo: '°C', 
            initialValue: true, 
            onChanged: (val) {
              
            }
          )
        ],
      ),
    );
  }
}