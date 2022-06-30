import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:ropstam/model/login_model.dart';
import 'package:ropstam/model/post_model.dart';

class HttpServices {

  static Future<LoginModel?> loginUser({String? email, String? password, String? deviceToken}) async {
    try {
      var response = await http.post(
        Uri.parse("http://buddy.ropstambpo.com/api/login"),
        body: {
          'email': email,
          'password': password,
          'device_token': deviceToken,
        },
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if(json['meta']['status'] == 200) {
          return LoginModel.fromJson(jsonDecode(response.body));
        } else {
          Fluttertoast.showToast(msg: json['meta']['message']);
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<PostModel>?> getPosts() async {
    try {
      var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/Posts"),
      );
      if (response.statusCode == 200) {
        List rawList = jsonDecode(response.body);
        return rawList.map((json) => PostModel.fromJson(json)).toList();
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

}
