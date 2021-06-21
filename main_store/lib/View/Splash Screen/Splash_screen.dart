import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/View/Home/HomeView.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              child: Image(
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
          ),
          Container(
            child: CircularProgressIndicator(
              color: accentColor,
            ),
          )
        ],
      ),
    );
  }
}
