import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landlord_portal/components/onboarding_screen/carousel_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 420.r,
            decoration: ShapeDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/onboarding_pic.png'),
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              )),
            ),
          ),
          const Spacer(),
          const CarouselWidget(),
          20.verticalSpace
        ],
      ),
    );
  }
}
