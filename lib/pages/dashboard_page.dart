import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_21/models/FakestoreModel.dart';
import '../controllers/dashboard_controller.dart';
import 'favorite_page.dart'; // nanti dibuat

class DashboardPage extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FakeStore Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(() => FavoritePage());
            },
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.products.isEmpty) {
          return const Center(child: Text("Produk tidak ada"));
        }

        return ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            FakestoreModel product = controller.products[index];
            return Card(
              margin: const EdgeInsets.all(10),
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
                  icon: const Icon(Icons.add, color: Colors.red),
                  onPressed: () {
                    controller.addToFavorite(product);
                    Get.snackbar(
                      "Added",
                      "${product.title} added to favorites",
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
