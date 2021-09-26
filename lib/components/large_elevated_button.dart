import 'package:flutter/material.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LargeElevatedButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onPressed;
  const LargeElevatedButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var height = getHMinusStat(context);
    // var width = getWidth(context);
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 25.h,
      ),
      label: Text(
        text,
        style: kLargeButtonTextStyle.copyWith(
          fontSize: 18.sp,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shadowColor: Color(0x000000).withOpacity(0.8),
        elevation: 10.r,
        padding: EdgeInsets.fromLTRB(40.w, 19.h, 93.w, 15.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            35.r,
          ),
        ),
      ),
    );
  }
}
