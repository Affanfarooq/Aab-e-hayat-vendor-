import 'dart:io';
import 'package:aabehayat_vendor/Controllers/ShopAuthController.dart';
import 'package:aabehayat_vendor/Views/MapScreen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ShopRegistrationScreen extends StatefulWidget {
  const ShopRegistrationScreen({super.key});

  @override
  State<ShopRegistrationScreen> createState() => _ShopRegistrationScreenState();
}

class _ShopRegistrationScreenState extends State<ShopRegistrationScreen> {
  final ShopAuthController shopController = Get.put(ShopAuthController());
  final PageController _pageController = PageController();
  final int _totalSteps = 6; // Updated to 6 steps
  RxInt _currentStep = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop Registration"),
        actions: [
          IconButton(
            onPressed: shopController.clearData,
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() => _buildCustomProgressIndicator()),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) => _currentStep.value = index,
              children: [
                _buildStep("Basic Information", _buildBasicInformationForm()),
                _buildStep("Contact Information", _buildContactInformationForm()),
                _buildStep("Inventory Information", _buildInventoryForm()),
                _buildStep("Upload Images", _buildShopImagesForm()),
                _buildStep("Your Shop Location", _buildLocationForm()),
                _buildStep("Delivery Schedule", _buildDeliveryOptions()),
              ],
            ),
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentStep.value > 0)
                  TextButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text("Back"),
                  ),
                if (_currentStep.value < _totalSteps - 1)
                  ElevatedButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text("Next"),
                  ),
                if (_currentStep.value == _totalSteps - 1)
                  ElevatedButton(
                    onPressed: shopController.saveShopData,
                    child: const Text("Submit"),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStep(String heading, Widget content) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              heading,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            content,
          ],
        ),
      ),
    );
  }

  // Forms for each step
  Widget _buildBasicInformationForm() {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
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
        shrinkWrap: true,
        children: [
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
        shrinkWrap: true,
        children: [
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
        children: [
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
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildImagePicker(
      String label, VoidCallback onPressed, Rx<XFile?> imageFile) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: DottedBorder(
            color: Colors.grey, // Color of the dashed border
            borderType: BorderType.RRect,
            radius: const Radius.circular(10), // Rounded corners
            dashPattern: const [6, 3], // Dash pattern
            strokeWidth: 2,
            child: Container(
              width: Get.width, // Card width
              height: 250, // Card height
              decoration: BoxDecoration(
                color: Colors.grey[100], // Background color
                borderRadius: BorderRadius.circular(10), // Rounded edges
              ),
              child: Obx(() {
                return imageFile.value == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt,
                              size: 40, color: Colors.grey), // Icon
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
                                imageFile.value = null; // Clear the image
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
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLocationForm() {
    return Expanded(
      child: Obx(() {
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: shopController.currentLocation.value ??
                    LatLng(37.7749, -122.4194), // Default: San Francisco
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
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Shop Location",
                        style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                        
                      ),
                      SizedBox(height: 10),
                      Text(
                        shopController.currentAddress.value,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (shopController.currentLocation.value != null) {
                            Get.back(
                                result: shopController.currentLocation.value);
                          } else {
                            Get.snackbar("Error", "Please select a location.");
                          }
                        },
                        child: Text("Confirm Location"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

 

  Widget _buildDeliveryOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select Delivery Days",
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
        const Text("Delivery Times",
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
    );
  }

  Widget _buildCustomProgressIndicator() {
    int completedSteps = _currentStep.value + 1;

    return StepProgressIndicator( 
      totalSteps: _totalSteps,
      currentStep: completedSteps,
      selectedColor: Colors.blue,
      unselectedColor: Colors.grey[300]!,
      roundedEdges: Radius.circular(3),
      size: 5,
    );
  }
}
