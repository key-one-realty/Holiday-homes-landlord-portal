import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:landlord_portal/config/colors.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({
    super.key,
    required this.profileImage,
    required this.sender,
    required this.timeStamp,
    required this.announcementDescription,
  });

  final ImageProvider<Object> profileImage;
  final String sender;
  final String timeStamp;
  final String announcementDescription;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 303,
      height: 100,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: profileImage,
                    fit: BoxFit.fill,
                  ),
                  shape: const OvalBorder(),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 141,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sender,
                          style: const TextStyle(
                            color: kTextColor,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0.10,
                          ),
                        ),
                        Text(
                          timeStamp,
                          style: const TextStyle(
                            color: Color(0xFF808D9E),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0.11,
                            letterSpacing: -0.50,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      announcementDescription,
                      style: const TextStyle(
                        color: kTextColor,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0.11,
                        letterSpacing: -0.50,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 28,
            height: 1,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFE9ECF2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1)),
            ),
          ),
          const SizedBox(
            height: 28.0,
          ),
        ],
      ),
    );
  }
}
