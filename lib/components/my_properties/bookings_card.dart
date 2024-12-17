import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landlord_portal/components/shared/border_line.dart';
import 'package:landlord_portal/config/colors.dart';
import 'package:landlord_portal/features/home/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BookingCard extends StatelessWidget {
  BookingCard({
    super.key,
    this.bookinNightsQty = "empty",
    this.bookingPlatform = "Direct",
    this.occupantsName = "empty",
    this.rentalAmount = "0",
    this.bookingDate = "",
    this.bookingCheckIn = "",
    this.bookingCheckOut = "",
  });

  final String occupantsName;

  final String bookingPlatform;

  final String bookinNightsQty;

  final String rentalAmount;

  final String bookingDate;

  final String bookingCheckIn;

  final String bookingCheckOut;

  String formattedBookingPlatform = "";

  Color get bookingPlatformColor {
    if (bookingPlatform == "Booking.com B.V.") {
      formattedBookingPlatform = "Booking.com";
      return kBookingComColor;
    } else if (bookingPlatform == "AirBNB") {
      formattedBookingPlatform = "Airbnb";
      return kAirBnB;
    } else {
      formattedBookingPlatform = "Direct Booking";
      return kPrimaryColor;
    }
  }

  Widget getBookingDetailsRow(bool showBookingPlatform) {
    if (showBookingPlatform) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 6.r),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: bookingPlatformColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  formattedBookingPlatform,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 6.r),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFFAFAFA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$bookinNightsQty ${int.parse(bookinNightsQty) > 1 ? "nights" : "night"}',
                  style: TextStyle(
                    color: const Color(0xFF737373),
                    fontSize: 12.r,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 6.r),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFFAFAFA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'AED $rentalAmount',
                  style: TextStyle(
                    color: const Color(0xFF737373),
                    fontSize: 12.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 6.r),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFFAFAFA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$bookinNightsQty ${int.parse(bookinNightsQty) > 1 ? "nights" : "night"}',
                  style: TextStyle(
                    color: const Color(0xFF737373),
                    fontSize: 12.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 6.r),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFFAFAFA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'AED $rentalAmount',
                  style: TextStyle(
                    color: const Color(0xFF737373),
                    fontSize: 12.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      // This is required to activate or deactivate booking platforms
      builder: (context, value, child) => Column(
        children: [
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.40.r,
                child: Text(
                  occupantsName,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: const Color(0xFF262626),
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                "$bookingCheckIn - $bookingCheckOut",
                style: TextStyle(
                  color: const Color.fromARGB(255, 90, 90, 90),
                  fontSize: 10.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          getBookingDetailsRow(value.showBookingPlatform),
          16.verticalSpace,
          const BorderLine(),
        ],
      ),
    );
  }
}
