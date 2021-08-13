import 'package:flutter/material.dart';
import 'package:poopcalendar/utils/json_parser.dart';

class CardsWidget extends StatelessWidget {
  CardsWidget(this.calendar);

  final List<dynamic> calendar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: ListView.builder(
          itemCount: calendar.length,
          itemBuilder: (context, i) {
            return Card(
              elevation: 8.0,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        getDayDate(
                          context,
                          calendar,
                          i,
                        ),
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        getDayDescription(calendar, i),
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
