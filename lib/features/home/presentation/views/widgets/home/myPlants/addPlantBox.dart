import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/utilities/appRouter.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';

class AddPlantBox extends StatelessWidget{
  const AddPlantBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.addPlantScan);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: kContainerBorderRadius,
          boxShadow: AppStyles.mainBoxShadows,
        ),
        child: const Center(
          child: CircleAvatar(
            backgroundColor: kPrimaryColor,
            radius: 35,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 40,
            ),
          ),
        )
      ),
    );
  }
}