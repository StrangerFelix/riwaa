import 'package:flutter/material.dart';
import 'package:riwaa/core/utilities/constants.dart';

class MainButton extends StatelessWidget {
  const MainButton({required this.child,required this.onTap,super.key});
  final void Function()? onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          color: kPrimaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .25),
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: child,
        ),
      ),
    );
  }
}