import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mizan_app/screens/home_screen.dart';
import 'package:mizan_app/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MizanSplashscreen extends StatefulWidget {
  const MizanSplashscreen({super.key});

  @override
  State<MizanSplashscreen> createState() => _MizanSplashscreenState();
}

class _MizanSplashscreenState extends State<MizanSplashscreen> {
  double _opacity = 0;

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('loggedIn') ?? false;

    if (loggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Login();
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _opacity = 1;
      });
    });
    Future.delayed(Duration(seconds: 3), () {
      checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/mizan.png'),
              Text(
                'ميزان',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                  fontFamily: 'Gulzar-Regular',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
