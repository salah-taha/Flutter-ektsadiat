import 'dart:async';

import 'package:eqtisadiat/api/api.dart';
import 'package:eqtisadiat/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Api api;
  SplashScreen({this.api});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Timer _timer;
  Timer _timer2;

  double _op = 0;

  _SplashScreenState() {
    _timer = new Timer(const Duration(seconds: 7), () {
      setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home(widget.api)));
      });
    });
  }

  void initState() {
    super.initState();

    _timer2 = new Timer(const Duration(seconds: 3), () {
      setState(() {
        _op = 1;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _timer.cancel();
    _timer2.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 280),
          ),
          AnimatedOpacity(
            opacity: _op,
            duration: Duration(seconds: 2),
            child: Image.asset(
              'assets/img/logo.png',
              width: 200,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 130),
            child: Container(
              width: 60,
              height: 60,
              child: Image.asset('assets/img/loading.gif'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Text(
              'مجلة اقتصاديات الالكترونية',
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Text(
              'Powered By Smart Geeks',
            ),
          ),
        ],
      ),
    ));
  }
}
