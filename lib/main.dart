import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/core/utilities/appRouter.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:riwaa/core/utilities/serviceLocator.dart';
import 'package:riwaa/features/auth/data/repository/authRepo.dart';
import 'package:riwaa/features/auth/presentation/manager/authCubit.dart';
import 'package:riwaa/firebase_options.dart';
// import 'package:riwaa/core/utilities/firebaseNotifications.dart';

void main () async{
  // debugRepaintRainbowEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupServiceLocator();
  // FirebaseNotificationService firebaseNotificationService = FirebaseNotificationService();
  // await firebaseNotificationService.initializeFirebase();
  
  runApp(const RiwaaApp());
}

class RiwaaApp extends StatelessWidget {
  const RiwaaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(getIt.get<AuthRepository>())),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        darkTheme: AppStyles.darkTheme,
        theme: AppStyles.lightTheme,
        themeMode: ThemeMode.light,
        localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ar')], 
      ),
    );
  }
}
