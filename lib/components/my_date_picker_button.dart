import 'package:flutter/material.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDatePickerButton extends StatelessWidget {
  const MyDatePickerButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(
            left: 10.w,
            right: 10.w), // padding for the text inside the dropdown menu
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.w),
            borderRadius: BorderRadius.circular(10.r)),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          tileColor: Colors.blue,
          title: Text(
            text,
            style: text.contains('Select Date')
                ? kDropdownHintTextStyle.copyWith(fontSize: 14.sp)
                : kDropdownItemTextStyle.copyWith(fontSize: 14.sp),
          ),
          trailing: Icon(Icons.calendar_today),
        ),
      ),
    );
  }
}
