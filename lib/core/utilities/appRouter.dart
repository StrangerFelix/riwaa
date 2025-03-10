import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/home/presentation/views/homeView.dart';
import 'package:riwaa/features/home/presentation/views/widgets/homeViewBody.dart';
import 'package:riwaa/features/logs/presentation/views/logsViewBody.dart';
import 'package:riwaa/features/notifications/presentation/views/notificationsViewBody.dart';
import 'package:riwaa/features/scan/presentation/views/ScanView.dart';
import 'package:riwaa/features/settings/presentation/views/settingsViewBody.dart';
import 'package:riwaa/features/splash/presentation/views/splashView.dart';

abstract class AppRouter {
  static String home = '/home';
  static String logs = '/logs';
  static String notifications = '/notifications';
  static String settings = '/settings';
  static String scan = '/scan';
  static final _rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final router = GoRouter(
    navigatorKey: _rootNavigationKey,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: scan,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ScanView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          }
        ),
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: HomeView(navigationShell: navigationShell),
            transitionDuration: kSplashToHomeTransitionDuration,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            }
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: home,
                builder: (context, state) => const HomeViewBody(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: logs,
                builder: (context, state) => const LogsViewBody(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: notifications,
                builder: (context, state) => const NotificationsViewBody(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: settings,
                builder: (context, state) => const SettingsViewBody(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

// CustomTransitionPage pagesTransitionBuilder(
//     {required Widget child, Duration duration = kNavigationDuration}) {
//   return CustomTransitionPage(
//       child: child,
//       transitionDuration: duration,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return FadeTransition(
//           opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
//           child: child,
//         );
//       });
// }
