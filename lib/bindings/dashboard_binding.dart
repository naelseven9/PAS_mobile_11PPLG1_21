import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_21/controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}