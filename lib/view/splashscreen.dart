import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_magang/data_global.dart';
import 'package:training_magang/data_global/preference_data.dart';
import 'package:training_magang/main.dart';
import 'package:training_magang/view/auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> startSplash() async {
    return Future.delayed(Duration(seconds: 7), () async {
      dataGlobal.user = await SavePreference().loadUser();
      if (dataGlobal.user != null) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
      }
    });
  }

  @override
  void initState() {
    startSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'UDACODING STORE',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
