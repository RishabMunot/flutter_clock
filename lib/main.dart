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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
                  // angle: 0,
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
                  // angle: 126 * pi / 180 - angleHour,
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
              // Positioned(
              //   top: h / 2 - 4 * w / 3,
              //   right: w / 3,
              //   child: CircleAvatar(
              //     backgroundColor: Colors.tealAccent,
              //     radius: 4 * w / 3,
              //   ),
              // ),
              // Positioned(
              //   top: h / 2 - w,
              //   right: 2 * w / 3,
              //   child: CircleAvatar(
              //     radius: w,
              //   ),
              // ),

              // // Positioned(
              //   right: 0,
              //   top: h / 2 - 50,
              //   child: Container(
              //     padding: EdgeInsets.all(15.0),
              //     width: w,
              //     height: 100.0,
              //     color: Colors.black38,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: <Widget>[
              //         Container(
              //           child: Text(
              //             DateFormat.H().format(_now),
              //             style: TextStyle(fontSize: 45.0, color: Colors.white),
              //           ),
              //         ),
              //         Container(
              //           child: Text(
              //             DateFormat.m().format(_now),
              //             style: TextStyle(fontSize: 45.0, color: Colors.white),
              //           ),
              //         ),
              //         Container(
              //           child: Text(
              //             DateFormat.s().format(_now),
              //             style: TextStyle(fontSize: 45.0, color: Colors.white),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }
}

// class Animated extends StatefulWidget {
//   Animated({Key key}) : super(key: key);

//   @override
//   _AnimatedState createState() => _AnimatedState();
// }

// class _AnimatedState extends State<Animated> with TickerProviderStateMixin {
//   AnimationController _controller;
//   Animation _animation;
//   double angle = 60;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _controller =
//         AnimationController(vsync: this, duration: Duration(seconds: 1));
//     _controller.addListener(() {
//       setState(() {
//         angle = _controller.value * 10;
//       });
//     });
//     _controller.repeat();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _controller.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: <Widget>[
//             // AnimatedContainer(
//             //   duration: Duration(seconds: 2),
//             //   child: CircleAvatar(
//             //     radius: 100.0,
//             //   ),
//             //   transform: Matrix4.ro(10),
//             // )
//             Transform.rotate(
//               angle: angle,
//               // child: CircleAvatar(
//               //   radius: 100.0,
//               // ),
//               child: Container(
//                 width: 100.0,
//                 height: 100.0,
//                 color: Colors.blue,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
