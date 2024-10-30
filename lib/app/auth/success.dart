import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
              child: Text(
            "Registeration Done",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          const SizedBox(
            height: 15,
          ),
          MaterialButton(
            minWidth: 100,
            height: 40,
            color: Colors.yellow.shade800,
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            child: const Text(
              "Sign In",
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
