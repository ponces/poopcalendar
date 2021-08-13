import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:poopcalendar/screens/calendar_widget.dart';
import 'package:poopcalendar/screens/cards_widget.dart';
import 'package:poopcalendar/screens/settings_widget.dart';
import 'package:poopcalendar/screens/today_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeWidget extends StatefulWidget {
  final List<dynamic> calendar;
  final bool isCozinho;

  HomeWidget({
    Key? key,
    required this.calendar,
    required this.isCozinho,
  }) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _currentTab = 0;
  List<Widget> _tabs = List.empty();

  @override
  void initState() {
    super.initState();
    _applyAppSettings();
    _tabs = [
      TodayWidget(DateTime.now(), widget.calendar, widget.isCozinho),
      CalendarWidget(widget.calendar, widget.isCozinho),
      CardsWidget(widget.calendar),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: I18nText('homeWidget.widgetTitle'),
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => _handleClick(item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: I18nText('homeWidget.optionSettings'),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: I18nText('homeWidget.optionAbout'),
              ),
            ],
          ),
        ],
      ),
      body: _tabs[_currentTab],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabTapped,
        currentIndex: _currentTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: FlutterI18n.translate(context, 'homeWidget.todayWidget'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: FlutterI18n.translate(context, 'homeWidget.calendarWidget'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_agenda),
            label: FlutterI18n.translate(context, 'homeWidget.cardsWidget'),
          )
        ],
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() => _currentTab = index);
  }

  Future<void> _handleClick(int item) async {
    if (item == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SettingsWidget(),
        ),
      );
    } else {
      _showAboutDialog();
    }
  }

  Future<void> _showAboutDialog() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return showAboutDialog(
      context: context,
      applicationIcon: Container(
        child: Image(
          image: AssetImage(
            'assets/images/icon-192x192.png',
          ),
          fit: BoxFit.cover,
        ),
        height: 65,
        width: 65,
      ),
      applicationName: 'Poop Calendar',
      applicationVersion: packageInfo.version,
      applicationLegalese:
          '\u{00a9} ' + DateFormat('yyyy').format(DateTime.now()) + ' ponces',
      children: <Widget>[
        SizedBox(height: 20),
        I18nText(
          'homeWidget.aboutDialogText',
          child: Text(
            '',
            textAlign: TextAlign.center,
          ),
        ),
        GestureDetector(
          child: Text(
            'Alberto Ponces',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Theme.of(context).accentColor,
            ),
            textAlign: TextAlign.center,
          ),
          onTap: () => launch('https://github.com/ponces'),
        ),
        GestureDetector(
          child: Text(
            'ponces26@gmail.com',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Theme.of(context).accentColor,
            ),
            textAlign: TextAlign.center,
          ),
          onTap: () => launch('mailto:ponces26@gmail.com'),
        ),
      ],
    );
  }

  Future<void> _applyAppSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AppTheme appTheme = AppTheme
        .values[prefs.getInt('appTheme') ?? AppTheme.FollowSystem.index];
    switch (appTheme) {
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
    Language language = Language
        .values[prefs.getInt('language') ?? Language.FollowSystem.index];
    switch (language) {
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
}
