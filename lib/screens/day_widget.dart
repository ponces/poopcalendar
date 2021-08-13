import 'package:flutter/material.dart';
import 'package:poopcalendar/screens/today_widget.dart';
import 'package:poopcalendar/utils/json_parser.dart';

class DayWidget extends StatefulWidget {
  final DateTime date;
  final List<dynamic> calendar;
  final bool isCozinho;

  DayWidget({
    Key? key,
    required this.date,
    required this.calendar,
    required this.isCozinho,
  }) : super(key: key);

  @override
  _DayWidgetState createState() => _DayWidgetState();
}

class _DayWidgetState extends State<DayWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getDayName(context, widget.date)),
      ),
      body: TodayWidget(widget.date, widget.calendar, widget.isCozinho),
    );
  }
}
