import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:landlord_portal/components/shared/border_line.dart";
import "package:landlord_portal/components/statements/custom_pdf_viewer.dart";
import "package:landlord_portal/config/colors.dart";
import "package:landlord_portal/features/statements/view_model/statement_view_model.dart";
import "package:provider/provider.dart";

class StatementCard extends StatelessWidget {
  const StatementCard(
      {super.key,
      this.statementMonth = "",
      this.statementPDFLink = "",
      this.statementRange = ""});

  final String statementMonth;
  final String statementPDFLink;
  final String statementRange;

  @override
  Widget build(BuildContext context) {
    return Consumer<StatementProvider>(
      builder: (context, value, child) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15.r,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 78.r,
              height: 22.r,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.r),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 2.r,
                    horizontal: 8.r,
                  ),
                ),
                onPressed: () {
                  value.setPDFLink = statementPDFLink;
                  debugPrint(value.pdfLink);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (builder) => const PdfViewer(),
                    ),
                  );
                },
                child: Text(
                  "View",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            11.verticalSpace,
            Text(
              "$statementMonth Statement",
            ),
            11.verticalSpace,
            Row(
              children: [
                Container(
                  width: 19.77.r,
                  height: 6.r,
                  decoration: ShapeDecoration(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r)),
                  ),
                ),
                14.horizontalSpace,
                Text(
                  statementRange,
                  style: TextStyle(
                    color: const Color(0xFF808D9E),
                    fontSize: 14.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.50.r,
                  ),
                ),
              ],
            ),
            15.verticalSpace,
            const BorderLine()
          ],
        ),
      ),
    );
  }
}
