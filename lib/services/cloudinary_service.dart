import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CloudinaryService {
  static const String _cloudName = 'dalsmv58x';
  static const String _uploadPreset = 'vaibhav1211';
  static const String _apiUrl = 'https://api.cloudinary.com/v1_1';

  Future<String?> uploadImage(File imageFile) async {
    try {
      print('Starting image upload to Cloudinary: ${imageFile.path}');
      final uri = Uri.parse('$_apiUrl/$_cloudName/image/upload');

      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = _uploadPreset
        ..files.add(
          await http.MultipartFile.fromPath(
            'file',
            imageFile.path,
          ),
        );

      print('Sending request to Cloudinary...');
      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonData = json.decode(responseString);

      print('Cloudinary response: $jsonData');

      if (response.statusCode == 200 && jsonData['secure_url'] != null) {
        print('Image uploaded successfully: ${jsonData['secure_url']}');
        return jsonData['secure_url'];
      } else {
        print('Upload failed with status code: ${response.statusCode}');
        throw Exception(
            'Failed to upload image: ${jsonData['error']?['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      print('Error uploading image to Cloudinary: $e');
      return null;
    }
  }

  Future<List<String>> uploadImages(List<File> images) async {
    List<String> imageUrls = [];

    try {
      for (var image in images) {
        final url = await uploadImage(image);
        if (url != null) {
          imageUrls.add(url);
        }
      }

      return imageUrls;
    } catch (e) {
      throw Exception('Error uploading images to Cloudinary: $e');
    }
  }
}
