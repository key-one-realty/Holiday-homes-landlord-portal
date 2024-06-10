import 'package:flutter/material.dart';
import 'package:landlord_portal/components/home_screen/custom_bar_chart.dart';
// import 'package:landlord_portal/components/home_screen/custom_bar_chart.dart';
import 'package:landlord_portal/components/home_screen/key_facts.dart';
import 'package:landlord_portal/components/shared/announcement_card.dart';
import 'package:landlord_portal/components/shared/bottom_border_container.dart';
import 'package:landlord_portal/components/shared/card_container.dart';
import 'package:landlord_portal/components/shared/custom_app_bar.dart';
import 'package:landlord_portal/components/shared/personal_manager.dart';
import 'package:landlord_portal/features/authentication/view_model/auth_provider.dart';
import 'package:landlord_portal/features/home/view_model/landlord_report_view_model.dart';
import 'package:landlord_portal/features/home/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userId = context.read<AuthPovider>().userId;

    context.read<LandlordProvider>().getLandlordReport(userId);
    context.read<UserProvider>().handleGetUserCaching(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthPovider>(
      builder: (context, value, child) => Scaffold(
        appBar: CustomAppBar(
          appBarTitle: 'Hi ${value.firstname}!',
        ),
        body: Consumer<LandlordProvider>(
          builder: (_, landlordValue, __) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                BottomBorderContainer(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Consumer<UserProvider>(
                              builder: (c, userValue, ch) => Text(
                                userValue.closingBalance,
                                style: const TextStyle(
                                  color: Color(0xFFEFF1EE),
                                  fontSize: 30,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w900,
                                  height: 0,
                                ),
                              ),
                            ),
                            const Text(
                              'closing balance',
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
                      isEmpty: landlordValue.isIncomeDataEmpty,
                      isLoading: landlordValue.isLoading,
                      customHeight: 361,
                      cardHeader: 'Income',
                      trailing: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Recent Payout',
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
                          Text(
                            landlordValue.totalRecentPayout,
                            style: const TextStyle(
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
                            child: CustomBarChart(
                                incomeData: landlordValue.incomeData),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CardContainer(
                  // isEmpty: true,
                  isLoading: landlordValue.isLoading,
                  cardHeader: '${landlordValue.currentMonth} Facts',
                  customHeight: 323,
                  trailing: true,
                  tooltipText:
                      "The values below represent the facts for the current month only",
                  child: KeyFacts(
                    dataTitle1: "Payout",
                    dataValue1: landlordValue.payout,
                    dataTrend1: landlordValue.payoutTrend["trendValue"],
                    dataTrendDirection1:
                        landlordValue.payoutTrend["trendDirection"],
                    dataTitle2: "Total Net Rental",
                    dataValue2: landlordValue.totalNetRental,
                    dataTrend2: landlordValue.totalNetRentalTrend["trendValue"],
                    dataTrendDirection2:
                        landlordValue.totalNetRentalTrend["trendDirection"],
                    dataTitle3: "Avg. Occupancy Rate",
                    dataValue3: landlordValue.avgOccupancyRate,
                    dataTrend3:
                        landlordValue.avgOccupancyRateTrend["trendValue"],
                    dataTrendDirection3:
                        landlordValue.totalNetRentalTrend["trendDirection"],
                    dataTitle4: "Avg. Nights Booked",
                    dataValue4: landlordValue.avgNightsBooked,
                    dataTrend4:
                        landlordValue.avgNightsBookedTrend["trendValue"],
                    dataTrendDirection4:
                        landlordValue.avgNightsBookedTrend["trendDirection"],
                  ),
                ),
                const PersonalManager(),
                const CardContainer(
                  isEmpty: true,
                  hasBtn: false,
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
        ),
      ),
    );
  }
}
