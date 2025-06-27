import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:root_admin/constants.dart';
import 'package:root_admin/entry_point.dart';
import 'package:root_admin/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class ProductController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  Future<void> addProduct({
    required String name,
    required String brand,
    required String description,
    required String category,
    required String subcategory,
    required List<File> images,
    required double price,
  }) async {
    try {
      isLoading.value = true;

      // Show uploading message
      Get.snackbar(
        'Uploading',
        'Uploading product images...',
        showProgressIndicator: true,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );

      // First upload images
      final List<String> imageUrls =
          await _firebaseService.uploadProductImages(images);

      // Then add product with image URLs
      await _firebaseService.addProduct(
        name: name,
        brand: brand,
        description: description,
        category: category,
        subcategory: subcategory,
        imageUrls: imageUrls,
        price: price,
        adminId: auth.currentUser!.uid,
      );

      Get.snackbar('Success', 'Product uploaded successfully');
      Get.offAll(() => const EntryPoint()); // Navigate to Home Screen
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to upload product: ${e.toString()}',
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
