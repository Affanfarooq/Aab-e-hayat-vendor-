import 'package:aabehayat_vendor/Const/design_const.dart';
import 'package:aabehayat_vendor/Views/AddBottlesScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Map<String, String>> users = [
    {'name': 'Umar Jahangir', 'location': 'Gulshan-e-Iqbal block-2'},
    {'name': 'Ahmed Ali', 'location': 'Gulshan-e-Iqbal block-2'},
    {'name': 'Sufiyan Mukeem', 'location': 'Gulshan-e-Iqbal block-2'},
    {'name': 'Sameena Sajjad', 'location': 'Gulshan-e-Iqbal block-2'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            labelStyle: GoogleFonts.poppins(
              fontSize: 15,
            ),
            tabs: const [
              Tab(text: 'Not Delivered'),
              Tab(text: 'Delivered'),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_notDeliveredList(), _deliveredList()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _notDeliveredList() {
    return Column(
      children: [
        const SizedBox(height: 12),
        Text(
          'Delivery',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Only deliveries for today (Tuesday, March 26) will be shown here.',
            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 15),
        ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Padding(
              padding: const EdgeInsets.all(6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ExpansionTile(
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: () {
                        Get.to(()=>AddBottles());
                      },
                      icon: SvgPicture.asset(
                        'assets/images/adddelivery.svg',
                        height: 30,
                      ),
                    ),
                  ),
                  collapsedBackgroundColor: Colors.grey[50],
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
                    padding: const EdgeInsets.only(left: 18, top: 8, bottom: 8),
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
                        SvgPicture.asset(
                          'assets/images/arrowdown.svg',
                        ),
                      ],
                    ),
                  ),
                  children: [
                    Text(
                      user['location']!,
                      style:
                          GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _deliveredList() {
    return Column(
      children: [
        const SizedBox(height: 12),
        Text(
          'Delivered',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Only deliveries for today (Tuesday, March 26) will be shown here.',
            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 15),
        ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Padding(
              padding: const EdgeInsets.all(6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ExpansionTile(
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: () {},
                      icon:  SvgPicture.asset(
                        'assets/images/check.svg',
                        height: 22,
                      ),
                    ),
                  ),
                  collapsedBackgroundColor: kSecondaryColor,
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
                    padding: const EdgeInsets.only(left: 18, top: 8, bottom: 8),
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
                         SvgPicture.asset(
                          'assets/images/arrowdown.svg',
                        ),
                      ],
                    ),
                  ),
                  children: [
                    Text(
                      user['location']!,
                      style:
                          GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
