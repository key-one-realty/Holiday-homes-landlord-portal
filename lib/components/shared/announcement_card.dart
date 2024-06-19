import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      height: 100.r,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48.r,
                height: 48.r,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: profileImage,
                    fit: BoxFit.fill,
                  ),
                  shape: const OvalBorder(),
                ),
              ),
              12.horizontalSpace,
              SizedBox(
                width: MediaQuery.of(context).size.width - 141.r,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sender,
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 14.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0.10.r,
                          ),
                        ),
                        Text(
                          timeStamp,
                          style: TextStyle(
                            color: const Color(0xFF808D9E),
                            fontSize: 14.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0.11.r,
                            letterSpacing: -0.50.r,
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Text(
                      announcementDescription,
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 14.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0.11.r,
                        letterSpacing: -0.50.r,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          20.verticalSpace,
          Container(
            width: MediaQuery.of(context).size.width - 28.r,
            height: 1.r,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFE9ECF2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.r)),
            ),
          ),
          28.verticalSpace,
        ],
      ),
    );
  }
}
