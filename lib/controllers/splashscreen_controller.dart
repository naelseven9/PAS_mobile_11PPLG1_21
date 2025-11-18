import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_21/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkLogic();
  }

  Future<void> checkLogic() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username');

    if (savedUsername != null) {
      Get.offAllNamed(AppRoutes.splashscreen);
    } else {
      Get.offAllNamed(AppRoutes.auth);
    }
  }

  void login() {}
}
