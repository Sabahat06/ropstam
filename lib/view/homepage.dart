import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ropstam/controller/login_controller.dart';
import 'package:ropstam/controller/post_controller.dart';
import 'package:ropstam/model/login_model.dart';
import 'package:ropstam/model/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginController loginController = Get.find();
  PostController postController = PostController();

  @override
  void initState()  {
    super.initState();
    // getUser();
  }
  getUser() async {
    loginController.user!.value = (await User.fromCache())!;
    loginController.isLoggedIn!.value = loginController.user!.value == null ? false : true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade500,
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              loginController.getDialoge();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            )
          )
        ],
      ),
      body: Obx(
        () => postController.progressing.value
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
            shrinkWrap: true,
            itemCount: postController.postModel.length,
            itemBuilder: (BuildContext context, int index) => renderingPosts(postController.postModel[index]),
          ),
      )
    );
  }

  renderingPosts(PostModel postModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(10)
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: Colors.green.shade200,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(postModel.title!, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),),
                )
              ),
              Container(
                width: double.infinity,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(postModel.body!, style: const TextStyle(fontSize: 16, color: Colors.black), textAlign: TextAlign.justify,),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
