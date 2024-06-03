import 'package:flutter/material.dart';
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
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home,
              ),
              selectedIcon: Icon(
                Icons.home,
                color: kPrimaryColor,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.folder),
              selectedIcon: Icon(
                Icons.folder,
                color: kPrimaryColor,
              ),
              label: 'My Properties',
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt),
              selectedIcon: Icon(
                Icons.receipt,
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
