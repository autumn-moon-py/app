import 'package:app_new/controller/home_controller.dart';
import 'package:get/get.dart';

class MyBingding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
