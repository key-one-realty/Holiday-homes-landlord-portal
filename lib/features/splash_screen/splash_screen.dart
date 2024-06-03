import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:landlord_portal/features/authentication/login.dart';
import 'package:landlord_portal/features/onboarding_screens/onboarding_screen.dart';
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
      const Duration(seconds: 2),
      () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        bool? checkUser = prefs.getBool('user_onboarded');

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (builder) {
                if (checkUser != null) {
                  return const Login();
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
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/keyone_logo.png'),
              width: 60,
            ),
          ],
        ),
      ),
    ));
  }
}
