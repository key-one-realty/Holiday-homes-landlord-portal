import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landlord_portal/features/authentication/login.dart';
import 'package:landlord_portal/features/navigation_bar/navigation_bar.dart';
import 'package:landlord_portal/features/onboarding_screens/onboarding_screen.dart';
import 'package:landlord_portal/features/splash_screen/view_model/splash_screen_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(
      const Duration(seconds: 1),
      () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        bool? checkUser = prefs.getBool('user_onboarded');
        bool navigateHome = true;
        if (mounted) {
          navigateHome =
              await context.read<SplashScreenProvider>().verifyAccessToken();
        }

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (builder) {
                if (checkUser != null) {
                  if (!navigateHome) {
                    return const Login();
                  } else {
                    return const CustomNavigationBar();
                  }
                } else {
                  return const OnboardingScreen();
                }
              },
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.primary,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: const AssetImage('assets/images/keyone_logo.png'),
              width: 60.r,
            ),
          ],
        ),
      ),
    ));
  }
}
