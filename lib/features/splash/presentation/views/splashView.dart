import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/components/logoBuilder.dart';
import 'package:riwaa/core/utilities/appRouter.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/splash/data/splashQuotes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
   late Animation<Offset> animation;
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    splashEnding();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  int randomIndex = Random().nextInt(splashQuotes.length);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15,),
            const LogoBuilder(),
            const SizedBox(height: 15,),
            AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? child) {
                return SlideTransition(
                  position: animation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Text(
                      splashQuotes[randomIndex],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        height: 1.75,
                        fontSize: 16,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  )
                );
              },
            )
          ],
        )
      ),
    );
  }
  void initSlidingAnimation() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    animation = Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero)
        .animate(animationController);
    animationController.forward();
  }

  void splashEnding() {
    Future.delayed(const Duration(milliseconds: 1800), () {
      // ignore: use_build_context_synchronously
      GoRouter.of(context).pushReplacement(AppRouter.home);
    });
  }
}