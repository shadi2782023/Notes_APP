import 'package:flutter/material.dart';
import 'package:notesapp/app/auth/signup.dart';
import 'package:notesapp/app/notes/add.dart';
import 'package:notesapp/app/notes/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/auth/login.dart';
import 'app/auth/success.dart';
import 'app/home.dart';
import 'app/splash.dart';

late SharedPreferences sharedPreference;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreference = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.grey,
      theme: ThemeData(
        fontFamily: "Lato",
        scaffoldBackgroundColor: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "splashscreen",
      routes: {
        "splashscreen": (context) => SplashScreen(),
        "login": (context) => const Login(), 
        "signup": (context) => const SignUp(),
        "home": (context) => const Home(),
        "success": (context) => const Success(),
        "addnote": (context) => AddNotes(
              hinttext: "",
            ),
        "editnote": (context) => const EditNote(),
      },
    );
  }
}
