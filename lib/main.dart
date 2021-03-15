import 'package:ecommerce/screens/LandingPage.dart';
import 'package:ecommerce/screens/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';


void main() {
  runApp(EasyLocalization(child: MyApp(),path: "assets/langs",saveLocale: true,supportedLocales: [Locale('en', 'US'), Locale('hi', 'IN'),  Locale('ta', 'IN')],));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        accentColor: Color(0xFFFF1E00)
      ),
      home: LandingPage(),
    );
  }
}

