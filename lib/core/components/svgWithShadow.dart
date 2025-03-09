import 'dart:ui';
import 'package:flutter/material.dart';

class SvgWithShadow extends StatelessWidget {
  const SvgWithShadow({required this.child,super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform.translate(
          offset: const Offset(0, 2),
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
              child: Opacity(
                opacity: 0.25,
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcATop),
                  child: child,
                ),
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}