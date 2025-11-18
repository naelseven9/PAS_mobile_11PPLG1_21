import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_21/controllers/navigatorbottom_controller.dart';
import 'package:pas_mobile_11pplg1_21/pages/dashboard_page.dart';
import 'package:pas_mobile_11pplg1_21/pages/favorite_page.dart';
import 'package:pas_mobile_11pplg1_21/pages/profile_page.dart';

class NavigatorBottomPage extends StatelessWidget {
  const NavigatorBottomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigatorBottomController c = Get.put(NavigatorBottomController());

    final List<Widget> pages = [
      DashboardPage(),
      FavoritePage(),
      ProfilePage(),
    ];

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFCC80), // oranye lembut
          title: Text(
            c.titles[c.currentIndex.value],
            style: const TextStyle(color: Colors.brown),
          ),
        ),
        body: pages[c.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFFFFF3E0), // cream terang
          currentIndex: c.currentIndex.value,
          selectedItemColor: Colors.orangeAccent,
          unselectedItemColor: Colors.brown,
          onTap: (index) => c.changePage(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: "Favorite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
