import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task/utils/kconstant/app.kconstant.dart';

import 'details/mainpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          color: Color(0xffF1EFE7),
          image: DecorationImage(image: AssetImage('assets/logo/task.png'))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              margin: Appkconstant.bottomPadding * 22,
              // color: Colors.red,
              height: 44,
              width: 44,
              child: const CircularProgressIndicator(
                color: Appkconstant.appBarColor,
              )),
        ],
      ),
    );
  }
}
