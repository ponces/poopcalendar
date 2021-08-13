import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsWidget extends StatefulWidget {
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

enum AppTheme {
  FollowSystem,
  Light,
  Dark,
}

enum Language {
  FollowSystem,
  English,
  Portuguese,
}

enum CalendarType {
  Cozinho,
  Cozinha,
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: I18nText('settingsWidget.widgetTitle'),
      ),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          AppTheme appTheme = AppTheme.FollowSystem;
          Language language = Language.FollowSystem;
          CalendarType calendarType = CalendarType.Cozinho;
          if (snapshot.hasData) {
            appTheme = AppTheme.values[snapshot.data!.getInt('appTheme') ??
                AppTheme.FollowSystem.index];
            language = Language.values[snapshot.data!.getInt('language') ??
                Language.FollowSystem.index];
            calendarType = CalendarType.values[
                snapshot.data!.getInt('calendarType') ??
                    CalendarType.Cozinho.index];
          }
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: I18nText('settingsWidget.appearanceSectionTitle'),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: I18nText('settingsWidget.appThemeSettings'),
                    subtitle: _getAppThemeWidget(appTheme),
                    onTap: () => _showAppThemeDialog(snapshot.data, appTheme),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: I18nText('settingsWidget.languageSettings'),
                    subtitle: _getLanguageWidget(language),
                    onTap: () => _showLanguageDialog(snapshot.data, language),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: I18nText('settingsWidget.basicsSectionTitle'),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: I18nText('settingsWidget.calendarSettings'),
                    subtitle: _getCalendarTypeWidget(calendarType),
                    onTap: () => _showCalendarTypeDialog(
                      snapshot.data,
                      calendarType,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showAppThemeDialog(
    SharedPreferences? prefs,
    AppTheme appTheme,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
        title: I18nText('settingsWidget.appThemeSettings'),
        children: <Widget>[
          RadioListTile<AppTheme>(
            value: AppTheme.FollowSystem,
            groupValue: appTheme,
            onChanged: (value) => _updateAppTheme(prefs!, value!),
            title: _getAppThemeWidget(AppTheme.FollowSystem),
          ),
          RadioListTile<AppTheme>(
            value: AppTheme.Light,
            groupValue: appTheme,
            onChanged: (value) => _updateAppTheme(prefs!, value!),
            title: _getAppThemeWidget(AppTheme.Light),
          ),
          RadioListTile<AppTheme>(
            value: AppTheme.Dark,
            groupValue: appTheme,
            onChanged: (value) => _updateAppTheme(prefs!, value!),
            title: _getAppThemeWidget(AppTheme.Dark),
          ),
        ],
      ),
    );
  }

  Future<void> _showLanguageDialog(
    SharedPreferences? prefs,
    Language language,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
        title: I18nText('settingsWidget.languageSettings'),
        children: <Widget>[
          RadioListTile<Language>(
            value: Language.FollowSystem,
            groupValue: language,
            onChanged: (value) => _updateLanguage(prefs!, value!),
            title: _getLanguageWidget(Language.FollowSystem),
          ),
          RadioListTile<Language>(
            value: Language.English,
            groupValue: language,
            onChanged: (value) => _updateLanguage(prefs!, value!),
            title: _getLanguageWidget(Language.English),
          ),
          RadioListTile<Language>(
            value: Language.Portuguese,
            groupValue: language,
            onChanged: (value) => _updateLanguage(prefs!, value!),
            title: _getLanguageWidget(Language.Portuguese),
          ),
        ],
      ),
    );
  }

  Future<void> _showCalendarTypeDialog(
    SharedPreferences? prefs,
    CalendarType calendarType,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
        title: I18nText('settingsWidget.calendarSettings'),
        children: <Widget>[
          RadioListTile<CalendarType>(
            value: CalendarType.Cozinho,
            groupValue: calendarType,
            onChanged: (value) => _updateCalendarType(prefs!, value!),
            title: _getCalendarTypeWidget(CalendarType.Cozinho),
          ),
          RadioListTile<CalendarType>(
            value: CalendarType.Cozinha,
            groupValue: calendarType,
            onChanged: (value) => _updateCalendarType(prefs!, value!),
            title: _getCalendarTypeWidget(CalendarType.Cozinha),
          ),
        ],
      ),
    );
  }

  Widget _getAppThemeWidget(AppTheme appTheme) {
    I18nText widget;
    switch (appTheme) {
      case AppTheme.Light:
        widget = I18nText('settingsWidget.optionLight');
        break;
      case AppTheme.Dark:
        widget = I18nText('settingsWidget.optionDark');
        break;
      default:
        widget = I18nText('settingsWidget.optionFollowSystem');
        break;
    }
    return widget;
  }

  Widget _getLanguageWidget(Language language) {
    I18nText widget;
    switch (language) {
      case Language.English:
        widget = I18nText('settingsWidget.optionEnglish');
        break;
      case Language.Portuguese:
        widget = I18nText('settingsWidget.optionPortuguese');
        break;
      default:
        widget = I18nText('settingsWidget.optionFollowSystem');
        break;
    }
    return widget;
  }

  Widget _getCalendarTypeWidget(CalendarType calendarType) {
    I18nText widget;
    switch (calendarType) {
      case CalendarType.Cozinha:
        widget = I18nText('settingsWidget.optionCozinha');
        break;
      default:
        widget = I18nText('settingsWidget.optionCozinho');
        break;
    }
    return widget;
  }

  Future<void> _updateAppTheme(SharedPreferences prefs, AppTheme value) async {
    Navigator.of(context).pop();
    await prefs.setInt('appTheme', value.index);
    setState(() {});
    switch (value) {
      case AppTheme.Light:
        DynamicTheme.of(context)!.setTheme(0);
        break;
      case AppTheme.Dark:
        DynamicTheme.of(context)!.setTheme(1);
        break;
      default:
        if (MediaQuery.of(context).platformBrightness == Brightness.light) {
          DynamicTheme.of(context)!.setTheme(0);
        } else {
          DynamicTheme.of(context)!.setTheme(1);
        }
        break;
    }
  }

  Future<void> _updateLanguage(SharedPreferences prefs, Language value) async {
    Navigator.of(context).pop();
    await prefs.setInt('language', value.index);
    setState(() {});
    switch (value) {
      case Language.English:
        await FlutterI18n.refresh(
          context,
          Locale('en'),
        );
        break;
      case Language.Portuguese:
        await FlutterI18n.refresh(
          context,
          Locale('pt'),
        );
        break;
      default:
        await FlutterI18n.refresh(
          context,
          Localizations.localeOf(context),
        );
        break;
    }
  }

  Future<void> _updateCalendarType(
    SharedPreferences prefs,
    CalendarType value,
  ) async {
    Navigator.of(context).pop();
    await prefs.setInt('calendarType', value.index);
    Phoenix.rebirth(context);
  }
}
