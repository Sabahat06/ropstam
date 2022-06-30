import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ropstam/model/login_model.dart';
import 'package:ropstam/services/http_services.dart';
import 'package:ropstam/view/homepage.dart';
import 'package:ropstam/view/login_screen.dart';
import 'package:ropstam/widgets/my_filled_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  RxBool progressing = false.obs;
  LoginModel? loginModel = LoginModel();
  RxBool? isLoggedIn = false.obs;
  Rx<User>? user = User().obs;

  Future<void> onInit() async {
    super.onInit();
  }

  loginUser(String email, String password) async {
    progressing.value = true;
    loginModel = (await HttpServices.loginUser(email: email, password: password, deviceToken: "zasdcvgtghnkiuhgfde345tewasdfghjkm"))!;
    if (loginModel!.meta!.status == 200) {
      user!.value = loginModel!.data!.user!;
      setLoginValue(true);
      progressing.value = false;
      User.saveUserToCache(user!.value);
      isLoggedIn!.value = true;
      Fluttertoast.showToast(msg: loginModel!.meta!.message.toString());
      Get.off(() => const HomePage());
    }
  }

  setLoginValue(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
  }

  getDialoge() {
    return Get.dialog(Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          children: [
            GestureDetector(
              onTap:(){
                Get.back();
              },
              child: Container(
                color: Colors.transparent,
                width: Get.width,
                height: Get.height,
              ),
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    height: Get.height*0.2,
                    width: Get.width*0.75,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 5),
                          Container(
                            width: Get.width*0.75,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const[
                                    Text('LOGOUT', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 15,),
                                    Text("Are you sure to logout from App", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15,),
                          Container(
                            width: Get.width*0.75,
                            decoration: const BoxDecoration(color: Colors.white),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyFilledButton(
                                    borderRadius: 10,
                                    color: Colors.grey,
                                    txtColor: Colors.white,
                                    width: Get.width*0.2,
                                    height: Get.height*0.04,
                                    txtFontSize: 16,
                                    txt: "No",
                                    leftRightpadding: 10,
                                    ontap: () {
                                      Get.back();
                                    },
                                  ),
                                  MyFilledButton(
                                    borderRadius: 10,
                                    color: Colors.green,
                                    txtColor: Colors.white,
                                    txtFontSize: 16,
                                    width: Get.width*0.2,
                                    height: Get.height*0.04,
                                    txt: "YES",
                                    leftRightpadding: 10,
                                    ontap: () {
                                      Get.back();
                                      logOut();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  logOut() {
    user!.value = User();
    User.deleteCachedUser();
    isLoggedIn!.value = false;
    Get.offAll(LoginRopstamScreen());
    setLoginValue(false);
  }
}