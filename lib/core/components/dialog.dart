import 'package:flutter/material.dart';
import 'package:riwaa/core/components/mainButton.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';

void myDialog (BuildContext context,{bool useRootNavigator = true,double? height,required Widget child}) {
  showDialog(
    useRootNavigator: useRootNavigator,
    context: context, 
    builder: (context) {
      return Dialog(
        child: IntrinsicHeight(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kMainBackgroundColor,
            ),
            child: child,
          ),
        ),
      );
    }
  );
}

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({super.key,this.height,this.isDisabled = false,required this.titleAlert,required this.bodyAlert,required this.onTap});
  final double? height;
  final String titleAlert;
  final String bodyAlert;
  final bool isDisabled;
  // String actionOneLabel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kMainBackgroundColor,
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  titleAlert,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              
              Text(
                bodyAlert,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Row(
        
                  children: [
                    Expanded(
                      child: MainButton(
                        onTap: onTap,
                        color: isDisabled ? Colors.grey :Colors.red,
                        child: Center(
                          child: Text(
                            'نعم',
                            style: AppStyles.title18.copyWith(
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: MainButton(
                        onTap: () => Navigator.pop(context),
                        color: Colors.grey,
                        child: Center(
                          child: Text(
                            'لا',
                            style: AppStyles.title18.copyWith(
                              color: Colors.white
                            ),
                          )
                        )
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
