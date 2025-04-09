import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ShopLocalStorageService {
  static Future<void> saveShopData(Map<String, dynamic> shopData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String shopDataJson = jsonEncode(shopData);
      await prefs.setString('shop_data', shopDataJson);
    } catch (e) {
      throw Exception("Failed to save shop data locally: $e");
    }
  }

  static Future<Map<String, dynamic>?> getShopData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? shopDataJson = prefs.getString('shop_data');
      if (shopDataJson != null) {
        return jsonDecode(shopDataJson);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Failed to retrieve shop data from local storage: $e");
    }
  }

  static Future<void> saveShopDataToLocalStorage({
    required String userId,
    required String ownerName,
    required String shopName,
    required String shopDescription,
    required String shopEmail,
    required String shopPhone,
    required String shopImage,
    required String shopAddress,
    required double? latitude,
    required double? longitude,
    required List selectedDeliveryOptions,
    required List deliveryTimes,
    required String cnicFront,
    required String cnicBack,
    required String totalGalons,
    required String totalBottles,
    required String galonPrice,
    required String bottlePrice,
  }) async {
    try {
      await ShopLocalStorageService.saveShopData({
        'shopId': userId,
        'ownerName': ownerName,
        'shopName': shopName,
        'shopDescription': shopDescription,
        'shopEmail': shopEmail,
        'shopPhone': shopPhone,
        'shopImage': shopImage,
        'shopLocation': {
          'shopAddress': shopAddress,
          'latitude': latitude,
          'longitude': longitude,
        },
        'deliveryOptions': selectedDeliveryOptions,
        'deliveryTimes': deliveryTimes.map((time) {
          return {
            'time': formatTimeOfDay(time['time']!)
          };
        }).toList(),
        'ownerCnic': {
          'cnicFront': cnicFront,
          'cnicBack': cnicBack,
        },
        'bottles': {
          'totalGalons': totalGalons,
          'totalBottles': totalBottles,
          'galonPrice': galonPrice,
          'bottlePrice': bottlePrice,
        },
        'accountApprove': false,
        'isCertified': false,
        'shopRating': 0.0,
      });
    } catch (e) {
      throw Exception("Failed to save shop data locally: $e");
    }
  }

  static String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final formattedTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return "${formattedTime.hour.toString().padLeft(2, '0')}:${formattedTime.minute.toString().padLeft(2, '0')}";
  }
}
