import 'package:flutter/material.dart';
import 'package:riwaa/features/logs/presentation/views/widgets/logsHeader.dart';
import 'package:riwaa/features/logs/presentation/views/widgets/logsList.dart';

class LogsViewBody extends StatelessWidget {
  const LogsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LogsHeader(),
        SizedBox(height: 20),
        LogsList(),
      ],
    );
  }
}