import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'cloudinary_service.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CloudinaryService _cloudinaryService = CloudinaryService();

  // Upload multiple images and return their URLs using Cloudinary
  Future<List<String>> uploadProductImages(List<File> images) async {
    return await _cloudinaryService.uploadImages(images);
  }

  // Add a new product to Firestore
  Future<void> addProduct({
    required String name,
    required String brand,
    required String description,
    required String category,
    required String subcategory,
    required List<String> imageUrls,
    required double price,
    required String adminId,
  }) async {
    try {
      final String productId = _firestore.collection('products').doc().id;

      final Map<String, dynamic> productData = {
        'productId': productId,
        'name': name,
        'brand': brand,
        'description': description,
        'category': category,
        'subcategory': subcategory,
        'images': imageUrls,
        'price': price,
        'createdAt': FieldValue.serverTimestamp(),
        'adminId': adminId
      };

      await _firestore.collection('products').doc(productId).set(productData);
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }
}
