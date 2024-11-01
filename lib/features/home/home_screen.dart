import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landlord_portal/components/home_screen/custom_bar_chart.dart';
// import 'package:landlord_portal/components/home_screen/custom_bar_chart.dart';
import 'package:landlord_portal/components/home_screen/key_facts.dart';
import 'package:landlord_portal/components/shared/announcement_card.dart';
import 'package:landlord_portal/components/shared/bottom_border_container.dart';
import 'package:landlord_portal/components/shared/card_container.dart';
import 'package:landlord_portal/components/shared/custom_app_bar.dart';
import 'package:landlord_portal/components/shared/personal_manager.dart';
import 'package:landlord_portal/config/firebase_api.dart';
import 'package:landlord_portal/features/authentication/view_model/auth_provider.dart';
import 'package:landlord_portal/features/home/view_model/device_view_model.dart';
import 'package:landlord_portal/features/home/view_model/landlord_report_view_model.dart';
import 'package:landlord_portal/features/home/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<String> getuserId() async {
    String userId = context.read<AuthPovider>().userId;

    if (userId == "") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('userId')!;
    }

    if (mounted) {
      context.read<LandlordProvider>().getLandlordReport(userId);
      context.read<UserProvider>().handleGetUserCaching(userId);
      context.read<DeviceProvider>().registerDevice(userId);
    }

    return userId;
  }

  @override
  void initState() {
    super.initState();
    getuserId();

    final firebaseFCM = FirebaseFCM();

    firebaseFCM.initializeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
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
                        padding: EdgeInsets.all(24.0.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Consumer<UserProvider>(
                              builder: (c, userValue, ch) => Text(
                                userValue.closingBalance,
                                style: TextStyle(
                                  color: const Color(0xFFEFF1EE),
                                  fontSize: 30.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w900,
                                  height: 0,
                                ),
                              ),
                            ),
                            Text(
                              'closing balance',
                              style: TextStyle(
                                color: const Color(0xFFEFF1EE),
                                fontSize: 14.sp,
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
                      customHeight: 382.r,
                      cardHeader: 'Payouts',
                      trailing: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Payout',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF7E8BA0),
                              fontSize: 14.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0.11.r,
                              letterSpacing: -0.50.sp,
                            ),
                          ),
                          35.verticalSpace,
                          Text(
                            landlordValue.totalRecentPayout,
                            style: TextStyle(
                              color: const Color(0xFF232A41),
                              fontSize: 36.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800,
                              height: 0.03.r,
                              letterSpacing: -0.36.sp,
                            ),
                          ),
                          30.verticalSpace,
                          SizedBox(
                            height: 200.0.r,
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
                  customHeight: 323.r,
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
                CardContainer(
                  isEmpty: true,
                  hasBtn: false,
                  buttonText: "See All Messages",
                  cardHeader: 'Announcements',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
