import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:landlord_portal/components/shared/border_line.dart";
import "package:landlord_portal/components/shared/bottom_border_container.dart";
import "package:landlord_portal/components/shared/card_container.dart";
import "package:landlord_portal/components/shared/custom_app_bar.dart";
import "package:landlord_portal/config/colors.dart";
import "package:landlord_portal/features/authentication/login.dart";
import "package:landlord_portal/features/home/view_model/user_view_model.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: "Profile",
        goBack: true,
      ),
      body: Consumer<UserProvider>(
        builder: (context, value, child) => BottomBorderContainer(
          child: Column(
            children: [
              CardContainer(
                customHeight: 280.r,
                hasBtn: true,
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  prefs.remove("accessToken");
                  if (context.mounted) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (builder) => const Login(),
                      ),
                    );
                  }
                },
                buttonText: 'Logout',
                cardHeader: "My Profile",
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 78.r,
                          height: 78.r,
                          decoration: ShapeDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/images/user_pic.png'),
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r)),
                          ),
                        ),
                        20.horizontalSpace,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Text(
                                value.landlordName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0.spMin,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: 12.r,
                                  height: 12.r,
                                  child: Icon(
                                    Icons.email,
                                    color: kRedAccent,
                                    size: 12.r,
                                  ),
                                ),
                                4.horizontalSpace,
                                Text(
                                  value.landlordEmail,
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: 12.spMin,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            4.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: 12.r,
                                  height: 12.r,
                                  child: Icon(
                                    Icons.phone,
                                    color: kRedAccent,
                                    size: 12.spMin,
                                  ),
                                ),
                                4.horizontalSpace,
                                Text(
                                  value.landlordPhoneNumber,
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: 12.spMin,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    30.verticalSpace,
                    const BorderLine(),
                    20.verticalSpace
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
