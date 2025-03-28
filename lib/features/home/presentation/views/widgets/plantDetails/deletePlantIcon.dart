import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/components/dialog.dart';
import 'package:riwaa/core/utilities/appAssets.dart';

class DeletePlantIcon extends StatelessWidget {
  const DeletePlantIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        myDialog(context,
          height: 200,
          child: MyAlertDialog(
            titleAlert: 'هل انت متاكد من حذف النبتة؟',
            bodyAlert: 'حذف النبتة سيحذف جميع البيانات المتعلقة بها',
            onTap: () {
              GoRouter.of(context).pop();
              GoRouter.of(context).pop();
            }    
          )
        );
      },
      icon: SvgPicture.asset(
        AppAssets.delete,
        width: 25,
      )
    );
  }
}