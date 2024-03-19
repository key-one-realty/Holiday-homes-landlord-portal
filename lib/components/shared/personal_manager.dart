import 'package:flutter/material.dart';
import 'package:landlord_portal/config/colors.dart';

class PersonalManager extends StatelessWidget {
  const PersonalManager({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        // width: 327,
        padding: const EdgeInsets.all(10.0),
        decoration: ShapeDecoration(
          color: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/manager_profile.jpeg',
                      ),
                      alignment: Alignment.center,
                      fit: BoxFit.fitWidth,
                    ),
                    shape: OvalBorder(),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kaspar Eckhard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      'Personal Manager',
                      style: TextStyle(
                        color: kTextSecondaryColor,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Container(
                  width: 29.05,
                  height: 29.05,
                  // padding: const EdgeInsets.all(10),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF9F9F9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.phone_in_talk_outlined,
                      color: kSecondaryColor,
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Container(
                  width: 29.05,
                  height: 29.05,
                  // padding: const EdgeInsets.all(10),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF9F9F9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.message_outlined,
                      color: kSecondaryColor,
                      size: 16,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
