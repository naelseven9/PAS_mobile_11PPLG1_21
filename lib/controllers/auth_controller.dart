import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pas_mobile_11pplg1_21/api/authclient.dart';
import 'package:pas_mobile_11pplg1_21/models/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/routes.dart';

class AuthController extends GetxController {
  final username = TextEditingController();
  final password = TextEditingController();

  var isLoading = false.obs;
  var loginStatus = "".obs;

  Future<void> login() async {
    final user = username.text.trim();
    final pass = password.text.trim();

    if (user.isEmpty || pass.isEmpty) {
      Get.snackbar("Error", "Username dan password tidak boleh kosong");
      return;
    }

    isLoading.value = true;
    loginStatus.value = "";

    try {
      final url = Uri.parse("${Authclient.baseUrl}latihan/login");

      final response = await http.post(
        url,
        body: {
          'username': user,
          'password': pass,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final loginModel = LoginModel.fromJson(data);

        if (loginModel.status == true) {
          final prefs = await SharedPreferences.getInstance();
          if (loginModel.token != null && loginModel.token!.isNotEmpty) {
            await prefs.setString('token', loginModel.token!);
            print("✅ Token tersimpan: ${loginModel.token}");
          } else {
            print("⚠️ Token kosong atau null");
          }

          await prefs.setString('username', user);

          Get.snackbar(
            "Sukses",
            loginModel.message,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          );

          Get.offAllNamed(AppRoutes.navigator);
        } else {
          loginStatus.value = "Login gagal: ${loginModel.message}";
          Get.snackbar("Gagal", loginModel.message);
        }
      } else {
        loginStatus.value = "Error: ${response.statusCode}";
        Get.snackbar("Error", "Kode HTTP: ${response.statusCode}");
      }   
    } catch (e) {
      loginStatus.value = "Terjadi kesalahan: $e";
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } 
    isLoading.value = false;
  }

  @override
  void onClose() {
    username.dispose();
    password.dispose();
    super.onClose();
  }

 Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('username');

      Get.snackbar(
        "Logout Berhasil",
        "Kamu telah keluar dari akun.",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );

      Get.offAllNamed(AppRoutes.auth);
    } catch (e) {
      Get.snackbar(
        "Logout Gagal",
        "Terjadi kesalahan: $e",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }
}