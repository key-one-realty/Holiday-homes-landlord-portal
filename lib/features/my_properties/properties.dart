import 'package:flutter/material.dart';
import 'package:landlord_portal/components/my_properties/listing_card.dart';
import 'package:landlord_portal/components/shared/custom_app_bar.dart';
import 'package:landlord_portal/components/shared/custom_text_input.dart';
import 'package:landlord_portal/components/shared/bottom_border_container.dart';
import 'package:landlord_portal/components/shared/card_container.dart';
import 'package:landlord_portal/components/shared/personal_manager.dart';
import 'package:landlord_portal/config/colors.dart';
import 'package:landlord_portal/features/my_properties/property_detail.dart';

class PropertiesScreen extends StatelessWidget {
  const PropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: "My Properties",
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            BottomBorderContainer(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 20.0,
                  bottom: 20.0,
                ),
                width: double.maxFinite,
                child: CustomTextInput(
                  fillBg: true,
                  controller: controller,
                  hintText: "Search Property",
                  icon: const Icon(
                    Icons.location_pin,
                    color: kbodyPrimaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 21.0,
            ),
            CardContainer(
              hasBtn: true,
              buttonText: "Load More",
              cardHeader: "Active Listings",
              child: Column(
                children: [
                  ListingCard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PropertyDetails(),
                        ),
                      );
                    },
                    listingName: "The Keyone Homes",
                    location: "Lekki, Lagos",
                    unitNumber: "Unit 1",
                    badge: "2",
                  ),
                  const ListingCard(
                    listingName: "Majestine Tower",
                    location: "Dubai, Business Bay",
                    unitNumber: "1408",
                  ),
                  const ListingCard(
                    listingName: "Eagle Heights",
                    location: "Dubai, Sports City",
                    unitNumber: "42",
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            ),
            const PersonalManager(),
          ],
        ),
      ),
    );
  }
}
