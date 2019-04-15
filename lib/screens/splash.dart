import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moments/api/api.dart';
import 'package:moments/utils/utils.dart';
import 'package:moments/views/views.dart';
import 'home.dart';
import 'auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    lazyExecute(Duration(seconds: 3), () async {
      FirebaseUser user = await PhoneAuthAPI.currentUser;
      Navigator.of(context).pushReplacement(
          user != null ? HomeScreen.builder : AuthScreen.builder);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Logo(),
              SizedBox(height: 12),
              AppTitle(),
            ],
          ),
        ),
      ),
    );
  }
}
