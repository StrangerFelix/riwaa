import 'package:flutter/material.dart';
import 'package:riwaa/core/utilities/constants.dart';

class MainButton extends StatelessWidget {
  const MainButton({required this.child,this.borderRadius = 12.0,this.color = kPrimaryColor,required this.onTap,super.key});
  final void Function()? onTap;
  final Widget child;
  final Color color;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          color: color,
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