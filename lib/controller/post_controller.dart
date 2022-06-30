import 'package:get/get.dart';
import 'package:ropstam/model/post_model.dart';
import 'package:ropstam/services/http_services.dart';

class PostController extends GetxController {

  RxBool progressing = false.obs;
  List<PostModel> postModel = <PostModel>[];

  PostController() {
    getPosts();
  }

  getPosts() async {
    progressing.value = true;
    postModel = (await HttpServices.getPosts())!;
    progressing.value = false;
  }
}