import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ropstam/controller/login_controller.dart';
import 'package:ropstam/widgets/my_filled_button.dart';
import 'package:ropstam/widgets/my_text_field_widget.dart';

class LoginRopstamScreen extends StatelessWidget {
  LoginController loginController = Get.find();
  final _formKey = GlobalKey<FormState>();
  LoginRopstamScreen({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  RxBool passwordVisibility = true.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.green.shade100]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height*0.15,),
                const Text('Hello Again!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                SizedBox(height: Get.height*0.02,),
                const Text('Chance to get your \n life better', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                SizedBox(height: Get.height*0.05,),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MyTextField(
                        controller: email,
                        hintText: 'Enter Username',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if(!GetUtils.isEmail(email.text)) {
                            return 'Please enter valid email';
                          }
                            return null;
                        },
                      ),
                      SizedBox(height: Get.height*0.02,),
                      Obx(
                        () => MyTextField(
                          controller: password,
                          obsecureText: passwordVisibility.value,
                          hintText: 'Password',
                          suffixIcon: IconButton(icon: Icon(passwordVisibility.value ? Icons.visibility : Icons.visibility_off), onPressed: () {
                            passwordVisibility.value = !passwordVisibility.value;
                          },),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: Get.height*0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text('Recover Password', style: TextStyle(fontSize: 16), textAlign: TextAlign.right,),
                        ],
                      ),
                      SizedBox(height: Get.height*0.05,),
                      Obx(
                        () => loginController.progressing.value
                          ? const Center(child: CircularProgressIndicator(),)
                          : MyFilledButton(
                            color: Colors.green,
                            width: double.infinity,
                            height: 50,
                            borderRadius: 10,
                            txt: 'LOGIN',
                            txtColor: Colors.white,
                            txtFontSize: 16,
                            ontap: () {
                              if(_formKey.currentState!.validate()) {
                                loginController.loginUser(email.text, password.text);
                              }
                            },
                          ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: Get.height*0.03,),
                const Text('Or continue with', style: TextStyle(fontSize: 18, ), textAlign: TextAlign.center,),
                SizedBox(height: Get.height*0.03,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    renderingImageBox('assets/google.png'),
                    renderingImageBox('assets/apple.png'),
                    renderingImageBox('assets/facebook.png'),
                  ],
                ),
                SizedBox(height: Get.height*0.03,),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16,),
                    children: [
                      TextSpan(text: "Not a member? "),
                      TextSpan(text: "Register Now", style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  renderingImageBox(String imageLink) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.white, width: 2),
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset(imageLink, fit: BoxFit.cover,),
        )
      ),
    );
  }

}
