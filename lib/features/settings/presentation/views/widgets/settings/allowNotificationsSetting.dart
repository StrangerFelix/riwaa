import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riwaa/core/components/settingSection.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appStyles.dart';

class AllowNotificationsSetting extends StatefulWidget {
  const AllowNotificationsSetting({super.key});

  @override
  State<AllowNotificationsSetting> createState() => _AllowNotificationsSettingState();
}

class _AllowNotificationsSettingState extends State<AllowNotificationsSetting> {
  bool isNotificationsAllowed = true;
  @override
  Widget build(BuildContext context) {
    return SettingSection(
      child: Row(
        children: [
          SvgPicture.asset(AppAssets.notifications),
          const SizedBox(width: 15),
          const Text(
            'تفعيل الاشعارات',
            style: AppStyles.paragraphMedium,
          ),
          const Spacer(),
          CupertinoSwitch(
            value: isNotificationsAllowed, 
            onChanged: (val) {
              setState(() {
                isNotificationsAllowed = val;
              });
            }
          ),
        ],
      ),
    );
  }
}