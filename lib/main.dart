import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:load/load.dart';
import 'package:mobile_app/localization/jp-localization.dart';
import 'package:mobile_app/ui/pages/authorization/loading/loading.dart';

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new DevHttpOverrides();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        return LoadingProvider(
          themeData: LoadingThemeData(tapDismiss: false),
          child: widget,
          loadingWidgetBuilder: (context, data) {
            return Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: Container(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            );
          },
        );
      },
      locale: _locale,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
      localizationsDelegates: [
        JPLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale.languageCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      home: LoadingPage(),
    );
  }
}
