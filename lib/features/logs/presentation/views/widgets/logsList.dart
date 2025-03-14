import 'package:flutter/material.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/logs/presentation/views/widgets/logsItem.dart';

class LogsList extends StatelessWidget {
  const LogsList({super.key});

  @override
  Widget build(BuildContext context) {
    int count = 20;
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: count,
        physics: const AlwaysScrollableScrollPhysics(),
        primary: true, 
        itemBuilder: (context, index) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: kHorizontalPadding,
                  vertical: 8,
                ),
                child: LogsItem(),
              ),
              SizedBox(height: index == count - 1? 80 : 0),
            ],
          );
        },
      ),
    );
  }
}