import 'dart:io';
import 'dart:ui' as ui;
import 'package:aabehayat_vendor/Const/design_const.dart';
import 'package:aabehayat_vendor/Controllers/ShopAuthController.dart';
import 'package:aabehayat_vendor/GenericWidgets/CustomButton.dart';
import 'package:aabehayat_vendor/GenericWidgets/textfield/app_text_form_field.dart';
import 'package:aabehayat_vendor/utils/screen_helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../GenericWidgets/CustomDesign/circle_design.dart';

class ShopRegistrationScreen extends StatefulWidget {
  const ShopRegistrationScreen({super.key});

  @override
  State<ShopRegistrationScreen> createState() => _ShopRegistrationScreenState();
}

class _ShopRegistrationScreenState extends State<ShopRegistrationScreen> {
  final ShopAuthController shopController = Get.put(ShopAuthController());
  final PageController _pageController = PageController();
  final int _totalSteps = 6;
  final RxInt _currentStep = 0.obs;

  @override
  Widget build(BuildContext context) {
    double width = ScreenHelper.getScreenWidth(context);
    double height = ScreenHelper.getScreenHeight(context);
    return Scaffold(
      floatingActionButton: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (_currentStep.value > 0)
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  backgroundColor: kPrimaryColor,
                  shape: CircleBorder(),
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            SizedBox(width: 10),
            if (_currentStep.value < _totalSteps - 1)
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    print(_currentStep);
                    var authenticate =
                        shopController.authtentication(_currentStep.value);
                    if (authenticate == true) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  shape: CircleBorder(),
                  backgroundColor: kPrimaryColor,
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
            if (_currentStep.value == _totalSteps - 1)
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    shopController.authtentication(6);
                  },
                  backgroundColor: Colors.green.shade600,
                  shape: CircleBorder(),
                  child: Icon(Icons.check, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          CustomPaint(
            size: ui.Size(width, (height * 0.7665350318471338).toDouble()),
            painter: CircleDesign(),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Shop Registration",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kTextColor),
                      ),
                    ],
                  ),
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 20),
                      child: _buildCustomProgressIndicator(),
                    )),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) => _currentStep.value = index,
                    children: [
                      _buildStep(
                          "Basic Information",
                          "Please provide the basic details of your shop.",
                          _buildBasicInformationForm()),
                      _buildStep(
                          "Contact Information",
                          "Provide your email and phone number for communication.",
                          _buildContactInformationForm()),
                      _buildStep(
                          "Inventory Information",
                          "Enter the total number of gallons and bottles available in your shop.",
                          _buildInventoryForm()),
                      _buildStep(
                          "Upload Images",
                          "Upload images of your shop, CNIC front, and CNIC back for verification.",
                          _buildShopImagesForm()),
                      _buildStep(
                          "Your Shop Location",
                          "Select the location of your shop on the map.",
                          _buildLocationForm()),
                      _buildStep(
                          "Delivery Schedule",
                          "Select your delivery days and add delivery times.",
                          _buildDeliveryOptions()),
                    ],
                  ),
                ),
                // Obx(
                //   () => Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         if (_currentStep.value > 0)
                //           Expanded(
                //             child: Padding(
                //               padding: const EdgeInsets.only(right: 10),
                //               child: CustomSpringButton(
                //                 onPressed: () {
                //                   _pageController.previousPage(
                //                     duration: const Duration(milliseconds: 300),
                //                     curve: Curves.easeInOut,
                //                   );
                //                 },
                //                 text: "Back",
                //               ),
                //             ),
                //           ),
                //         if (_currentStep.value < _totalSteps - 1)
                //           Expanded(
                //             child: CustomSpringButton(
                //               onPressed: () {
                //                 _pageController.nextPage(
                //                   duration: const Duration(milliseconds: 300),
                //                   curve: Curves.easeInOut,
                //                 );
                //               },
                //               text: "Next",
                //             ),
                //           ),
                //         if (_currentStep.value == _totalSteps - 1)
                //           Expanded(
                //             child: CustomSpringButton(
                //               onPressed: shopController.saveShopData,
                //               text: "Submit",
                //             ),
                //           ),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String heading, String description, Widget content) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          heading != "Your Shop Location"
              ? Column(
                  children: [
                    Text(
                      heading,
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: kLightGreyTextColor),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: kLightGreyTextColor),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                  ],
                )
              : SizedBox(),
          content,
        ],
      ),
    );
  }

  Widget _buildBasicInformationForm() {
    return Center(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 40,
          ),
          _buildInputField(shopController.ownerNameController, "Owner Name"),
          SizedBox(
            height: 10,
          ),
          _buildInputField(shopController.shopNameController, "Shop Name"),
          SizedBox(
            height: 10,
          ),
          _buildInputField(
              shopController.shopDescriptionController, "Shop Description"),
        ],
      ),
    );
  }

  Widget _buildContactInformationForm() {
    return Center(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 40,
          ),
          _buildInputField(shopController.shopEmailController, "Email address",
              keyboardType: TextInputType.emailAddress),
          SizedBox(
            height: 10,
          ),
          _buildInputField(shopController.shopPhoneController, "Phone No",
              keyboardType: TextInputType.phone),
        ],
      ),
    );
  }

  Widget _buildInventoryForm() {
    return Center(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 40,
          ),
          _buildInputField(
              shopController.totalGalonsController, "Total Gallons",
              keyboardType: TextInputType.number),
          SizedBox(
            height: 10,
          ),
          _buildInputField(
              shopController.totalBottlesController, "Total Bottles",
              keyboardType: TextInputType.number),
        ],
      ),
    );
  }

  Widget _buildShopImagesForm() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          SizedBox(
            height: 10,
          ),
          _buildImagePicker("Select Shop Image", shopController.pickShopImage,
              shopController.shopImage),
          _buildImagePicker("Select CNIC Front Image",
              shopController.pickCnicFrontImage, shopController.cnicFrontImage),
          _buildImagePicker("Select CNIC Back Image",
              shopController.pickCnicBackImage, shopController.cnicBackImage),
        ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return AppTextField(
      controller: controller,
      hintText: label,
    );
  }

  Widget _buildImagePicker(
      String label, VoidCallback onPressed, Rx<XFile?> imageFile) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: DottedBorder(
            color: Colors.grey.withOpacity(0.5),
            borderType: BorderType.RRect,
            radius: const Radius.circular(10),
            dashPattern: const [6, 3],
            strokeWidth: 2,
            child: Container(
              width: Get.width,
              height: 250,
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
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildLocationForm() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Obx(() {
          return Column(
            children: [
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
                            shopController.mapController
                                .complete(mapController);
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

  Widget _buildDeliveryOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
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
              itemCount: shopController.deliveryTimes.length,
              itemBuilder: (context, index) {
                final time = shopController.deliveryTimes[index];
                return ListTile(
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

  Widget _buildCustomProgressIndicator() {
    int completedSteps = _currentStep.value + 1;

    return StepProgressIndicator(
      totalSteps: _totalSteps,
      currentStep: completedSteps,
      selectedColor: kPrimaryColor,
      unselectedColor: Colors.blue.shade200,
      roundedEdges: Radius.circular(20),
      size: 6,
    );
  }
}
