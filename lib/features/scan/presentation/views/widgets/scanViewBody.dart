import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';

class ScanViewBody extends StatelessWidget {
  const ScanViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
          child: Container(
            color: kPrimaryColor,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: Text(
                  'Comming Soon...',
                  style: AppStyles.titleLarge.copyWith(
                    color: Colors.white,
                    shadows: AppStyles.mainTextShadows,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          )
        ),
        Column(
          children: [
            SizedBox(
              height: MediaQuery.paddingOf(context).top,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: IconButton(
                  onPressed: () => context.pop(), 
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                ),
              )
            ),
          ],
        ),
        
      ],
    );
  }
}