import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:poopcalendar/utils/json_parser.dart';

class TodayWidget extends StatelessWidget {
  TodayWidget(this.calendar, this.isCozinho);

  final List<dynamic> calendar;
  final bool isCozinho;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Bubble(
              alignment: Alignment.topRight,
              padding: BubbleEdges.all(20),
              nip: BubbleNip.leftBottom,
              color: Colors.brown,
              child: Text(
                FlutterI18n.translate(context, 'todayWidget.mainBubble'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 80.0,
                  child: Image.asset(
                    isCozinho
                        ? 'assets/images/avatar_cozinho.png'
                        : 'assets/images/avatar_cozinha.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Bubble(
              alignment: Alignment.topLeft,
              padding: BubbleEdges.all(20),
              nip: BubbleNip.rightBottom,
              color: Colors.brown,
              child: Text(
                getTodayDescription(this.calendar),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 80.0,
                  child: Image.asset(
                    isCozinho
                        ? 'assets/images/avatar_cozinho.png'
                        : 'assets/images/avatar_cozinha.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
