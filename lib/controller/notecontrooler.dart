import 'package:get/get.dart';

class NoteController extends GetxController {
  var isLoading = false.obs;
  var myfile;

  void setLoading(bool value) {
    isLoading.value = value;
  }

  void setFile(var file) {
    myfile = file;
  }
}
