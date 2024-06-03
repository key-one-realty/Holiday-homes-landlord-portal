import 'package:flutter/material.dart';
import 'package:landlord_portal/components/shared/border_line.dart';
import 'package:landlord_portal/config/colors.dart';

// ignore: must_be_immutable
class BookingCard extends StatelessWidget {
  BookingCard(
      {super.key,
      this.bookinNightsQty = "empty",
      this.bookingPlatform = "Direct",
      this.occupantsName = "empty",
      this.rentalAmount = "0",
      this.bookingDate = ""});

  final String occupantsName;

  final String bookingPlatform;

  final String bookinNightsQty;

  final String rentalAmount;

  final String bookingDate;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              occupantsName,
              style: const TextStyle(
                color: Color(0xFF262626),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              bookingDate,
              style: const TextStyle(
                color: Color.fromARGB(255, 90, 90, 90),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                    '$bookinNightsQty ${int.parse(bookinNightsQty) > 1 ? "nights" : "night"}',
                    style: const TextStyle(
                      color: Color(0xFF737373),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                    style: const TextStyle(
                      color: Color(0xFF737373),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        const BorderLine(),
      ],
    );
  }
}
