import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:landlord_portal/components/shared/restore_credentials.dart';
import 'package:landlord_portal/config/colors.dart';
import 'package:landlord_portal/features/authentication/login.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  static const onBoardingList = [
    {
      'title': 'Welcome Aboard!',
      'description':
          "Let's get started on simplifying your holiday home management! Login with your details and discover how effortless and rewarding renting out your property can be with Key One Holiday Homes!",
    },
    {
      'title': 'Assess Your Property Account',
      'description':
          'See how much you have made with Key One Holiday Homes in one place.',
      'image': 'assets/images/onboarding_pic.png'
    },
    {
      'title': 'Monitor Your Property Bookings',
      'description':
          'Keep track of your occupancy rate and view your booking details.',
      'image': 'assets/images/onboarding_pic.png'
    },
  ];

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late CarouselController buttonCarouselController;
  int currentIndex = 0;

  @override
  void initState() {
    buttonCarouselController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CarouselSlider(
          carouselController: buttonCarouselController,
          items: CarouselWidget.onBoardingList
              .map((e) => Builder(builder: (BuildContext context) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 24, right: 24, top: 57),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(e['title']!,
                                style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: kTextColor)),
                            Text(
                              e['description']!,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: kTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
              .toList(),
          options: CarouselOptions(
            height: 250,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.linear,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        DotsIndicator(
          dotsCount: CarouselWidget.onBoardingList.length,
          position: currentIndex,
          decorator: DotsDecorator(
            color: kGreyColor,
            activeColor: kPrimaryColor,
            size: const Size.square(9.0),
            activeSize: const Size(25, 10),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Login(),
              ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Login',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: kTextSecondaryColor,
              ),
            ),
          ),
        ),
        const RestoreCredentials(),
      ],
    );
  }
}
