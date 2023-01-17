import 'package:epoultry/pages/extensions/dashboard_page.dart';
import 'package:epoultry/pages/extensions/farm_visits.dart';
import 'package:epoultry/pages/extensions/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors.dart';

class ExtensionHomePage extends StatefulWidget {
  const ExtensionHomePage({super.key});

  @override
  State<ExtensionHomePage> createState() => _ExtensionHomePageState();
}

class _ExtensionHomePageState extends State<ExtensionHomePage> {
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    const DashboardPage(),
    const FarmVisits(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 8.h,
        backgroundColor: CustomColors.white,
        elevation: 0.5,
        title: const Text(
          "Hi Margaret",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: IndexedStack(
        key: UniqueKey(),
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: CustomColors.background,
        selectedItemColor: CustomColors.primary,
        unselectedItemColor: CustomColors.secondary,
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.houseLine),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.clipboardBold), label: "Farm Visits"),
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.userCircle), label: "Profile"),
          // BottomNavigationBarItem(
          //     icon: Icon(PhosphorIcons.shoppingCart), label: "Ecommerce"),
        ],
      ),
    );
  }
}