import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

// ignore: prefer_interpolation_to_compose_strings
String _basicAuth = 'Basic ' + base64Encode(utf8.encode('shadi:shadiraghad'));

Map<String, String> myheaders = {'authorization': _basicAuth};

class Curd {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        // ignore: avoid_print
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error Catch $e");
    }
  }

  postRequest(String url, Map data) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: data, headers: myheaders);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        // ignore: avoid_print
        print(responseBody);
        return responseBody;
      } else {
        // ignore: avoid_print
        print("Error ${response.statusCode}");
        return {"data": []};
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error Catch $e");
      return {"data": []};
    }
  }

  postRequestWithFile(String url, Map data, File file) async {
    // ignore: await_only_futures
    var request = await http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var streem = http.ByteStream(file.openRead());
    var multipartfile = http.MultipartFile("file", streem, length,
        filename: basename(file.path));
    request.headers.addAll(myheaders);
    request.files.add(multipartfile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // ignore: avoid_print
      print("Error ${myrequest.statusCode}");
    }
  }
}
