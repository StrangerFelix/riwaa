import 'package:flutter/material.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: kContainerBorderRadius,
        boxShadow: AppStyles.mainBoxShadows
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[200],
            ),
          ),
          const Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'عنوان الاشعار',
                  style: AppStyles.bodyMedium,
                ),
                SizedBox(height: 10),
                Text(
                  'وصف الاشعار',
                  style: AppStyles.paragraphSmall,
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}