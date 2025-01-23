import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Controllers/ShopAuthController.dart';

class MapScreen extends StatelessWidget {
  final ShopAuthController controller = Get.find<ShopAuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Location')),
      body:
       Obx(() {
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: controller.currentLocation.value ??
                    LatLng(37.7749, -122.4194), // Default: San Francisco
                zoom: 15,
              ),
              onMapCreated: (GoogleMapController mapController) {
                if (!controller.mapController.isCompleted) {
                  controller.mapController.complete(mapController);
                }
              },
              myLocationEnabled: true,
              markers: {
                if (controller.currentLocation.value != null)
                  Marker(
                    markerId: MarkerId("current_position"),
                    position: controller.currentLocation.value!,
                  ),
              },
              onCameraMove: (CameraPosition position) {
                controller.onMapDragged(position.target);
              },
              onTap: (LatLng position) {
                controller.onMapTapped(position);
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
                        controller.currentAddress.value,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (controller.currentLocation.value != null) {
                            Get.back(result: controller.currentLocation.value);
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
}
