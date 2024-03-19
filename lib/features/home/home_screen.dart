import 'package:flutter/material.dart';
import 'package:landlord_portal/components/home_screen/custom_bar_chart.dart';
import 'package:landlord_portal/components/home_screen/key_facts.dart';
import 'package:landlord_portal/components/shared/custom_app_bar.dart';
import 'package:landlord_portal/components/shared/announcement_card.dart';
import 'package:landlord_portal/components/shared/bottom_border_container.dart';
import 'package:landlord_portal/components/shared/card_container.dart';
import 'package:landlord_portal/components/shared/personal_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: 'Hi Rashit!',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const BottomBorderContainer(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '440 ,340.00 AED',
                          style: TextStyle(
                            color: Color(0xFFEFF1EE),
                            fontSize: 30,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w900,
                            height: 0,
                          ),
                        ),
                        Text(
                          'all time income',
                          style: TextStyle(
                            color: Color(0xFFEFF1EE),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                CardContainer(
                  customHeight: 361,
                  cardHeader: 'Income',
                  trailing: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'November Income',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF7E8BA0),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0.11,
                          letterSpacing: -0.50,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      const Text(
                        '55,180',
                        style: TextStyle(
                          color: Color(0xFF232A41),
                          fontSize: 36,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w800,
                          height: 0.03,
                          letterSpacing: -0.36,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      SizedBox(
                        height: 200.0,
                        child: CustomBarChart(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const CardContainer(
              cardHeader: 'Key Facts',
              customHeight: 316,
              child: KeyFacts(),
            ),
            const PersonalManager(),
            const CardContainer(
              hasBtn: true,
              buttonText: "See All Messages",
              cardHeader: 'Announcements',
              child: Column(
                children: [
                  SizedBox(
                    height: 28.0,
                  ),
                  AnnouncementCard(
                    sender: 'Kaspar Eckhard',
                    timeStamp: '2 hours ago',
                    announcementDescription:
                        'Hi, I have a few questions about the property.',
                    profileImage:
                        AssetImage('assets/images/manager_profile.jpeg'),
                  ),
                  AnnouncementCard(
                    profileImage:
                        AssetImage('assets/images/keyone_logo_dark.png'),
                    sender: "Key One Realty",
                    timeStamp: "2 mins",
                    announcementDescription:
                        "Important information about your property.",
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
