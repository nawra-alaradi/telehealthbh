import 'package:flutter/material.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallElevatedButton extends StatelessWidget {
  final String text;
  final Color color;
  final void Function()? onPressed;
  final double? horizontalPadding, verticalPadding, fontSize;
  const SmallElevatedButton(
      {Key? key,
      this.horizontalPadding,
      this.verticalPadding,
      this.fontSize,
      required this.text,
      required this.color,
      required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // var height = getHMinusStat(context);
    // var width = getWidth(context);
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: kLargeButtonTextStyle.copyWith(
          fontSize: fontSize ?? 18.sp,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shadowColor: Color(0x000000).withOpacity(0.8),
        elevation: 10.r,
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 66.w,
            vertical: verticalPadding ?? 21.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            35.r,
          ),
        ),
      ),
    );
  }
}
