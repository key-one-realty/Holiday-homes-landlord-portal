import 'package:flutter/material.dart';
import 'package:landlord_portal/config/colors.dart';

class BottomBorderContainer extends StatelessWidget {
  const BottomBorderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              height: 110,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const ShapeDecoration(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
