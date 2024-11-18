import 'package:flutter/material.dart';
import 'package:riwaa/core/utilities/appRouter.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main () {
  runApp(const RiwaaApp());
}

class RiwaaApp extends StatelessWidget {
  const RiwaaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
    );
  }
}