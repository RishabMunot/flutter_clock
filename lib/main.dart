import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlutterClock(),
    );
  }
}

class FlutterClock extends StatefulWidget {
  @override
  _FlutterClockState createState() => _FlutterClockState();
}

class _FlutterClockState extends State<FlutterClock> {
  DateTime _now = DateTime.now();
  double angle = 0;
  double angleMinute = 0;
  double angleHour = 0;
  int prevSec = 0;
  int sec = 0;
  int mill = 0;
  int preHour = 0;
  int nowHour = 0;

  @override
  void initState() {
    Timer.periodic(Duration(milliseconds: 105), (v) {
      setState(() {
        _now = DateTime.now();

//Calculating Degree for seconds
        int sec = _now.second;
        if (_now.second != prevSec) mill = _now.millisecond;
        angle = double.parse(_now.second.toString() +
                '.' +
                (_now.millisecond - mill).toString()) *
            pi /
            30;
        prevSec = _now.second;
//Calculating degree for mintues
        angleMinute = (_now.second + _now.minute * 60) / 10 * pi / 180;

//Caluculating degree for hour
        nowHour = _now.hour;
        if (nowHour != preHour) {
          angleHour = nowHour * 30 * pi / 180;
          preHour = nowHour;
        }
      });
    });
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    // print(DateFormat.s().format(_now));
    return Scaffold(
        backgroundColor: Color(0xffeaeaea),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
//SECOND
              Positioned(
                top: 2.5 * h / 3 - w - 15,
                left: -2 * w + w * 0.7 - 50,
                child: Transform.rotate(
                  angle: -angle,
                  // angle: 0,
                  child: Image.asset(
                    'images/seconds_face.png',
                    height: 2 * w,
                  ),
                ),
              ),

// MINUTE
              Positioned(
                top: 2.5 * h / 3 - w + 9 * w / 74,
                left: -2 * w + w * 0.7 + 9 * w / 74 - 50,
                child: Transform.rotate(
                  angle: 126 * pi / 180 - angleMinute,
                  child: Image.asset(
                    'images/minutes_face.png',
                    // fit: BoxFit.fitWidth,
                    height: 126 * w / 74,
                  ),
                ),
              ),

//HOUR
              Positioned(
                top: 2.5 * h / 3 - w + 18 * w / 74 + 15,
                left: -2 * w + w * 0.7 + 18 * w / 74 - 50,
                child: Transform.rotate(
                  angle: -angleHour,
                  child: Image.asset(
                    'images/hours_face.png',
                    // fit: BoxFit.fitWidth,
                    height: 104 * w / 74,
                  ),
                ),
              ),
//RULER LINE
              Positioned(
                bottom: 40,
                child: Container(
                  height: 2,
                  width: w,
                  color: Colors.blue,
                ),
              ),

Positioned(
  child: Image.asset(
    'images/overlay.png',
    height: 200,
  ),
  top: 0,
  right: 0,
)

            ],
          ),
        ));
  }
}

