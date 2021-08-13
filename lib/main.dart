import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:poopcalendar/screens/home_widget.dart';
import 'package:poopcalendar/screens/settings_widget.dart';
import 'package:poopcalendar/utils/json_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(
    Phoenix(
      child: DynamicTheme(
        themeCollection: ThemeCollection(
          themes: {
            0: ThemeData(
              primarySwatch: Colors.brown,
              brightness: Brightness.light,
            ),
            1: ThemeData(
              primarySwatch: Colors.brown,
              accentColor: Colors.brown,
              toggleableActiveColor: Colors.brown,
              brightness: Brightness.dark,
            ),
          },
          fallbackTheme: ThemeData(
            primarySwatch: Colors.brown,
            brightness: Brightness.light,
          ),
        ),
        builder: (context, theme) => MaterialApp(
          title: 'Poop Calendar',
          theme: theme,
          home: SplashScreen(
            navigateAfterFuture: _init(context),
            image: Image.asset('assets/images/icon-512x512.png'),
            backgroundColor: theme.canvasColor,
            photoSize: 80.0,
            useLoader: false,
            title: Text(''),
            loadingText: Text(''),
            loadingTextPadding: EdgeInsets.zero,
            styleTextUnderTheLoader: TextStyle(),
          ),
          localizationsDelegates: [
            FlutterI18nDelegate(
              translationLoader: FileTranslationLoader(
                fallbackFile: 'pt',
                basePath: 'assets/i18n',
              ),
            ),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
        ),
      ),
    ),
  );
}

Future<Widget> _init(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  CalendarType calendarType = CalendarType
      .values[prefs.getInt('calendarType') ?? CalendarType.Cozinho.index];
  bool isCozinho = calendarType == CalendarType.Cozinho;
  List<dynamic> calendar = await readJson(isCozinho);
  return HomeWidget(calendar: calendar, isCozinho: isCozinho);
}
