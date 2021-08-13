import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:poopcalendar/utils/json_parser.dart';

class CardsWidget extends StatelessWidget {
  CardsWidget(this.calendar, this.isCozinho);

  final List<dynamic> calendar;
  final bool isCozinho;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40.0),
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
                          calendar,
                          i,
                          FlutterI18n.currentLocale(context)!.languageCode,
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
