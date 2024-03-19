import 'package:flutter/material.dart';
import 'package:landlord_portal/components/shared/custom_text_input.dart';
import 'package:landlord_portal/components/shared/restore_credentials.dart';
import 'package:landlord_portal/config/colors.dart';
// import 'package:landlord_portal/features/home/home_screen.dart';
import 'package:landlord_portal/features/navigation_bar/navigation_bar.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: Image(
                        image:
                            AssetImage('assets/images/keyone_logo_green.png'),
                      ),
                    ),
                    const SizedBox(
                      height: 87,
                    ),
                    CustomTextInput(
                      controller: emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    CustomTextInput(
                      controller: passwordController,
                      hintText: 'Password',
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (builder) => const CustomNavigationBar(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: kTextSecondaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    // const Spacer(),
                    const RestoreCredentials(),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
