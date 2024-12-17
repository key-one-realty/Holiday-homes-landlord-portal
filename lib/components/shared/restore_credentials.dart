import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:landlord_portal/config/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class RestoreCredentials extends StatelessWidget {
  const RestoreCredentials({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Forgot your credentials?',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: kTextColor,
          ),
        ),
        TextButton(
          onPressed: () async {
            String url =
                "hh-landlord-portal-be-production.up.railway.app/reset-password/enter-email";
            final Uri restorePasswordUri = Uri(
              scheme: 'https',
              path: url,
            );
            if (!await launchUrl(restorePasswordUri,
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
          child: const Text(
            'Restore',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: kTertiaryColor,
            ),
          ),
        ),
        const SizedBox(
          height: 70,
        )
      ],
    );
  }
}
