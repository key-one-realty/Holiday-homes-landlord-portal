import 'package:flutter/material.dart';
import 'package:landlord_portal/components/shared/card_button.dart';
import 'package:landlord_portal/config/colors.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.child,
    required this.cardHeader,
    this.customHeight,
    this.trailing = false,
    this.hasBtn = false,
    this.trailingWidgetText = 'AED',
    this.trailingWidgetBackground = kSecondaryColor,
    this.buttonText = 'See All',
    this.onPressed,
  });

  final Widget child;
  final double? customHeight;
  final String cardHeader;
  final bool trailing;
  final bool hasBtn;
  final String trailingWidgetText;
  final String buttonText;
  final Color trailingWidgetBackground;
  final void Function()? onPressed;

  Container? get trailingWidget => trailing
      ? Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: trailingWidgetBackground,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: Center(
            child: Text(
              trailingWidgetText,
              style: const TextStyle(
                color: kTextSecondaryColor,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 0.05,
              ),
            ),
          ),
        )
      : null;

  CardButton? get cardButton => hasBtn
      ? CardButton(
          buttonText: buttonText,
          onPressed: onPressed,
        )
      : null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: SizedBox(
        height: customHeight ?? customHeight,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cardHeader,
                    style: const TextStyle(
                      color: Color(0xFF1D1D25),
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailingWidget ?? Container(),
                ],
              ),
              child,
              cardButton ?? Container(),
            ],
          ),
        ),
      ),
    );
  }
}
