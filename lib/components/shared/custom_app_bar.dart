// import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landlord_portal/config/colors.dart';
// import 'package:landlord_portal/features/notifications/notification_screen.dart';
import 'package:landlord_portal/features/profile/profile_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      required this.appBarTitle,
      this.goBack = false,
      this.onPressLeadingIcon});

  final String appBarTitle;
  final bool goBack;
  final void Function()? onPressLeadingIcon;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  Icon get icon => !goBack
      ? Icon(
          Icons.person_2_outlined,
          color: Colors.white,
          size: 20.r,
        )
      : Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 20.r,
        );

  IconData get iconData => appBarTitle != "Notifications"
      ? Icons.notifications_none
      : Icons.notifications;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100.0.r),
      child: AppBar(
        // toolbarHeight: kToolbarHeight + 50.r,
        title: Padding(
          padding: EdgeInsets.all(15.0.r),
          child: Text(
            appBarTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
        leading: IconButton(
            icon: icon,
            onPressed: () {
              if (!goBack) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            }),
        // actions: [
        //   badge.Badge(
        //     position: badge.BadgePosition.topEnd(top: 6.r, end: 8.r),
        //     stackFit: StackFit.passthrough,
        //     badgeContent: Container(
        //       width: 3.r,
        //       height: 3.r,
        //       decoration: const ShapeDecoration(
        //         color: Color(0xFFEB3D5E),
        //         shape: OvalBorder(),
        //       ),
        //     ),
        //     child: IconButton(
        //       icon: Icon(iconData, color: Colors.white),
        //       onPressed: () {
        //         // Scaffold.of(context).openDrawer();
        //         if (appBarTitle != "Notifications") {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => const NotificationScreen()));
        //         } else {
        //           Navigator.pop(context);
        //         }
        //       },
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
