import 'package:get/get.dart';

class NavigatorBottomController extends GetxController {
  var currentIndex = 0.obs;

  final List<String> titles = [
    "Dashboard",
    "Favorite",
    "Profile",
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
