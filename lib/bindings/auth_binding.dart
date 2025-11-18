import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_21/controllers/auth_controller.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}