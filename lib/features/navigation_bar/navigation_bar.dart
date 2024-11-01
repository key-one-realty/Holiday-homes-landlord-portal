import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landlord_portal/config/colors.dart';
import 'package:landlord_portal/features/home/home_screen.dart';
import 'package:landlord_portal/features/my_properties/properties.dart';
import 'package:landlord_portal/features/statements/statements_screen.dart';
import 'package:landlord_portal/store/navigation_provider.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationModel>(
      builder: (_, value, __) => Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            value.updateCurrentIndex(index);
          },
          indicatorColor: Colors.transparent,
          selectedIndex: value.currentIndex,
          backgroundColor: kbodyPrimaryColor,
          elevation: 0,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home,
                size: 18.r,
              ),
              selectedIcon: Icon(
                Icons.home,
                size: 18.r,
                color: kPrimaryColor,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: const Icon(Icons.folder),
              selectedIcon: Icon(
                Icons.folder,
                size: 18.r,
                color: kPrimaryColor,
              ),
              label: 'My Properties',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.receipt,
                size: 18.0.r,
              ),
              selectedIcon: Icon(
                Icons.receipt,
                size: 18.r,
                color: kPrimaryColor,
              ),
              label: 'Statements',
            ),
          ],
        ),
        body: <Widget>[
          const HomeScreen(),
          const PropertiesScreen(),
          const StatementSreen(),
        ][value.currentIndex],
      ),
    );
  }
}
