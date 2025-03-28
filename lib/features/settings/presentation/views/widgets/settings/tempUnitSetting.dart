import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riwaa/core/components/customSwitch.dart';
import 'package:riwaa/core/components/settingSection.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appCache.dart';
import 'package:riwaa/core/utilities/appStyles.dart';

class TempUnitSetting extends StatefulWidget {
  const TempUnitSetting({super.key});

  @override
  State<TempUnitSetting> createState() => _TempUnitSettingState();
}

class _TempUnitSettingState extends State<TempUnitSetting> {
  
  bool? isCelsius;
  
  @override
  void initState() {
    super.initState();
    _loadTempUnit();
  }
  
  Future<void> _loadTempUnit() async {
    final tempUnit = await AppCache.getTempUnit();
    setState(() {
      isCelsius = tempUnit == 'c';
    });
  }

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
          isCelsius != null ? CustomToggleSwitch(
            optionOne: '°F', 
            optionTwo: '°C', 
            initialValue: isCelsius!,
            onChanged: (val) async{
              val == true ? AppCache.setTempUnit('c') : AppCache.setTempUnit('f');
            }
          ) : const SizedBox()
        ],
      ),
    );
  }
}