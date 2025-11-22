
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/screen/Users/Bundles/bundels_screen.dart';
import 'package:naibrly/views/screen/Users/Home/home_screen.dart';
import 'package:naibrly/views/screen/Users/Profile/profile_screen.dart';
import 'package:naibrly/views/screen/Users/Request/request_screen.dart';

import '../../../controller/BottomController/bottomController.dart';
import 'bottomNavBar.dart';


class BottomMenuWrappers extends StatelessWidget {
  BottomMenuWrappers({super.key});

  final BottomNavController controller = Get.put(BottomNavController());

  // --==-- here bottom nav all pages --==-- ///
  final List<Widget> _pages = [
    HomeScreen(),
    BundelsScreen(),
    RequestScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: controller.selectedIndex.value,
          children: _pages,
        ),
      ),
      extendBody: true,
      bottomNavigationBar: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Container(
          color: AppColors.White,
          child: IosStyleBottomNavigations(
            onTap: controller.selectTab,
            currentIndex:  controller.selectedIndex.value,
          ),
        ),
      ),
    ));
  }
}