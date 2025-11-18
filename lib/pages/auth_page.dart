import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pas_mobile_11pplg1_21/controllers/auth_controller.dart';
import 'package:pas_mobile_11pplg1_21/routes/routes.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth < 450 ? screenWidth * 0.9 : 400,
            child: Card(
              elevation: 10,
              shadowColor: Colors.orangeAccent.withOpacity(0.3),
              color: const Color(0xFFFFF3E0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: const Color(0xFFFFA726),
                      child: const Icon(Icons.shopping_basket, size: 50, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Selamat Datang",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6D4C41),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Login untuk masuk ke Aplikasi",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF8D6E63),
                      ),
                    ),
                    const SizedBox(height: 30),

                    TextField(
                      controller: controller.username,
                      decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: const TextStyle(color: Color(0xFF8D6E63)),
                        filled: true,
                        fillColor: const Color(0xFFFFF3E0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: controller.password,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Color(0xFF8D6E63)),
                        filled: true,
                        fillColor: const Color(0xFFFFF3E0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    Obx(() => ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () => controller.login(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFA726),
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  "Login",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                        )),
                    const SizedBox(height: 30),

                    ElevatedButton.icon(
                      onPressed: () async {
                        bool? exitConfirmed = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Konfirmasi"),
                            content: const Text("Apakah Anda yakin ingin keluar dari aplikasi?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Batal"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("Keluar"),
                              ),
                            ],
                          ),
                        );

                        if (exitConfirmed == true) {
                          exit(0);
                        }
                      },
                      icon: const Icon(Icons.exit_to_app),
                      label: const Text("Keluar Aplikasi"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Get.offAllNamed(AppRoutes.register);
                      },
                      child: const Text(
                        "Belum punya akun? Daftar",
                        style: TextStyle(
                          color: Color(0xFFFFA726),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
