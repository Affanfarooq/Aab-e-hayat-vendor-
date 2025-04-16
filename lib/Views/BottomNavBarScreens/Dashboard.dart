// ignore_for_file: deprecated_member_use

import 'package:aabehayat_vendor/Utils/DesignConstants.dart';
import 'package:aabehayat_vendor/Views/CustomersScreen.dart';
import 'package:aabehayat_vendor/Widgets/SpringWidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 355,
              floating: false,
              pinned: true,
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dashboard",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 22,
                                          backgroundColor: Colors.grey.shade200,
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "RoPlant.pk",
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/locationIcon.svg',
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "Gulshan-e-Iqbal block-2",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black45,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 42,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.grey.shade200,
                                        width: 1,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          blurRadius: 3,
                                          spreadRadius: 1,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/images/notification.svg',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        incomeCard(),
                        const SizedBox(height: 15),
                        banner(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Overview",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      DeliveryCard(
                        title: 'Today Delivered',
                        subtitle: 'Mon (12-3-2025)',
                        largeBottleQty: '10',
                        smallBottleQty: '05',
                        iconPath: 'assets/images/delivery.svg',
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      DeliveryCard(
                        title: 'Monthly Delivered',
                        subtitle: '(Mar)',
                        largeBottleQty: '100',
                        smallBottleQty: '50',
                        iconPath: 'assets/images/delivery.svg',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      DeliveryCard(
                        title: 'Total Bottles',
                        subtitle: '',
                        largeBottleQty: '25',
                        largeBottleTotal: '/50',
                        smallBottleQty: '15',
                        smallBottleTotal: '/30',
                        iconPath: 'assets/images/bottleIcon.svg',
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      DeliveryCard(
                        title: 'Inhouse Bottles',
                        subtitle: '',
                        largeBottleQty: '25',
                        smallBottleQty: '15',
                        iconPath: 'assets/images/bottleIcon.svg',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  otherInfoCard(),
                ],
              ),
            )),
      ),
    );
  }
}

List<String> bannerImages = [
  'assets/images/banner1.jpg',
  'assets/images/banner2.png',
  'assets/images/banner3.png',
  'assets/images/banner4.jpg',
];

Widget incomeCard() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child:
     Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
      decoration: BoxDecoration(
        color: kThirdColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SpringWidget(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Today Income",
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade500,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(text: "Pkr. "),
                      TextSpan(
                        text: "1,500",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: kForthColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 35,
            color: Colors.grey.shade300,
          ),
          SpringWidget(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Monthly Income",
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade500,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(text: "Pkr. "),
                      TextSpan(
                        text: "1,500",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: kForthColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget otherInfoCard() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    decoration: BoxDecoration(
      color: Color(0xffF9F9F9),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SpringWidget(
          onTap: () {
            Get.to(()=>
                CustomersScreen(),
                transition: Transition.rightToLeft,
                duration: const Duration(milliseconds: 400));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Total Customers",
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade500,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/customers.svg',
                    width: 18,
                    height: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "15",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kForthColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          width: 1,
          height: 35,
          color: Colors.grey.shade300,
        ),
        SpringWidget(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Shop Rating",
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade500,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/ratings.svg',
                    width: 18,
                    height: 18,
                    // color: Colors.grey[400],
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                            text: "4.5 ",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600)),
                        TextSpan(
                          text: "(8 reviews)",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget banner() {
  return Column(
    children: [
      CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 0.9,
          enlargeFactor: 0.2,
          height: 120,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: bannerImages.map((String image) {
          return Builder(
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                  ),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    ],
  );
}

class DeliveryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String largeBottleQty;
  final String smallBottleQty;
  final String? largeBottleTotal;
  final String? smallBottleTotal;
  final String iconPath;
  final VoidCallback onTap;

  const DeliveryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.largeBottleQty,
    required this.smallBottleQty,
    this.largeBottleTotal,
    this.smallBottleTotal,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SpringWidget(
        onTap: onTap,
        child: Container(
          padding:
              const EdgeInsets.only(left: 10, right: 8, top: 12, bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade100,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                spreadRadius: 1.3,
                blurRadius: 2,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle != ''
                          ? Text(
                              subtitle,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.grey[500],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: kThirdColor,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                          iconPath == 'assets/images/delivery.svg' ? 6.5 : 6),
                      child: SvgPicture.asset(
                        iconPath,
                        color: kForthColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBottleInfo(
                    'assets/images/bottleIcon.svg',
                    '$largeBottleQty',
                    largeBottleTotal,
                  ),
                  _buildBottleInfo(
                    'assets/images/galonIcon.svg',
                    '$smallBottleQty',
                    smallBottleTotal,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottleInfo(String iconPath, String quantity, String? total) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: iconPath == 'assets/images/bottleIcon.svg' ? 24 : 22,
          height: iconPath == 'assets/images/bottleIcon.svg' ? 24 : 22,
          color: Colors.grey[400],
        ),
        const SizedBox(width: 7),
        if (total == null)
          Text(
            "Qty : ",
            style: GoogleFonts.poppins(
              fontSize: 9,
              color: Colors.grey.shade500,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(right: 1),
          child: Text(
            quantity,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: kForthColor,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (total != null)
          Padding(
            padding: const EdgeInsets.only(right: 1),
            child: Text(
              total,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
