import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:landlord_portal/config/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalManager extends StatelessWidget {
  const PersonalManager({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14.0.r),
      child: Container(
        // width: 327,
        padding: EdgeInsets.all(10.0.r),
        decoration: ShapeDecoration(
          color: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: const ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/user_pic.png',
                      ),
                      alignment: Alignment.center,
                      fit: BoxFit.fitWidth,
                    ),
                    shape: OvalBorder(),
                  ),
                ),
                10.horizontalSpace,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45.r,
                      child: FittedBox(
                        child: Text(
                          'Key One Holiday Homes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    3.verticalSpace,
                    Text(
                      'Account Manager',
                      style: TextStyle(
                        color: kTextSecondaryColor,
                        fontSize: 12.sp,
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
                  width: 29.05.r,
                  height: 29.05.r,
                  // padding: const EdgeInsets.all(10),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF9F9F9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () async {
                        const phoneNumber = '+971581042990';
                        final Uri phoneCallUri = Uri(
                          scheme: 'tel',
                          path: phoneNumber,
                        );
                        await launchUrl(phoneCallUri);
                      },
                      icon: Icon(
                        Icons.phone_in_talk_outlined,
                        color: kSecondaryColor,
                        size: 16.sp,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                10.horizontalSpace,
                Container(
                  width: 29.05.r,
                  height: 29.05.r,
                  // padding: const EdgeInsets.all(10),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF9F9F9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () async {
                        const phoneNumber = '+971581042990';
                        String url = "wa.me/$phoneNumber";
                        final Uri whatsappUri = Uri(
                          scheme: 'https',
                          path: url,
                        );
                        if (!await launchUrl(whatsappUri,
                            mode: LaunchMode.inAppBrowserView)) {
                          Fluttertoast.showToast(
                            msg: "Can not open $url",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP_RIGHT,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                      alignment: AlignmentDirectional.topCenter,
                      icon: Icon(
                        Icons.message_outlined,
                        color: kSecondaryColor,
                        size: 16.sp,
                      ),
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
