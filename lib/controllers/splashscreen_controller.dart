import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/navigatorbottom.dart';
import '../pages/auth_page.dart';

class SplashScreenController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    print("Token ditemukan: $token");

    if (token != null && token.isNotEmpty) {
      Get.offAll(() => NavigatorBottomPage());
    } else {
      Get.offAll(() => AuthPage());
    }
  }
}
