import 'package:flutter/material.dart';
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
            height: 420,
            decoration: const ShapeDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding_pic.png'),
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
            ),
          ),
          const Spacer(),
          const CarouselWidget(),
        ],
      ),
    );
  }
}
