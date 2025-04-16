import 'package:aabehayat_vendor/Controllers/DeliveryScreenController.dart';
import 'package:aabehayat_vendor/Views/AddBottlesScreen.dart';
import 'package:aabehayat_vendor/Widgets/CustomContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomersScreen extends StatelessWidget {
  CustomersScreen({super.key});

  final DeliveryController controller = Get.put(DeliveryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Total Customers",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        body: Column(children: [
          Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: controller.users.length,
                itemBuilder: (context, index) {
                  final user = controller.users[index];
                  return Padding(
                    padding: const EdgeInsets.all(6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CustomContainer(
                        child: ExpansionTile(
                          trailing: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 3),
                              child: Container(
                                width: 38,
                                height: 38,
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/direction.svg',
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          tilePadding: const EdgeInsets.all(0),
                          collapsedShape: ShapeBorder.lerp(
                            RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            0.5,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(
                                left: 18, top: 8, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user['name']!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/locationIcon.svg',
                                          height: 14,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          user['location']!,
                                          style: GoogleFonts.poppins(
                                              color: Colors.grey, fontSize: 13),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                // SvgPicture.asset(
                                //   'assets/images/arrowdown.svg',
                                //   width: 13,
                                // ),
                              ],
                            ),
                          ),
                          children: [
                            Text(
                              user['location']!,
                              style: GoogleFonts.poppins(
                                  color: Colors.grey, fontSize: 13),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ]));
  }
}
