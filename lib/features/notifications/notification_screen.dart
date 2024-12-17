import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
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
          goBack: true,
          onPressLeadingIcon: () {
            Navigator.pop(context);
          }),
      body: Column(
        children: [
          CardContainer(
            hasBtn: true,
            buttonText: "See All Messages",
            cardHeader: 'Alerts',
            child: Column(
              children: [
                28.verticalSpace,
                const AnnouncementCard(
                  sender: 'Kaspar Eckhard',
                  timeStamp: '2 hours ago',
                  announcementDescription:
                      'Hi, I have a few questions about the property.',
                  profileImage:
                      AssetImage('assets/images/manager_profile.jpeg'),
                ),
                const AnnouncementCard(
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
          const PersonalManager(),
        ],
      ),
    );
  }
}
