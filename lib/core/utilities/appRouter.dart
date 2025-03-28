import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/auth/presentation/views/loginView.dart';
import 'package:riwaa/features/auth/presentation/views/registerView.dart';
import 'package:riwaa/features/home/data/models/homeModel.dart';
import 'package:riwaa/features/home/presentation/views/addPlantScanView.dart';
import 'package:riwaa/features/home/presentation/views/addPlantView.dart';
import 'package:riwaa/features/home/presentation/views/editPlantDetailsView.dart';
import 'package:riwaa/features/home/presentation/views/homeView.dart';
import 'package:riwaa/features/home/presentation/views/plantDetailsView.dart';
import 'package:riwaa/features/home/presentation/views/widgets/home/homeViewBody.dart';
import 'package:riwaa/features/logs/presentation/views/logsViewBody.dart';
import 'package:riwaa/features/notifications/presentation/views/notificationsViewBody.dart';
import 'package:riwaa/features/scan/presentation/views/ScanView.dart';
import 'package:riwaa/features/settings/presentation/views/editProfileView.dart';
import 'package:riwaa/features/settings/presentation/views/settingsViewBody.dart';
import 'package:riwaa/features/splash/presentation/views/splashView.dart';

abstract class AppRouter {
  static String home = '/home';
  static String login = '/login';
  static String register = '/register';
  static String logs = '/logs';
  static String notifications = '/notifications';
  static String settings = '/settings';
  static String scan = '/scan';
  static String editProfile = '/editProfile';
  static String addPlantScan = '/addPlantScan';
  static String addPlant = '/addPlant';
  static String plantDetails = '/plantDetails';
  static String editPlantDetails = '/editPlantDetails';
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
          transitionDuration: kNavigationDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          }
        ),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: editProfile,
        builder: (context, state) => const EditProfileView(),
      ),
      GoRoute(
        path: editPlantDetails,
        builder: (context, state) {
          final extra = state.extra as Plant;
          return EditPlantDetailsView(plant: extra);
        } 
      ),
      GoRoute(
        path: addPlant,
        builder: (context, state) {
          String hash = state.extra as String;
          return AddPlantView(hash: hash);
        } 
      ),
      GoRoute(
        path: addPlantScan,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: kNavigationDuration,
          child: const AddPlantScanView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          }
        ),
      ),
      GoRoute(
        path: plantDetails,
        pageBuilder: (context, state) {
          Plant plant = state.extra as Plant;
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: kNavigationDuration,
            child: PlantDetailsView(plant: plant,),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            }
          );
        } 
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
