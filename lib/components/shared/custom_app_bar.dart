// import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landlord_portal/config/colors.dart';
// import 'package:landlord_portal/features/notifications/notification_screen.dart';
import 'package:landlord_portal/features/profile/profile_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.appBarTitle,
    this.goBack = false,
    this.onPressLeadingIcon,
  });

  final dynamic appBarTitle;
  final bool goBack;
  final void Function()? onPressLeadingIcon;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  IconData get iconData => appBarTitle != "Notifications"
      ? Icons.notifications_none
      : Icons.notifications;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100.0.r),
      child: AppBar(
        title: Padding(
          padding: EdgeInsets.all(15.0.r),
          child: appBarTitle is String
              ? Text(
                  appBarTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : appBarTitle,
        ),
        backgroundColor: kPrimaryColor,

        // Optional: show back button only if goBack is true
        leading: goBack
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20.r,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null,

        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
              size: 20.r,
            ),
            onPressed: () {
              if (!goBack) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              } else if (onPressLeadingIcon != null) {
                onPressLeadingIcon!();
              }
            },
          ),
        ],
      ),
    );
  }
}

