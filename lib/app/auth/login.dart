import 'package:flutter/material.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/components/customtextform.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';
import '../../components/valid.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Curd crud = Curd();
  login() async {
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(
          linkLogin, {"email": email.text, "password": password.text});
      isLoading = false;
      setState(() {});
      if (response?['status'] == "Success") {
        sharedPreference.setString(
            "user_id", response['data']['user_id'].toString());
        sharedPreference.setString("username", response['data']['username']);
        sharedPreference.setString("email", response['data']['email']);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        // ignore: avoid_print
        print("Sign in fail");
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
                        obscuretext: true,
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
                          await login();
                        },
                        child: const Text(
                          "Login",
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
                        child: const Text("Sign UP"),
                        onTap: () {
                          Navigator.of(context).pushNamed("signup");
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
