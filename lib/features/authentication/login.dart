import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landlord_portal/components/shared/custom_text_input.dart';
// import 'package:landlord_portal/components/shared/restore_credentials.dart';
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
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0.r),
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
                          87.verticalSpace,
                          CustomTextInput(
                            controller: emailController,
                            hintText: 'Email',
                            errorText: "Please enter your email",
                          ),
                          17.verticalSpace,
                          CustomTextInput(
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: true,
                            errorText: "Please enter your password",
                          ),
                          17.verticalSpace,
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50.r, vertical: 15.r),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
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
                                  if (context.mounted) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (builder) =>
                                            const CustomNavigationBar(),
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                            child: Text(
                              value.isLoading ? "Loading..." : "Sign In",
                              style: TextStyle(
                                color: kTextSecondaryColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          // const Spacer(),
                          // const RestoreCredentials(),
                        ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
