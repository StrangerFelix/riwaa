import 'package:flutter/material.dart';
import 'package:riwaa/features/notifications/presentation/views/widgets/notificationsHeader.dart';
import 'package:riwaa/features/notifications/presentation/views/widgets/notificationsList.dart';

class NotificationsViewBody extends StatelessWidget {
  const NotificationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NotificationsHeader(),
        SizedBox(height: 20),
        NotificationsList(),
      ],
    );
  }
}