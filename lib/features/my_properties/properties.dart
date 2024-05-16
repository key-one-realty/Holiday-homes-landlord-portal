import 'package:flutter/material.dart';
import 'package:landlord_portal/components/my_properties/listing_card.dart';
import 'package:landlord_portal/components/shared/custom_app_bar.dart';
import 'package:landlord_portal/components/shared/custom_text_input.dart';
import 'package:landlord_portal/components/shared/bottom_border_container.dart';
import 'package:landlord_portal/components/shared/card_container.dart';
import 'package:landlord_portal/components/shared/personal_manager.dart';
import 'package:landlord_portal/config/colors.dart';
import 'package:landlord_portal/features/authentication/view_model/auth_provider.dart';
import 'package:landlord_portal/features/my_properties/model/property_model.dart';
import 'package:landlord_portal/features/my_properties/property_detail.dart';
import 'package:landlord_portal/features/my_properties/view_model/property_view_model.dart';
import 'package:provider/provider.dart';

class PropertiesScreen extends StatefulWidget {
  const PropertiesScreen({super.key});

  @override
  State<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen> {
  @override
  void initState() {
    super.initState();
    // call the getUserProperty API
    final userId = context.read<AuthPovider>().userId;

    context.read<PropertyProvider>().getProperties(userId);
  }

  // Widget get listViewState {
  //   if (context.read<PropertyProvider>().propertyDetailsBody != null)
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Consumer<AuthPovider>(
      builder: (context, authProviderValue, child) => Scaffold(
        appBar: const CustomAppBar(
          appBarTitle: "My Properties",
        ),
        body: Consumer<PropertyProvider>(
          builder: (context, propertyProviderValue, child) =>
              SingleChildScrollView(
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
                  hasBtn: propertyProviderValue.numberOfProperties > 2,
                  buttonText: "Load More",
                  cardHeader: "Active Listings",
                  child: ValueListenableBuilder<List<PropertyDetailsBody>?>(
                    valueListenable:
                        propertyProviderValue.propertyDetailsBodyNotifier,
                    builder: (context, propertyDetailsBody, child) {
                      if (propertyDetailsBody == null ||
                          propertyDetailsBody.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 60.0,
                            child: Text("No Properties Available!"),
                          ),
                        );
                      }

                      return SizedBox(
                        height: 250,
                        child: ListView.builder(
                          itemCount: propertyDetailsBody.length,
                          itemBuilder: (context, index) {
                            PropertyDetailsBody property =
                                propertyDetailsBody[index];
                            return ListingCard(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PropertyDetails(
                                      projectId: property.firstbitPropertyId,
                                    ),
                                  ),
                                );
                              },
                              listingName: property.buildingName,
                              location: property.neighbourhood,
                              unitNumber: property.unitNumber,
                              image: property.displayImage,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                const PersonalManager(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
