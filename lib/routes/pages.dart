import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_21/bindings/dashboard_binding.dart';
import 'package:pas_mobile_11pplg1_21/bindings/navigatorbottom_binding.dart';
import 'package:pas_mobile_11pplg1_21/bindings/register_binding.dart';
import 'package:pas_mobile_11pplg1_21/bindings/splashscreen_binding.dart';
import 'package:pas_mobile_11pplg1_21/pages/auth_page.dart';
import 'package:pas_mobile_11pplg1_21/pages/dashboard_page.dart';
import 'package:pas_mobile_11pplg1_21/pages/favorite_page.dart';
import 'package:pas_mobile_11pplg1_21/pages/navigatorbottom.dart';
import 'package:pas_mobile_11pplg1_21/pages/register_page.dart';
import 'package:pas_mobile_11pplg1_21/pages/splashscreen_page.dart';

import 'routes.dart';
import '../bindings/auth_binding.dart';

class AppPages {
  static final pages = [
    
    GetPage(
      name: AppRoutes.splashscreen,
      page: () => SplashscreenPage(),
      bindings: [SplashscreenBinding(), AuthBinding()]
    ),

    GetPage(
      name: AppRoutes.auth,
      page: () => AuthPage(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.navigator,
      page: () =>  NavigatorBottomPage(),
      binding: NavigatorbottomBinding()
    ),

    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),

    GetPage(
    name: AppRoutes.favorite,
    page: () => FavoritePage(),
    ),


    GetPage(
    name: AppRoutes.register,
    page: () => RegisterPage(),
    binding: RegisterBinding(),
    ),

  ];
}
