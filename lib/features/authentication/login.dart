import 'package:flutter/material.dart';
import 'package:landlord_portal/components/shared/custom_text_input.dart';
import 'package:landlord_portal/components/shared/restore_credentials.dart';
import 'package:landlord_portal/config/colors.dart';
import 'package:landlord_portal/features/authentication/view_model/auth_provider.dart';
import 'package:landlord_portal/features/navigation_bar/navigation_bar.dart';
// import 'package:landlord_portal/features/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Consumer<AuthPovider>(
            builder: (_, value, __) => Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                      // mainAxisAlignment: MainAxisAlignmnt.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Center(
                          child: Image(
                            image: AssetImage(
                                'assets/images/keyone_logo_green.png'),
                          ),
                        ),
                        const SizedBox(
                          height: 87,
                        ),
                        CustomTextInput(
                          controller: emailController,
                          hintText: 'Email',
                          errorText: "Please enter your email",
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        CustomTextInput(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                          errorText: "Please enter your password",
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
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              bool loginSuccess = await value.login(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              if (loginSuccess) {
                                prefs.setBool('user_onboarded', true);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (builder) =>
                                        const CustomNavigationBar(),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text(
                            value.loginLoading ? "Loading..." : "Sign In",
                            style: const TextStyle(
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
        ),
      ),
    );
  }
}
