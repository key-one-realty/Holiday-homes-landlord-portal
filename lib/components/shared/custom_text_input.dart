import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landlord_portal/components/shared/view_model/shared_component_model.dart';
import 'package:provider/provider.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput(
      {super.key,
      required this.controller,
      required this.hintText,
      this.icon,
      this.obscureText = false,
      this.fillBg = false,
      this.errorText = "Please enter some text"});

  final TextEditingController controller;
  final String? hintText;
  final Widget? icon;
  final bool? obscureText;
  final bool? fillBg;
  final String errorText;

  bool handleObscureTextField(SharedComponentModel value) {
    if (obscureText!) {
      return value.obscureLoginPasswordField;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SharedComponentModel>(
      builder: (context, value, child) => TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return errorText;
            }
            return null;
          },
          autocorrect: false,
          controller: controller,
          obscureText: handleObscureTextField(value),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 15.r,
              horizontal: 15.r,
            ),
            icon: icon ?? icon,
            fillColor: Colors.white,
            filled: fillBg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
            ),
            labelText: hintText,
            suffixIcon: obscureText!
                ? IconButton(
                    icon: value.obscureLoginPasswordField
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    onPressed: () => value.toggleObscureLoginPasswordField(),
                  )
                : null,
          )),
    );
  }
}
