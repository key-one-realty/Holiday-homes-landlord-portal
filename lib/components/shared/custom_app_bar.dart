import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:landlord_portal/config/colors.dart';
import 'package:landlord_portal/features/notifications/notification_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, required this.appBarTitle, this.onPressLeadingIcon});

  final String appBarTitle;
  final void Function()? onPressLeadingIcon;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  Icon get icon => appBarTitle != "Notifications"
      ? const Icon(
          Icons.person_2_outlined,
          color: Colors.white,
        )
      : const Icon(
          Icons.arrow_back,
          color: Colors.white,
        );

  IconData get iconData => appBarTitle != "Notifications"
      ? Icons.notifications_none
      : Icons.notifications;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        appBarTitle,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          height: 0,
        ),
      ),
      backgroundColor: kPrimaryColor,
      leading: IconButton(icon: icon, onPressed: onPressLeadingIcon),
      actions: [
        badge.Badge(
          position: badge.BadgePosition.topEnd(top: 6, end: 8),
          stackFit: StackFit.passthrough,
          badgeContent: Container(
            width: 3,
            height: 3,
            decoration: const ShapeDecoration(
              color: Color(0xFFEB3D5E),
              shape: OvalBorder(),
            ),
          ),
          child: IconButton(
            icon: Icon(iconData, color: Colors.white),
            onPressed: () {
              // Scaffold.of(context).openDrawer();
              if (appBarTitle != "Notifications") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
      ],
    );
  }
}
