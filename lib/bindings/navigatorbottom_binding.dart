import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_21/controllers/navigatorbottom_controller.dart';

class NavigatorbottomBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NavigatorBottomController>(() => NavigatorBottomController());
  }
}