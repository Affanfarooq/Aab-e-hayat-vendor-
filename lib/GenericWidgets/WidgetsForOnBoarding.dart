import 'dart:io';

import 'package:aabehayat_vendor/Const/design_const.dart';
import 'package:aabehayat_vendor/Controllers/ShopAuthController.dart';
import 'package:aabehayat_vendor/GenericWidgets/textfield/app_text_form_field.dart';
import 'package:aabehayat_vendor/Views/authentication/widget/registration_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

Widget buildStep(
    String heading, String description, String image, double imageSize) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/$image',
            height: imageSize,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 50),
          Text(
            heading,
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.w500, color: kTextColor),
          ),
          const SizedBox(height: 15),
          Text(
            description,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
        ],
      ),
    ),
  );
}

Widget buildIntroScreen(ShopAuthController shopController) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const SizedBox(height: 120),
            SvgPicture.asset('assets/images/splash.svg', height: 130),
            const SizedBox(height: 20),
            const Text(
              "AABEHAYAT",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              "Aapki zarrorat hamari zimydari",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Text(
            "Smart solution for effortless water supply management.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    ),
  );
}

Widget buildRegistrationScreen(ShopAuthController shopController) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text(
        "Register Your Shop",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 16),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "To start using AABEHAYAT, you need to register your shop. Tap below to continue.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
      SizedBox(height: 30),

      // ✅ Register Button
      ElevatedButton(
        onPressed: () {
          Get.to(() => RegistrationScreen()); // Navigate to Registration Page
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          "Register Now",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    ],
  );
}

