import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'MainHome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
//    HexColor('FFFBED').withOpacity(0.5)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: MainHome(),
      title: "contact",
      theme: ThemeData(
        // primarySwatch: HexColor('FFFBED'),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fa'), // English, no country code
      ],
    );
  }
}

