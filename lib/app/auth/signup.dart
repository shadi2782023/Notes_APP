import 'package:flutter/material.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/components/valid.dart';
import 'package:notesapp/constant/linkapi.dart';

import '../../components/customtextform.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isPasswordVisible = false;
  bool isLoading = false;
  final Curd _crud = Curd();
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  signUp() async {
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await _crud.postRequest(linkSignUp, {
        "username": username.text,
        "email": email.text,
        "password": password.text
      });
      isLoading = false;
      setState(() {});
      if (response?['status'] == "Success") {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushNamedAndRemoveUntil("success", (route) => false);
      } else {
        // ignore: avoid_print
        print("Sign Up fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.yellow.shade800,
              ),
            )
          : Container(
              padding: const EdgeInsets.all(15),
              child: ListView(children: [
                Form(
                  key: formState,
                  child: Column(
                    children: [
                      Image.asset(
                        'images/logo.png',
                      ),
                      CustomTextFormLogin(
                        hinttext: "please enter your UserName",
                        icondata: Icons.person_2_outlined,
                        labeltext: "Username",
                        isNumber: false,
                        obscuretext: false,
                        valid: (val) {
                          return validInput(val!, 2, 20);
                        },
                        mycontroller: username,
                      ),
                      CustomTextFormLogin(
                        hinttext: "please enter your Email",
                        icondata: Icons.email_outlined,
                        labeltext: "Email",
                        isNumber: false,
                        obscuretext: false,
                        valid: (val) {
                          return validInput(val!, 5, 50);
                        },
                        mycontroller: email,
                      ),
                      CustomTextFormLogin(
                        hinttext: "please enter your Password",
                        icondata: Icons.password_outlined,
                        labeltext: "Password",
                        isNumber: false,
                        obscuretext: !isPasswordVisible,
                        valid: (val) {
                          return validInput(val!, 6, 20);
                        },
                        mycontroller: password,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // نصف قطر الحواف الدائرية
                        ),
                        color: Colors.yellow.shade700,
                        textColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 50),
                        onPressed: () async {
                          await signUp();
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      InkWell(
                        child: const Text("Login"),
                        onTap: () {
                          Navigator.of(context).pushNamed("login");
                        },
                      )
                    ],
                  ),
                ),
              ]),
            ),
    );
  }
}
