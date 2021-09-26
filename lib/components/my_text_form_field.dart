import 'package:flutter/material.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextFormField extends StatelessWidget {
  final Function(String) onChnaged;
  final Function() onTap;
  final TextInputType? textInputType;
  final String? errorText, hintText, labelText;
  final int? maxLength;
  final IconData? icon;
  final TextEditingController? controller;
  final bool isObsecure;
  final String? Function(String?)? validator;
  const MyTextFormField(
      {Key? key,
      required this.hintText,
      required this.errorText,
      required this.labelText,
      required this.textInputType,
      required this.maxLength,
      required this.onChnaged,
      required this.onTap,
      required this.icon,
      required this.controller,
      required this.isObsecure,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
          fontFamily: 'Work Sans',
          fontWeight: FontWeight.w400), //style the user input
      obscureText: isObsecure,
      controller: controller,
      onTap: onTap,
      onChanged: onChnaged,
      keyboardType: textInputType,
      decoration: InputDecoration(
        counterText: "", //hide maximum number of characters
        errorText: errorText,
        errorStyle: kErrorTextStyle.copyWith(fontSize: 14.sp),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 15.sp,
          fontFamily: 'Work Sans',
          fontWeight: FontWeight.w400, //Work Sans light
          color: Color(0xFF9E9E9E),
        ),
        labelText: labelText,
        suffixIcon: Icon(icon),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        border: const OutlineInputBorder(),
      ),
      maxLength: maxLength,
    );
  }
}
