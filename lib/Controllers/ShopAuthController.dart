import 'dart:developer';
import 'dart:io';
import 'package:aabehayat_vendor/Models/ShopModel.dart';
import 'package:aabehayat_vendor/Services/LOcalStorageService.dart';
import 'package:aabehayat_vendor/Services/ShopAuthService.dart';
import 'package:aabehayat_vendor/Utils/helper_functions.dart';
import 'package:aabehayat_vendor/Views/RequestApprovalScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart' as loc;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopAuthController extends GetxController {
  final ShopService shopService = ShopService();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController shopDescriptionController =
      TextEditingController();
  final TextEditingController shopEmailController = TextEditingController();
  final TextEditingController shopPhoneController = TextEditingController();
  final TextEditingController totalGalonsController = TextEditingController();
  final TextEditingController galonPriceController = TextEditingController();
  final TextEditingController totalBottlesController = TextEditingController();
  final TextEditingController bottlePriceController = TextEditingController();
  final TextEditingController shopPasswordController = TextEditingController();

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
  final PageController pageControllerForRegister = PageController();
  final RxInt totalSteps = 6.obs;
  final RxInt currentStep = 0.obs;

  final PageController pageControllerForOnBoarding = PageController();
  final RxInt totalStepsForOnBoardings = 3.obs;
  final RxInt currentStepForOnBoardings = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentLocation();
  }

  bool authtentication(int registrationStep, BuildContext context) {
    if (registrationStep == 0) {
      if (ownerNameController.text.isEmpty) {
        HelperFunctions.displayToastMessage(
            'Owner Name', 'Please provide shop owner name', context);
        return false;
      }
      if (shopNameController.text.isEmpty) {
        HelperFunctions.displayToastMessage(
            'Shop Name', 'Shop Name Field can\'t be empty', context);
        return false;
      }
      return true;
    } else if (registrationStep == 1) {
      if (shopEmailController.text.isEmpty) {
        HelperFunctions.displayToastMessage(
            'Email Address', "The email you provide is not valid", context);
        return false;
      }
      if (shopPhoneController.text.isEmpty) {
        HelperFunctions.displayToastMessage("Phone Number",
            "The Phone Number you provide is not valid", context);
        return false;
      }
      return true;
    } else if (registrationStep == 2) {
      if (totalBottlesController.text.isEmpty ||
          totalGalonsController.text.isEmpty) {
        HelperFunctions.displayToastMessage(
            "Quantity", 'The Field can\'t be empty', context);
        return false;
      }
      return true;
    } else if (registrationStep == 3) {
      if (shopImage.value == null) {
        HelperFunctions.displayToastMessage(
            'Shop Image', 'Provide Your Shop Image', context);
        return false;
      }
      if (cnicFrontImage.value == null) {
        HelperFunctions.displayToastMessage(
            'CNIC Front Image', 'Provide Your CNIC Front image', context);
        return false;
      }
      if (cnicBackImage.value == null) {
        HelperFunctions.displayToastMessage(
            'CNIC Back Image', 'Provide Your CNIC Back image', context);
        return false;
      }
      return true;
    } else if (registrationStep == 4) {
      if (currentAddress.isEmpty) {
        HelperFunctions.displayToastMessage(
            'Shop Address', 'Provide Your Shop Address', context);
        return false;
      }
      return true;
    } else {
      if (selectedDeliveryOptions.isEmpty) {
        HelperFunctions.displayToastMessage(
            'Delivery Days', 'Select your delivery days', context);
        return false;
      }
      if (deliveryTimes.isEmpty) {
        HelperFunctions.displayToastMessage(
            'Delivery Timings', 'Add shift to delivering water', context);
        return false;
      }

      saveShopData();
      return true;
    }
  }

  Future<void> pickShopImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      shopImage.value = image;
    }
  }

  Future<void> pickCnicFrontImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      cnicFrontImage.value = image;
    }
  }

  Future<void> pickCnicBackImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      cnicBackImage.value = image;
    }
  }

  void selectDeliveryOption(String option) {
    if (selectedDeliveryOptions.contains(option)) {
      selectedDeliveryOptions.remove(option);
    } else {
      selectedDeliveryOptions.add(option);
    }
  }

  Future<void> pickDeliveryTime() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      deliveryTimes.add({'time': selectedTime});
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

      final userId = await createFirebaseUser();
      if (userId == null) return;

      final shopFolder = "shops/${shopNameController.text}";

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
        shopId: userId,
        ownerName: ownerNameController.text.trim(),
        shopName: shopNameController.text.trim(),
        shopDescription: shopDescriptionController.text.trim(),
        shopEmail: shopEmailController.text.trim(),
        shopPhone: int.tryParse(shopPhoneController.text),
        shopImage: shopImageResponse.data,
        shopLocation: ShopLocation(
          shopAddress: currentAddress.value,
          latitude: currentLocation.value?.latitude,
          longitude: currentLocation.value?.longitude,
        ),
        deliveryOptions: selectedDeliveryOptions,
        deliveryTimes: deliveryTimes.map((time) {
          return DeliveryTime(
            time: formatTimeOfDay(time['time']!),
          );
        }).toList(),
        ownerCnic: OwnerCnic(
          cnicFront: cnicFrontResponse.data!,
          cnicBack: cnicBackResponse.data!,
        ),
        bottles: Bottles(
          totalGalons: int.tryParse(totalGalonsController.text),
          totalBottles: int.tryParse(totalBottlesController.text),
          galonPrice: double.tryParse(galonPriceController.text),
          bottlePrice: double.tryParse(bottlePriceController.text),
        ),
        accountApprove: false,
        isCertified: false,
        shopRating: 0.0,
      );

      final firestoreResponse = await shopService.saveShopToFirestore(shop);
      if (!firestoreResponse.isSuccess) {
        throw Exception(firestoreResponse.errorMessage);
      }

      await ShopLocalStorageService.saveShopDataToLocalStorage(
        userId: userId,
        ownerName: ownerNameController.text.trim(),
        shopName: shopNameController.text.trim(),
        shopDescription: shopDescriptionController.text.trim(),
        shopEmail: shopEmailController.text.trim(),
        shopPhone: shopPhoneController.text,
        shopImage: shopImageResponse.data!,
        shopAddress: currentAddress.value,
        latitude: currentLocation.value?.latitude,
        longitude: currentLocation.value?.longitude,
        selectedDeliveryOptions: selectedDeliveryOptions,
        deliveryTimes: deliveryTimes,
        cnicFront: cnicFrontResponse.data!,
        cnicBack: cnicBackResponse.data!,
        totalGalons: totalGalonsController.text,
        totalBottles: totalBottlesController.text,
        galonPrice: galonPriceController.text,
        bottlePrice: bottlePriceController.text,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isRequestPending", true);
      log("Shop data saved successfully!");
      isLoading.value = false;
      Get.offAll(() => RequestApprovalScreen());
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  Future<String?> createFirebaseUser() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: shopEmailController.text.trim(),
        password: shopPasswordController.text.trim(),
      );
      return userCredential.user?.uid;
    } catch (e) {
      Get.snackbar("Error", "Failed to create user: $e");
      return null;
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
        controller
            .animateCamera(CameraUpdate.newLatLng(currentLocation.value!));
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
        List<geocoding.Placemark> placemarks =
            await geocoding.placemarkFromCoordinates(
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
