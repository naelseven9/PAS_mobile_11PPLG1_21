import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_21/helper/db_helper.dart';
import '../models/FakestoreModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardController extends GetxController {
  var products = <FakestoreModel>[].obs;
  var isLoading = false.obs;
  var favoriteProducts = <FakestoreModel>[].obs;

  final DbHelper dbHelper = DbHelper();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    loadFavoritesFromDb();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        products.value = data.map((e) => FakestoreModel.fromJson(e)).toList();
      } else {
        Get.snackbar("Error", "Failed to fetch products from API",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadFavoritesFromDb() async {
    final favs = await dbHelper.getFavorites();
    favoriteProducts.value = favs;
  }

  Future<void> addToFavorite(FakestoreModel product) async {
    if (!favoriteProducts.any((p) => p.id == product.id)) {
      favoriteProducts.add(product);
      await dbHelper.insertFavorite(product); 
    }
  }

  Future<void> removeFromFavorite(FakestoreModel product) async {
    favoriteProducts.removeWhere((p) => p.id == product.id);
    await dbHelper.removeFavorite(product.id);
  }
}
