import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

Future<List> readJson(bool isCozinho) async {
  String data = await rootBundle.loadString('assets/data/calendars.json');
  Map calendars = await jsonDecode(data)['calendars'];
  return isCozinho ? calendars['cozinho'] : calendars['cozinha'];
}

String getDateDescription(List<dynamic> calendar, DateTime date) {
  String day = DateFormat('MM-dd').format(date);
  return calendar.firstWhere(
    (element) => element['date'] == day,
    orElse: () => '',
  )['description'];
}

String getDayDescription(List<dynamic> calendar, int index) {
  String description = calendar[index]['description'];
  String heart = calendar[index]['heart'];
  if (heart.isNotEmpty) {
    description = 'Dás beijinhos ' + description + ' ' + heart;
  }
  return description;
}

String getDayDate(BuildContext context, List<dynamic> calendar, int index) {
  String date = calendar[index]['date'];
  DateTime datetime = DateTime.parse('2017' + date.replaceAll('-', ''));
  return getDayName(context, datetime);
}

String getDayName(BuildContext context, DateTime date) {
  String locale = FlutterI18n.currentLocale(context)!.languageCode;
  return DateFormat.MMMMd(locale).format(date);
}
