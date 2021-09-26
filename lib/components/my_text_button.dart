import 'package:flutter/material.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const MyTextButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var width = getWidth(context);
    return Container(
      // margin: const EdgeInsets.only(left: 16),
      //margin: EdgeInsets.only(left: 20.w),
      child: Align(
        alignment: Alignment.topLeft,
        child: TextButton(
          child: Text(
            text,
            style: kSmallText.copyWith(fontSize: 13.sp),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
