import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertest/generated/l10n.dart';
import 'package:fluttertest/l10n/l10n.dart';
import 'package:fluttertest/flutter_app/login.dart';

void main() {
 runApp(MyApp());
}

class MyApp extends StatefulWidget {
 static void setLocale(BuildContext context, Locale locale) {
  _MyAppState? state =
  context.findAncestorStateOfType<_MyAppState>();
  state?.setLocale(locale);
 }

 @override
 State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 Locale _locale = const Locale('en');

 void setLocale(Locale locale) {
  setState(() => _locale = locale);
 }

 @override
 Widget build(BuildContext context) {
  return MaterialApp(
   locale: _locale,
   debugShowCheckedModeBanner: false,

   supportedLocales: L10n.all,

   localizationsDelegates: const [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
   ],

   home: LoginPage(),
  );
 }
}