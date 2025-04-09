import 'dart:io';

import 'package:aabehayat_vendor/Const/design_const.dart';
import 'package:aabehayat_vendor/Controllers/ShopAuthController.dart';
import 'package:aabehayat_vendor/Views/authentication/widget/registration_screen.dart';
import 'package:aabehayat_vendor/Widgets/textfield/app_text_form_field.dart';
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
        children: [
          SizedBox(
            height: 20,
          ),
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

Widget buildBasicInformationForm(ShopAuthController shopController,
    {required String heading, required String description}) {
  return ListView(
    padding: EdgeInsets.symmetric(horizontal: 15),
    shrinkWrap: true,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 30),
        child: SvgPicture.asset(
          'assets/images/registration.svg',
          height: 170,
          key: ValueKey('onboarding1'),
        ),
      ),
      SizedBox(height: 10),
      Column(
        children: [
          const SizedBox(height: 15),
          Text(
            heading,
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.w500, color: kTextColor),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              description,
              style: GoogleFonts.poppins(fontSize: 15, color: Colors.grey),
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
      Padding(
        padding: const EdgeInsets.only(left: 30),
        child: SvgPicture.asset(
          'assets/images/registration.svg',
          height: 170,
          key: ValueKey('onboarding1'),
        ),
      ),
      SizedBox(height: 10),
      Column(
        children: [
          const SizedBox(height: 15),
          Text(
            heading,
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.w500, color: kTextColor),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              description,
              style: GoogleFonts.poppins(fontSize: 15, color: Colors.grey),
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
      buildInputField(shopController.shopPasswordController, "Password",
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
      Padding(
        padding: const EdgeInsets.only(left: 30),
        child: SvgPicture.asset(
          'assets/images/registration.svg',
          height: 170,
          key: ValueKey('onboarding1'),
        ),
      ),
      SizedBox(height: 10),
      Column(
        children: [
          const SizedBox(height: 15),
          Text(
            heading,
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.w500, color: kTextColor),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              description,
              style: GoogleFonts.poppins(fontSize: 15, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      buildInputField(shopController.totalBottlesController, "Total Bottles",
          keyboardType: TextInputType.number, icon: 'Water_Bottle.svg'),
      SizedBox(
        height: 10,
      ),
      buildInputField(
        shopController.bottlePriceController,
        "Bottle Price",
        icon: 'price.svg',
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
      buildInputField(shopController.galonPriceController, "Gallon Price",
          icon: 'price.svg', keyboardType: TextInputType.number),
    ],
  );
}

Widget buildShopImagesForm(ShopAuthController shopController,
    {required String heading, required String description}) {
  return ListView(
    padding: EdgeInsets.symmetric(horizontal: 15),
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 30),
        child: SvgPicture.asset(
          'assets/images/registration.svg',
          height: 170,
          key: ValueKey('onboarding1'),
        ),
      ),
      SizedBox(height: 10),
      Column(
        children: [
          const SizedBox(height: 15),
          Text(
            heading,
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.w500, color: kTextColor),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              description,
              style: GoogleFonts.poppins(fontSize: 15, color: Colors.grey),
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
            child: buildImagePicker("Shop Image", shopController.pickShopImage,
                shopController.shopImage),
          ),
          SizedBox(width: 10),
          Expanded(
            child: buildImagePicker(
                "CNIC Front",
                shopController.pickCnicFrontImage,
                shopController.cnicFrontImage),
          ),
          SizedBox(width: 10),
          Expanded(
            child: buildImagePicker("CNIC Back",
                shopController.pickCnicBackImage, shopController.cnicBackImage),
          ),
        ],
      ),
    ],
  );
}

Widget buildLocationForm(ShopAuthController shopController,
    {required String heading, required String description}) {
  return Obx(() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: SvgPicture.asset(
            'assets/images/registration.svg',
            height: 170,
            key: ValueKey('onboarding1'),
          ),
        ),
        SizedBox(height: 10),
        Column(
          children: [
            const SizedBox(height: 15),
            Text(
              heading,
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kTextColor),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Text(
                description,
                style: GoogleFonts.poppins(fontSize: 15, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 200,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GoogleMap(
                zoomControlsEnabled: false,
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
        // Container(
        //   height: 170,
        //   width: double.infinity,
        //   color: Colors.white,
        //   child: Padding(
        //     padding: const EdgeInsets.all(15.0),
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         SizedBox(
        //           height: 5,
        //         ),
        //         Text(
        //           "Your Shop Location",
        //           style: GoogleFonts.poppins(
        //               fontSize: 16,
        //               color: Colors.black,
        //               fontWeight: FontWeight.w600),
        //           textAlign: TextAlign.center,
        //         ),
        //         SizedBox(height: 10),
        //         Text(
        //           shopController.currentAddress.value,
        //           style: GoogleFonts.poppins(fontSize: 16, color: Colors.black45),
        //           textAlign: TextAlign.center,
        //         ),
        //         SizedBox(height: 10),
        //         // ElevatedButton(
        //         //   onPressed: () {
        //         //     if (shopController.currentLocation.value != null) {
        //         //       Get.back(
        //         //           result: shopController.currentLocation.value);
        //         //     } else {
        //         //       Get.snackbar("Error", "Please select a location.");
        //         //     }
        //         //   },
        //         //   child: Text("Confirm Location"),
        //         // ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  });
}

Widget buildDeliveryOptions(ShopAuthController shopController,
    {required String heading, required String description}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 5),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: SvgPicture.asset(
                'assets/images/registration.svg',
                height: 170,
                key: ValueKey('onboarding1'),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              heading,
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w500, color: kTextColor),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                description,
                style: GoogleFonts.poppins(fontSize: 15, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text("Select Delivery Days.",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Obx(
              () => Wrap(
                spacing: 10,
                runSpacing: 10,
                children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                    .map((option) {
                  return ChoiceChip(
                    backgroundColor: Colors.white,
                    selectedColor: Colors.lightBlue.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        width: shopController.selectedDeliveryOptions
                                .contains(option)
                            ? 1.4
                            : 1,
                        color: shopController.selectedDeliveryOptions
                                .contains(option)
                            ? kPrimaryColor
                            : Colors.grey.shade300,
                      ),
                    ),
                    label: Container(
                      height: 40,
                      width: 40,
                      child: Center(
                        child: Text(option,
                            style: GoogleFonts.poppins(
                                color: shopController.selectedDeliveryOptions
                                        .contains(option)
                                    ? Colors.black
                                    : Colors.grey)),
                      ),
                    ),
                    selected:
                        shopController.selectedDeliveryOptions.contains(option),
                    showCheckmark: false,
                    elevation: 0,
                    pressElevation: 0,
                    onSelected: (isSelected) {
                      shopController.selectDeliveryOption(option);
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select Delivery Times",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      await shopController.pickDeliveryTime();
                    },
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.grey.shade400,
                    )),
              ],
            ),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: shopController.deliveryTimes.length,
                  itemBuilder: (context, index) {
                    final time = shopController.deliveryTimes[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.only(left: 15,top: 3,bottom: 3),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: kPrimaryColor, width: 1.4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "From: ${shopController.formatTimeOfDay(time['time']!)}",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.grey,size: 20,),
                            onPressed: () {
                              shopController.deliveryTimes.removeAt(index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
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
      color: Colors.grey.withOpacity(0.3),
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      dashPattern: const [7, 5],
      strokeWidth: 1.5,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Obx(() {
          return imageFile.value == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 28, color: Colors.grey.shade400),
                      SizedBox(height: 10),
                      Text(
                        label,
                        style: GoogleFonts.poppins(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
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
