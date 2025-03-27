import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/components/logoBuilder.dart';
import 'package:riwaa/core/utilities/appRouter.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/core/components/copyrightText.dart';
import 'package:riwaa/core/utilities/firebaseService.dart';
import 'package:riwaa/core/utilities/serviceLocator.dart';
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
      
      backgroundColor: kSplashBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const SizedBox(height: 50,),
            const LogoBuilder(),
            const SizedBox(height: 10,),
            AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? child) {
                return SlideTransition(
                  position: animation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: Text(
                      splashQuotes[randomIndex],
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                        // height: 1.75,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        shadows: AppStyles.mainTextShadows
                      ),
                    ),
                  )
                );
              },
            ),
            const Spacer(),
            const CopyrightText(isSplash: true,),
            const SizedBox(height: 40,),
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
    final user = getIt.get<FirebaseService>().firebaseAuth.currentUser;
    Future.delayed(const Duration(milliseconds: 2300), () {
      if (user != null) {        
        // ignore: use_build_context_synchronously
        GoRouter.of(context).pushReplacement(AppRouter.home);
      } else {
        // ignore: use_build_context_synchronously
        GoRouter.of(context).pushReplacement(AppRouter.login);
        
      }
    });
  }
}