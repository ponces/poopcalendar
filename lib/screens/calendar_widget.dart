import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:poopcalendar/screens/day_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  CalendarWidget(this.calendar, this.isCozinho);

  final List<dynamic> calendar;
  final bool isCozinho;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: TableCalendar(
          firstDay: DateTime.utc(DateTime.now().year, 1, 1),
          lastDay: DateTime.utc(DateTime.now().year, 12, 31),
          focusedDay: DateTime.now(),
          startingDayOfWeek: StartingDayOfWeek.monday,
          locale: FlutterI18n.currentLocale(context)!.languageCode,
          weekendDays: [],
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
          ),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              shape: BoxShape.circle,
            ),
          ),
          onDaySelected: (selectedDay, focusedDay) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DayWidget(
                date: selectedDay,
                calendar: this.calendar,
                isCozinho: this.isCozinho,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
