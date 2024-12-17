import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landlord_portal/components/shared/card_button.dart';
import 'package:landlord_portal/config/colors.dart';
import 'package:landlord_portal/config/helpers/bar_chart_loading.dart';
import 'package:landlord_portal/config/helpers/loading_icon.dart';
import 'package:shimmer/shimmer.dart';

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
    this.isLoading = false,
    this.isEmpty = false,
    this.tooltipText = "",
    this.trailingWidgetChild,
    this.enableHeaderWidget = false,
    this.headerWidget,
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
  final bool isLoading;
  final bool isEmpty;
  final String tooltipText;
  final Widget? trailingWidgetChild;
  final bool enableHeaderWidget;
  final Widget? headerWidget;

  Widget get containerState {
    if (isEmpty) {
      return Padding(
        padding: EdgeInsets.all(12.0.r),
        child: Text(
          "No ${cardHeader.toLowerCase()} available at the moment",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF1D1D25),
            fontSize: 16.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    } else if (isLoading) {
      if (cardHeader.toLowerCase() == "payouts") {
        return SizedBox(
          width: 300.0.r,
          height: 250.0.r,
          child: Shimmer.fromColors(
            baseColor: Colors.white70,
            highlightColor: Colors.grey,
            child: const BarChartLoader(),
          ),
        );
      } else {
        return SizedBox(
          width: 300.0.r,
          height: 100.0.r,
          child: Shimmer.fromColors(
            baseColor: Colors.white70,
            highlightColor: Colors.grey,
            child: const LoadingIcon(),
          ),
        );
      }
    } else {
      return child;
    }
  }

  Widget? get getTrailingWidgetChild {
    if (trailingWidgetChild == null) {
      return Text(
        trailingWidgetText,
        style: TextStyle(
          color: kTextSecondaryColor,
          fontSize: 12.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          height: 0.05.r,
        ),
      );
    } else {
      return trailingWidgetChild;
    }
  }

  Widget? get trailingWidget {
    if (trailing) {
      if (tooltipText == "") {
        return Container(
          padding: EdgeInsets.all(10.0.r),
          decoration: BoxDecoration(
            color: trailingWidgetBackground,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(4.r),
            ),
          ),
          child: Center(
            child: getTrailingWidgetChild,
          ),
        );
      } else {
        return Tooltip(
          preferBelow: false,
          message: tooltipText,
          padding: EdgeInsets.all(7.0.r),
          textStyle: TextStyle(
            fontSize: 11.0.sp,
            color: kTextPrimaryColor,
          ),
          textAlign: TextAlign.center,
          child: const Icon(Icons.info_outline),
        );
      }
    } else {
      return null;
    }
  }

  CardButton? get cardButton => hasBtn
      ? CardButton(
          buttonText: buttonText,
          onPressed: onPressed,
        )
      : null;

  Widget get getHeaderWidget {
    if (enableHeaderWidget) {
      if (headerWidget != null) {
        return headerWidget!;
      } else {
        return Text(
          cardHeader,
          style: TextStyle(
            color: const Color(0xFF1D1D25),
            fontSize: 24.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        );
      }
    } else {
      return Text(
        cardHeader,
        style: TextStyle(
          color: const Color(0xFF1D1D25),
          fontSize: 24.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14.0.r),
      child: SizedBox(
        height: customHeight ?? customHeight,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: const Color(0x0F000000),
                blurRadius: 20.r,
                offset: Offset(0, 4.r),
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
          ),
          padding: EdgeInsets.all(20.0.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getHeaderWidget,
                  trailingWidget ?? Container(),
                ],
              ),
              5.verticalSpace,
              containerState,
              cardButton ?? Container(),
            ],
          ),
        ),
      ),
    );
  }
}
