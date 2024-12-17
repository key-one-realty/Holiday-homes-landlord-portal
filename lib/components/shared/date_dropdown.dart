import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landlord_portal/features/my_properties/model/property_details_model.dart';
import 'package:provider/provider.dart';

class DateDropdown extends StatelessWidget {
  const DateDropdown({
    super.key,
    required this.onSelected,
    required this.selectedMonth,
  });

  final void Function(dynamic)? onSelected;
  final String selectedMonth;

  @override
  Widget build(BuildContext context) {
    return Consumer<PropertyDetailsProvider>(
      builder: (context, value, child) => GestureDetector(
        onTap: () {
          showAdaptiveDialog(
            context: context,
            builder: (BuildContext context) {
              return displayMonthFilter(
                onSelected,
                context,
                value.getDropDownMenuEntries,
                value.getMonthList,
              );
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              selectedMonth,
              style: TextStyle(
                color: const Color(0xFF1D1D25),
                fontSize: 24.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
            const Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
    );
  }
}

Widget displayMonthFilter(
  void Function(dynamic)? onSelected,
  BuildContext context,
  List<DropdownMenuEntry<dynamic>> getDropDownMenuEntries,
  List<Map<String, Map<String, String>>> monthList,
) {
  return AlertDialog(
    title: const Text('Select a Month'),
    content: DropdownMenu(
      menuHeight: 200.r,
      label: const Text("Select a month"),
      onSelected: onSelected,
      dropdownMenuEntries: getDropDownMenuEntries,
    ),
    actions: [
      TextButton(
        style: TextButton.styleFrom(
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        child: const Text('Close'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
