import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/components/dialog.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/home/presentation/views/widgets/plantDetails/plantDetailsViewBody.dart';

class PlantDetailsView extends StatelessWidget {
  const PlantDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainBackgroundColor,
        elevation: 0.0,
        title: const Text('تفاصيل النبتة'),
        leading: IconButton(
          onPressed: () => GoRouter.of(context).pop(), 
          icon: const Icon(Icons.close_rounded)
        ),
        actions: [
          IconButton(
            onPressed: () {
              myDialog(
                context, 
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
          ),
        ],
      ),
      body: const PlantDetailsViewBody(),
    );
  }
}