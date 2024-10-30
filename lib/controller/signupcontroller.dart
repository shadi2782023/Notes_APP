import 'package:get/get.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/components/crud.dart';
import 'package:flutter/material.dart';

class SignUpController extends GetxController {
  var isLoading = false.obs; // حالة التحميل
  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  final Curd crud = Curd();

  void signUp() async {
    if (username.text.isNotEmpty && email.text.isNotEmpty && password.text.isNotEmpty) {
      isLoading.value = true; // تعيين حالة التحميل إلى true
      var response = await crud.postRequest(linkSignUp, {
        "username": username.text,
        "email": email.text,
        "password": password.text,
      });
      isLoading.value = false; // تعيين حالة التحميل إلى false

      if (response?['status'] == "Success") {
        Get.offNamed("success"); // الانتقال إلى صفحة النجاح
      } else {
        print("Sign Up fail");
      }
    }
  }
}
