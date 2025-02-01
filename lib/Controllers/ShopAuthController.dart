import 'dart:io';
import 'package:aabehayat_vendor/Models/ShopModel.dart';
import 'package:aabehayat_vendor/Services/ShopAuthService.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart' as loc;



class ShopAuthController extends GetxController {
  final ShopService shopService = ShopService();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController shopDescriptionController = TextEditingController();
  final TextEditingController shopEmailController = TextEditingController();
  final TextEditingController shopPhoneController = TextEditingController();
  final TextEditingController totalGalonsController = TextEditingController();
  final TextEditingController totalBottlesController = TextEditingController();
  RxList<String> selectedDeliveryOptions = <String>[].obs;
  Rx<XFile?> shopImage = Rx<XFile?>(null);
  Rx<XFile?> cnicFrontImage = Rx<XFile?>(null);
  Rx<XFile?> cnicBackImage = Rx<XFile?>(null);
  RxList<Map<String, TimeOfDay>> deliveryTimes = <Map<String, TimeOfDay>>[].obs;
  RxBool isLoading = false.obs;
  final loc.Location _location = loc.Location();
  final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  final RxString currentAddress = 'Fetching address...'.obs;
  final RxBool mapLoading = true.obs;
  final Completer<GoogleMapController> mapController = Completer();



  @override
  void onInit() {
    super.onInit();
    fetchCurrentLocation();
  }

  // Function to pick shop image 
  Future<void> pickShopImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      shopImage.value = image;
    }
  }

  // Function to pick cnic front image
  Future<void> pickCnicFrontImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      cnicFrontImage.value = image;
    }
  }

  // Function to pick cnic back image
  Future<void> pickCnicBackImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      cnicBackImage.value = image;
    }
  }

  // Function to select delivery options
  void selectDeliveryOption(String option) {
    if (selectedDeliveryOptions.contains(option)) {
      selectedDeliveryOptions.remove(option);
    } else {
      selectedDeliveryOptions.add(option);
    }
  }


   Future<void> pickDeliveryTime() async {
    TimeOfDay? startTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );

    if (startTime != null) {
      TimeOfDay? endTime = await showTimePicker(
        context: Get.context!,
        initialTime: startTime,
      );

      if (endTime != null) {
        deliveryTimes.add({'start': startTime, 'end': endTime});
      }
    }
  }

String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    return DateFormat('hh:mm a').format(dateTime);
  }

  

 Future<void> saveShopData() async {
  try {
    isLoading.value = true;
    final shopFolder = "shops/${shopNameController.text.trim()}"; 

    final shopImageResponse = await shopService.uploadImageToCloudinary(
      File(shopImage.value!.path),
      shopFolder,
    );
    final cnicFrontResponse = await shopService.uploadImageToCloudinary(
      File(cnicFrontImage.value!.path),
      shopFolder,
    );
    final cnicBackResponse = await shopService.uploadImageToCloudinary(
      File(cnicBackImage.value!.path),
      shopFolder,
    );

    if (!shopImageResponse.isSuccess ||
        !cnicFrontResponse.isSuccess ||
        !cnicBackResponse.isSuccess) {
      throw Exception("Failed to upload one or more images");
    }

    final shop = ShopModel(
      shopId: DateTime.now().millisecondsSinceEpoch.toString(),
      ownerName: ownerNameController.text,
      shopName: shopNameController.text,
      shopDescription: shopDescriptionController.text,
      shopEmail: shopEmailController.text,
      shopPhone: int.tryParse(shopPhoneController.text),
      shopImage: shopImageResponse.data,
      shopLocation: {
        'shopAddress': currentAddress.value,
        'latitude': currentLocation.value!.latitude,
        'longitude': currentLocation.value!.longitude,
      },
      deliveryOptions: selectedDeliveryOptions,
      deliveryTimes: deliveryTimes.map((time) {
        return {
          'start': formatTimeOfDay(time['start']!),
          'end': formatTimeOfDay(time['end']!),
        };
      }).toList(),
      ownerCnic: {
        'cnicFront': cnicFrontResponse.data!,
        'cnicBack': cnicBackResponse.data!,
      },
      totalGalons: int.tryParse(totalGalonsController.text),
      totalBottles: int.tryParse(totalBottlesController.text),
      accountApprove: false,
      isCertified: false,
      shopRating: 0.0,
    );

    final firestoreResponse = await shopService.saveShopToFirestore(shop);
    if (!firestoreResponse.isSuccess) {
      throw Exception(firestoreResponse.errorMessage);
    }

    Get.snackbar("Success", "Shop data saved successfully!");
  } catch (e) {
    Get.snackbar("Error", "An error occurred: $e");
  } finally {
    isLoading.value = false;
  }
}



Future<void> fetchCurrentLocation() async {
    try {
      mapLoading.value = true;

      // Location services check
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) throw Exception("Location services are disabled.");
      }

      // Location permissions check
      loc.PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) {
          throw Exception("Location permissions are denied.");
        }
      }

      // Fetch location
      final locationData = await _location.getLocation();
      currentLocation.value =
          LatLng(locationData.latitude!, locationData.longitude!);

      // Reverse geocoding for address
      await fetchAddressFromCoordinates();

      // Move camera to current location
      if (mapController.isCompleted) {
        final GoogleMapController controller = await mapController.future;
        controller.animateCamera(CameraUpdate.newLatLng(currentLocation.value!));
      }
    } catch (e) {
      Get.snackbar("Error", "Unable to fetch location: $e");
    } finally {
      mapLoading.value = false;
    }
  }

  Future<void> fetchAddressFromCoordinates() async {
    if (currentLocation.value != null) {
      try {
        List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(
          currentLocation.value!.latitude,
          currentLocation.value!.longitude,
        );
        geocoding.Placemark place = placemarks[0];
        currentAddress.value =
            "${place.street}, ${place.locality}, ${place.country}";
      } catch (e) {
        currentAddress.value = "Unable to fetch address.";
      }
    }
  }

  void onMapDragged(LatLng position) {
    currentLocation.value = position;
    fetchAddressFromCoordinates();
  }

  void onMapTapped(LatLng position) {
    currentLocation.value = position;
    fetchAddressFromCoordinates();
  }


void clearData() {
  ownerNameController.clear();
  shopNameController.clear();
  shopDescriptionController.clear();
  shopEmailController.clear();
  shopPhoneController.clear();
  totalGalonsController.clear();
  totalBottlesController.clear();
  shopImage.value = null;
  cnicFrontImage.value = null;
  cnicBackImage.value = null;
  selectedDeliveryOptions.clear();
  deliveryTimes.clear();
  isLoading.value = false;
  currentLocation.value = null;
  currentAddress.value = 'Fetching address...';
  mapLoading.value = true;
}

  

}
