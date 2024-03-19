import "package:flutter/material.dart";
import "package:landlord_portal/components/shared/custom_app_bar.dart";
import "package:landlord_portal/components/shared/announcement_card.dart";
import "package:landlord_portal/components/shared/card_container.dart";
import "package:landlord_portal/components/shared/personal_manager.dart";

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          appBarTitle: "Notifications",
          onPressLeadingIcon: () {
            Navigator.pop(context);
          }),
      body: const Column(
        children: [
          CardContainer(
            hasBtn: true,
            buttonText: "See All Messages",
            cardHeader: 'Alerts',
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
          PersonalManager(),
        ],
      ),
    );
  }
}
