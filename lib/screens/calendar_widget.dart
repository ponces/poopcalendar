import 'package:flutter/material.dart';

class CalendarWidget extends StatelessWidget {
  CalendarWidget(this.isCozinho);

  final bool isCozinho;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Center(),
    );
  }
}
