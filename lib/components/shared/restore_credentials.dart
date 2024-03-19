import 'package:flutter/material.dart';
import 'package:landlord_portal/config/colors.dart';

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
          onPressed: () {},
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
