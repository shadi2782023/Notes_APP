import 'package:flutter/material.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';
import 'package:notesapp/components/crud.dart';

class LoginController {
  bool isLoading = false; // استخدام متغير عادي بدلاً من Rx
  final email = TextEditingController();
  final password = TextEditingController();
  final Curd crud = Curd();

  void login(BuildContext context) async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      isLoading = true; // تعيين حالة التحميل إلى true
      var response = await crud.postRequest(
          linkLogin, {"email": email.text, "password": password.text});
      isLoading = false; // تعيين حالة التحميل إلى false

      if (response?['status'] == "Success") {
        sharedPreference.setString(
            "user_id", response['data']['user_id'].toString());
        sharedPreference.setString("username", response['data']['username']);
        sharedPreference.setString("email", response['data']['email']);
        
        // الانتقال إلى الصفحة الرئيسية
        Navigator.pushReplacementNamed(context, "home");
      } else {
        print("Sign in fail");
      }
    }
  }
}
