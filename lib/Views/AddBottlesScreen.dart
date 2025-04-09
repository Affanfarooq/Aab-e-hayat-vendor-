import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwapController extends GetxController {
  var isGallonSelected = true.obs;
  var dragOffset = 0.0.obs;
  var gallonCount = 0.obs;
  var bottleCount = 0.obs;

  void toggleSelection() {
    isGallonSelected.value = !isGallonSelected.value;
  }

  void increment() {
    if (isGallonSelected.value) {
      gallonCount.value++;
    } else {
      bottleCount.value++;
    }
  }

  void decrement() {
    if (isGallonSelected.value) {
      if (gallonCount.value > 0) gallonCount.value--;
    } else {
      if (bottleCount.value > 0) bottleCount.value--;
    }
  }

  void onDragUpdate(DragUpdateDetails details) {
    dragOffset.value += details.delta.dx;
  }

  void onDragEnd(DragEndDetails details) {
    if (dragOffset.value > 50) {
      isGallonSelected.value = true;
    } else if (dragOffset.value < -50) {
      isGallonSelected.value = false;
    }
    dragOffset.value = 0.0;
  }
}

class AddBottles extends StatelessWidget {
  final SwapController controller = Get.put(SwapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 300,
                height: 250,
                child: Obx(() {
                  double bigSize = 200;
                  double smallSize = 120;
                  double containerHeight = 250;

                  return GestureDetector(
                    onHorizontalDragUpdate: controller.onDragUpdate,
                    onHorizontalDragEnd: controller.onDragEnd,
                    onTap: controller.toggleSelection,
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                          left: controller.isGallonSelected.value ? 0 : 180,
                          top: (containerHeight -
                                  (controller.isGallonSelected.value
                                      ? bigSize
                                      : smallSize)) /
                              2,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: controller.isGallonSelected.value
                                ? bigSize
                                : smallSize,
                            height: controller.isGallonSelected.value
                                ? bigSize
                                : smallSize,
                            child: Image.asset(
                              'assets/images/galon.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                          left: controller.isGallonSelected.value ? 180 : 0,
                          top: (containerHeight -
                                  (controller.isGallonSelected.value
                                      ? smallSize
                                      : bigSize)) /
                              2,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: controller.isGallonSelected.value
                                ? smallSize
                                : bigSize,
                            height: controller.isGallonSelected.value
                                ? smallSize
                                : bigSize,
                            child: Image.asset(
                              'assets/images/botle.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: 20),
          Obx(
            () => AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Text(
                controller.isGallonSelected.value
                    ? 'Gallon Count'
                    : 'Bottle Count',
                key: ValueKey(
                    controller.isGallonSelected.value), 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: controller.decrement,
                icon: Icon(Icons.remove_circle, color: Colors.blue),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Obx(
                  () => AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Text(
                      controller.isGallonSelected.value
                          ? '${controller.gallonCount.value}'
                          : '${controller.bottleCount.value}',
                      key: ValueKey(controller
                          .isGallonSelected.value), // Unique key for switch
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: controller.increment,
                icon: Icon(Icons.add_circle, color: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
