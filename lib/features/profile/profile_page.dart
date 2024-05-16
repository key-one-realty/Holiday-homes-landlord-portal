import "package:flutter/material.dart";
import "package:landlord_portal/components/shared/border_line.dart";
import "package:landlord_portal/components/shared/bottom_border_container.dart";
import "package:landlord_portal/components/shared/card_container.dart";
import "package:landlord_portal/components/shared/custom_app_bar.dart";
import "package:landlord_portal/config/colors.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: "Profile",
        goBack: true,
      ),
      body: BottomBorderContainer(
        child: Column(
          children: [
            CardContainer(
              customHeight: 280,
              hasBtn: true,
              buttonText: 'Logout',
              cardHeader: "My Profile",
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 78,
                        height: 78,
                        decoration: ShapeDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/user_pic.png'),
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name Surname",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: 12,
                                height: 12,
                                child: Icon(
                                  Icons.email,
                                  color: kRedAccent,
                                  size: 12,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                'email@email.ko',
                                style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: 12,
                                height: 12,
                                child: Icon(
                                  Icons.phone,
                                  color: kRedAccent,
                                  size: 12,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '+971 23 456 7890',
                                style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 12,
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
                  const SizedBox(
                    height: 30,
                  ),
                  const BorderLine(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
