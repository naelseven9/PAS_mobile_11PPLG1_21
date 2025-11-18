import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_21/controllers/splashscreen_controller.dart';

class SplashscreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
  }
}