import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riwaa/core/utilities/appCache.dart';
import 'package:riwaa/core/utilities/appRouter.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:riwaa/core/utilities/bloc_observer.dart';
import 'package:riwaa/core/utilities/providers.dart';
import 'package:riwaa/core/utilities/serviceLocator.dart';
import 'package:riwaa/firebase_options.dart';
import 'package:timeago/timeago.dart' as timeago;

void main () async{
  // debugRepaintRainbowEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await AppCache.init();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupServiceLocator();
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // For Android
      statusBarBrightness: Brightness.light,    // For iOS
    ),
  );
  // FirebaseNotificationService firebaseNotificationService = FirebaseNotificationService();
  // await firebaseNotificationService.initializeFirebase();
  
  runApp(const RiwaaApp());
}

class RiwaaApp extends StatelessWidget {
  const RiwaaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers, 
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
