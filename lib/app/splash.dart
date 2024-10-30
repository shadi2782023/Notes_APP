import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool _isLogoVisible = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLogoVisible = true;
      });
    });

    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences sharedPreference =
          await SharedPreferences.getInstance();
      String? userId = sharedPreference.getString("user_id");

      if (userId == null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, "login");
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, "home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          width: _isLogoVisible ? 200 : 50,
          height: _isLogoVisible ? 200 : 50,
          child: Image.asset(
            'images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
