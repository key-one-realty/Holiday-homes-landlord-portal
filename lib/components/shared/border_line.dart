import "package:flutter/material.dart";

class BorderLine extends StatelessWidget {
  const BorderLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFFE9ECF2),
          ),
        ),
      ),
    );
  }
}
