import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ropstam/controller/login_controller.dart';
import 'package:ropstam/model/login_model.dart';
import 'package:ropstam/view/homepage.dart';
import 'package:ropstam/view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getLoginValue();
  runApp(MyApp());
}

bool isLoggedIn = false;

getLoginValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isLoggedIn = prefs.getBool('isLoggedIn')??false;
}

class MyApp extends StatelessWidget {
  LoginController loginController = Get.put(LoginController());

  getUser() async {
    if(isLoggedIn) {
      loginController.user!.value = (await User.fromCache())!;
    }
  }
  @override
  Widget build(BuildContext context) {
    getUser();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ? const HomePage() : LoginRopstamScreen(),
    );
  }
}

