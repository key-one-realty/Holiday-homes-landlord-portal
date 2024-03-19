import "package:flutter/material.dart";
import "package:landlord_portal/config/colors.dart";

class StatementCard extends StatelessWidget {
  const StatementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 78,
            height: 22,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(2),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 8,
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Download",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 11,
          ),
          const Text(
            "March Statement",
          ),
          const SizedBox(
            height: 11,
          ),
          Row(
            children: [
              Container(
                width: 19.77,
                height: 6,
                decoration: ShapeDecoration(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              const Text(
                "01 Feb 2024 - 29 Feb 2024",
                style: TextStyle(
                  color: Color(0xFF808D9E),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
