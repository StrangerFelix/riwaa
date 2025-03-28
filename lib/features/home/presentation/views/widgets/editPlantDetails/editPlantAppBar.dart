import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';

class EditPlantAppBar extends StatelessWidget {
  const EditPlantAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.paddingOf(context).top,
          color: kMainBackgroundColor.withValues(alpha: 0.6),
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: kMainBackgroundColor.withValues(alpha: 0.6),
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'تعديل على النبتة',
                  style: AppStyles.bodyMedium,
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: IconButton(
                  onPressed: () => context.pop(), 
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}