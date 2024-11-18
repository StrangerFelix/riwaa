import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/splash/presentation/views/splashView.dart';

abstract class AppRouter {
  static String home = '/home';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
    ],
  );
}

CustomTransitionPage pagesTransitionBuilder(
    {required Widget child, Duration duration = kNavigationDuration}) {
  return CustomTransitionPage(
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      });
}
