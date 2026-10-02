// screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/utils/mob_size.dart';
import 'package:movies_app/screens/home/tabs/browse_tab.dart';
import 'package:movies_app/screens/home/tabs/homeTab/home_tab.dart';
import 'package:movies_app/screens/home/tabs/profileTab/profile_tab.dart';
import 'package:movies_app/screens/home/tabs/searchTab/searchTab.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> tabsList =  [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: tabsList[selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.03,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: context.height * 0.08,
              child: BottomNavigationBar(
                currentIndex: selectedIndex,
                backgroundColor: AppColors.darkGrey,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 0,
                unselectedFontSize: 0,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                items: [
                  buildBottomNavItem(
                    iconPath: AppAssets.homeIcon,
                    isSelected: selectedIndex == 0,
                  ),
                  buildBottomNavItem(
                    iconPath: AppAssets.searchIcon,
                    isSelected: selectedIndex == 1,
                  ),
                  buildBottomNavItem(
                    iconPath: AppAssets.browseIcon,
                    isSelected: selectedIndex == 2,
                  ),
                  buildBottomNavItem(
                    iconPath: AppAssets.profileIcon,
                    isSelected: selectedIndex == 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavItem({
    required String iconPath,
    required bool isSelected,
  }) {
    final double iconSize = context.width * 0.060;
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconPath,
        width: iconSize,
        height: iconSize,
        colorFilter: ColorFilter.mode(
          isSelected ? AppColors.primaryColor : AppColors.whiteColor,
          BlendMode.srcIn,
        ),
      ),
      label: '',
    );
  }
}