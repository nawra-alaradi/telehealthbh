import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderWithTextField extends StatelessWidget {
  final String textFieldHeader, hintText, errorText;
  final TextInputType textInputType;
  final bool obscurePassword;
  final void Function(String) onChanged;
  final bool isValid;
  final int? maxLength;
  const HeaderWithTextField(
      {Key? key,
      this.maxLength,
      required this.textFieldHeader,
      required this.hintText,
      required this.errorText,
      required this.isValid,
      required this.textInputType,
      required this.obscurePassword,
      required this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // bool isValid = true; //valid input
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            textFieldHeader,
            style: ktextFieldHeader.copyWith(fontSize: 16.sp),
          ),
        ),
        SizedBox(
          height: 7.h,
        ),
        Expanded(
          flex: 1,
          child: TextField(
            maxLength: maxLength ?? 50, //if null put a limit of 50 characters
            style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w400), //style the user input
            autofocus: false,
            keyboardType: textInputType,
            textAlign: TextAlign.left,
            obscureText: obscurePassword,
            decoration: InputDecoration(
              errorText: isValid ? null : this.errorText,
              errorStyle:
                  isValid ? null : kErrorTextStyle.copyWith(fontSize: 14.sp),
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 15.sp,
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w400, //Work Sans light
                color: Color(0xFF9E9E9E),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              border: OutlineInputBorder(),
            ),
            onChanged: onChanged,
          ),
        )
      ],
    );
  }
}
