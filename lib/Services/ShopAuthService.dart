import 'dart:convert';
import 'dart:io';
import 'package:aabehayat_vendor/Models/ShopModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../Utils/ResponseClass.dart';

class ShopService {
  final String cloudName = "dn4x22eow";
  final String apiKey = "761677329524368";
  final String apiSecret = "sQKGUei4Z196PHZCOxJtrB9ovTQ";
  final String uploadPreset = "shop_images_preset";
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Compress image
  Future<XFile?> compressImage(File image) async {
    try {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        image.absolute.path,
        "${image.parent.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg",
        quality: 75,
      );
      if (compressedImage == null) {
        print("Compression failed: No file returned");
      }
      return compressedImage;
    } catch (e) {
      print("Error during compression: $e");
      return null;
    }
  }

  Future<ResponseClass<String>> uploadImageToCloudinary(
      File image, String folderName) async {
    final compressedImage = await compressImage(image);
    if (compressedImage == null) {
      return ResponseClass.error("Image compression failed");
    }

    final url =
        Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");
    final request = http.MultipartRequest("POST", url)
      ..fields['upload_preset'] = uploadPreset
      ..fields['folder'] = folderName
      ..files
          .add(await http.MultipartFile.fromPath('file', compressedImage.path));

    try {
      final streamedResponse = await request.send();

      final responseBody = await streamedResponse.stream.bytesToString();
      print(
          'Response Body: $responseBody'); // Add this line to log the response body

      if (streamedResponse.statusCode == 200) {
        final json = jsonDecode(responseBody);
        return ResponseClass.success(json['secure_url']);
      } else {
        return ResponseClass.error(
            "Upload failed: ${streamedResponse.statusCode} - $responseBody");
      }
    } catch (e) {
      return ResponseClass.error("Error during upload: $e");
    }
  }
 
  Future<ResponseClass<String>> saveShopToFirestore(ShopModel shop) async {
    try {
      await firestore.collection('shops').doc(shop.shopId).set(shop.toJson());
      return ResponseClass.success("Shop data saved to Firestore successfully");
    } catch (e) {
      return ResponseClass.error("Failed to save shop data: $e");
    }
  }


  static Future<Map<String, dynamic>?> getShopData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return null;

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('shops')
          .doc(uid)
          .get();

      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print("Error getting shop data: $e");
      return null;
    }
  }
}
