import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/components/logoBuilder.dart';
import 'package:riwaa/core/utilities/appRouter.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/core/components/copyrightText.dart';
import 'package:riwaa/core/utilities/firebaseService.dart';
import 'package:riwaa/core/utilities/serviceLocator.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _fadeSlide1Controller;
  late AnimationController _fade2Controller;
  late AnimationController _fadeSlide3Controller;

  late Animation<double> _fade1;
  late Animation<Offset> _slide1;
  late Animation<double> _fade2;
  late Animation<double> _fade3;
  late Animation<Offset> _slide3;

  @override
  void initState() {
    super.initState();
    initAnimationControllers();
    _fadeSlide3Controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        splashEnding();
      }
    });
    _startSequence();
  }

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
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _fade3,
                  child: SlideTransition(
                    position: _slide3,
                    child: const LogoBuilder(),
                  ),
                ),
                
                const SizedBox(width: 5,),
                FadeTransition(
                  opacity: _fade2,
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 3,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.8),
                      boxShadow: AppStyles.mainBoxShadows,
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                FadeTransition(
                  opacity: _fade1,
                  child: SlideTransition(
                    position: _slide1,
                    child: Text(
                      'رِواء',
                      style: AppStyles.titleLarge.copyWith(
                        shadows: AppStyles.mainTextShadows,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
                

              ],
            ),

            // ),
            const Spacer(),
            const CopyrightText(isSplash: true,),
            const SizedBox(height: 40,),
          ],
        )
      ),
    );
  }
  void initAnimationControllers () {
    _fadeSlide1Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slide1 = Tween<Offset>(begin: const Offset(2, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _fadeSlide1Controller, curve: Curves.easeOut));
    _fade1 = Tween<double>(begin: 0, end: 1).animate(_fadeSlide1Controller);

    _fade2Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fade2 = Tween<double>(begin: 0, end: 1).animate(_fade2Controller);

    _fadeSlide3Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fade3 = Tween<double>(begin: 0, end: 1).animate(_fadeSlide3Controller);
    _slide3 = Tween<Offset>(begin: const Offset(2, 0), end: Offset.zero)
      .animate(CurvedAnimation(parent: _fadeSlide3Controller, curve: Curves.easeOut)
    );
  }
  Future<void> _startSequence() async {
    await _fadeSlide1Controller.forward();
    await _fade2Controller.forward();
    await _fadeSlide3Controller.forward();
  }
  @override
  void dispose() {
    _fadeSlide1Controller.dispose();
    _fade2Controller.dispose();
    _fadeSlide3Controller.dispose();
    super.dispose();
  }

  void splashEnding() {
    final user = getIt.get<FirebaseService>().firebaseAuth.currentUser;
    Future.delayed(const Duration(milliseconds: 1000), () {
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