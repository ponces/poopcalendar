import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

Future<List> readJson(bool isCozinho) async {
  String data = await rootBundle.loadString('assets/data/calendars.json');
  Map calendars = await jsonDecode(data)['calendars'];
  return isCozinho ? calendars['cozinho'] : calendars['cozinha'];
}

String getTodayDescription(List<dynamic> calendar) {
  String today = DateFormat('MM-dd').format(DateTime.now());
  return calendar.firstWhere(
    (element) => element['date'] == today,
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

String getDayDate(List<dynamic> calendar, int index, String locale) {
  String input = calendar[index]['date'];
  DateTime datetime = DateTime.parse('2017' + input.replaceAll('-', ''));
  String output = DateFormat.MMMMd(locale).format(datetime);
  return output;
}