Widget buildBasicInformationForm(ShopAuthController shopController,
    {required String heading, required String description}) {
  return ListView(
    padding: EdgeInsets.symmetric(horizontal: 15),
    shrinkWrap: true,
    children: [
      Column(
        children: [
          const SizedBox(height: 15),
          Text(
            heading,
            style:  GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.w500, color: kTextColor),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              description,
              style:  GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      buildInputField(shopController.ownerNameController, "Owner Name",
          icon: 'name.svg'),
      SizedBox(
        height: 10,
      ),
      buildInputField(shopController.shopNameController, "Shop Name",
          icon: 'shopname.svg'),
      SizedBox(
        height: 10,
      ),
      buildInputField(
          shopController.shopDescriptionController, "Shop Description",
          icon: 'description.svg'),
    ],
  );
}

Widget buildContactInformationForm(ShopAuthController shopController,
    {required String heading, required String description}) {
  return ListView(
    padding: EdgeInsets.symmetric(horizontal: 15),
    shrinkWrap: true,
    children: [
      Column(
        children: [
          const SizedBox(height: 15),
          Text(
            heading,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      buildInputField(shopController.shopEmailController, "Email address",
          icon: 'email.svg', keyboardType: TextInputType.emailAddress),
      SizedBox(
        height: 10,
      ),
      buildInputField(shopController.shopPhoneController, "Phone No",
          icon: 'phone.svg', keyboardType: TextInputType.phone),
      SizedBox(
        height: 10,
      ),
      buildInputField(shopController.shopPhoneController, "Password",
          icon: 'password.svg', keyboardType: TextInputType.phone),
    ],
  );
}

Widget buildInventoryForm(ShopAuthController shopController,
    {required String heading, required String description}) {
  return ListView(
    padding: EdgeInsets.symmetric(horizontal: 15),
    shrinkWrap: true,
    children: [
      Column(
        children: [
          const SizedBox(height: 15),
          Text(
            heading,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      buildInputField(shopController.totalGalonsController, "Total Bottles",
          keyboardType: TextInputType.number, icon: 'Water_Bottle.svg'),
      SizedBox(
        height: 10,
      ),
      buildInputField(
        shopController.totalBottlesController,
        "Bottle Price",
        keyboardType: TextInputType.number,
      ),
      SizedBox(
        height: 10,
      ),
      buildInputField(shopController.totalGalonsController, "Total Gallons",
          keyboardType: TextInputType.number, icon: 'Water_Gallon.svg'),
      SizedBox(
        height: 10,
      ),
      buildInputField(shopController.totalBottlesController, "Gallon Price",
          keyboardType: TextInputType.number),
    ],
  );
}

Widget buildShopImagesForm(ShopAuthController shopController,
    {required String heading, required String description}) {
  return Expanded(
    child: ListView(
      padding: EdgeInsets.symmetric(horizontal: 15),
      children: [
        Column(
          children: [
            const SizedBox(height: 15),
            Text(
              heading,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                description,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: buildImagePicker("Select Shop Image",
                  shopController.pickShopImage, shopController.shopImage),
            ),
            Expanded(
              child: buildImagePicker(
                  "Select CNIC Front Image",
                  shopController.pickCnicFrontImage,
                  shopController.cnicFrontImage),
            ),
            Expanded(
              child: buildImagePicker(
                  "Select CNIC Back Image",
                  shopController.pickCnicBackImage,
                  shopController.cnicBackImage),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildLocationForm(ShopAuthController shopController,
    {required String heading, required String description}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Obx(() {
        return Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 15),
                Text(
                  heading,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kTextColor),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    description,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DottedBorder(
                  color: Colors.grey,
                  strokeWidth: 2,
                  radius: Radius.circular(12),
                  dashPattern: [8, 4],
                  borderType: BorderType.RRect,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: shopController.currentLocation.value ??
                            LatLng(37.7749, -122.4194),
                        zoom: 15,
                      ),
                      onMapCreated: (GoogleMapController mapController) {
                        if (!shopController.mapController.isCompleted) {
                          shopController.mapController.complete(mapController);
                        }
                      },
                      myLocationEnabled: true,
                      markers: {
                        if (shopController.currentLocation.value != null)
                          Marker(
                            markerId: MarkerId("current_position"),
                            position: shopController.currentLocation.value!,
                          ),
                      },
                      onCameraMove: (CameraPosition position) {
                        shopController.onMapDragged(position.target);
                      },
                      onTap: (LatLng position) {
                        shopController.onMapTapped(position);
                      },
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 170,
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Your Shop Location",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      shopController.currentAddress.value,
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     if (shopController.currentLocation.value != null) {
                    //       Get.back(
                    //           result: shopController.currentLocation.value);
                    //     } else {
                    //       Get.snackbar("Error", "Please select a location.");
                    //     }
                    //   },
                    //   child: Text("Confirm Location"),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    ),
  );
}

Widget buildDeliveryOptions(ShopAuthController shopController,
    {required String heading, required String description}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const SizedBox(height: 15),
            Text(
              heading,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                description,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        const Text("Choose the days you will be delivering.",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Obx(
          () => Wrap(
            spacing: 10,
            children: ["Daily", "Weekly", "Day by day"].map((option) {
              return ChoiceChip(
                label: Text(option),
                selected:
                    shopController.selectedDeliveryOptions.contains(option),
                onSelected: (isSelected) {
                  shopController.selectDeliveryOption(option);
                },
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 10),
        const Text("Add your delivery times",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            await shopController.pickDeliveryTime();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Icon(Icons.access_time, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Add Delivery Times',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
        Obx(() {
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: shopController.deliveryTimes.length,
            itemBuilder: (context, index) {
              final time = shopController.deliveryTimes[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                    "From: ${shopController.formatTimeOfDay(time['start']!)} - To: ${shopController.formatTimeOfDay(time['end']!)}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    shopController.deliveryTimes.removeAt(index);
                  },
                ),
              );
            },
          );
        }),
      ],
    ),
  );
}

Widget buildInputField(
  TextEditingController controller,
  String label, {
  TextInputType keyboardType = TextInputType.text,
  String? icon,
}) {
  return AppTextField(
    controller: controller,
    hintText: label,
    iconPath: "assets/images/${icon}",
  );
}

Widget buildImagePicker(
    String label, VoidCallback onPressed, Rx<XFile?> imageFile) {
  return GestureDetector(
    onTap: onPressed,
    child: DottedBorder(
      color: Colors.grey.withOpacity(0.5),
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      dashPattern: const [6, 3],
      strokeWidth: 2,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Obx(() {
          return imageFile.value == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                    SizedBox(height: 10),
                    Text(
                      label,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(imageFile.value!.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: () {
                          imageFile.value = null;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(
                            Icons.clear,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        }),
      ),
    ),
  );
}

  // Widget buildCustomProgressIndicator() {
  //   int completedSteps = _currentStep.value + 1;

  //   return StepProgressIndicator(
  //     totalSteps: _totalSteps,
  //     currentStep: completedSteps,
  //     selectedColor: kPrimaryColor,
  //     unselectedColor: Colors.blue.shade200,
  //     roundedEdges: Radius.circular(20),
  //     size: 6,
  //   );
  // }
