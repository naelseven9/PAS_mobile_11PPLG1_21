import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../models/FakestoreModel.dart';

class FavoritePage extends StatelessWidget {
  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Products"),
      ),
      body: Obx(() {
        // Cek jika list favorite kosong
        if (controller.favoriteProducts.isEmpty) {
          return const Center(
            child: Text(
              "No favorite products yet.",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        // List produk favorit
        return ListView.builder(
          itemCount: controller.favoriteProducts.length,
          itemBuilder: (context, index) {
            FakestoreModel product = controller.favoriteProducts[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: Image.network(
                  product.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(product.title),
                subtitle: Text("\$${product.price.toString()}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () {
                    // Hapus dari favorite
                    controller.removeFromFavorite(product);
                    Get.snackbar(
                      "Removed",
                      "${product.title} removed from favorites",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
