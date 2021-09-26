import 'package:flutter/material.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCheckboxListTile extends StatelessWidget {
  final String text;
  final bool? isChecked;
  final void Function() onTap;
  final void Function(bool?) toggleCheckbox;
  final Color? checkboxActiveColor;
  const MyCheckboxListTile(
      {Key? key,
      required this.text,
      required this.isChecked,
      required this.onTap,
      required this.toggleCheckbox,
      this.checkboxActiveColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 20.w, right: 29.w),
        title: Text(
          text,
          style: ktextFieldHeader.copyWith(fontSize: 16.sp),
        ),
        trailing: Transform.scale(
          scale: 1.w,
          child: Checkbox(
            hoverColor: Color(0xFF5D99C6).withOpacity(0.8),
            side: BorderSide(color: Colors.blueGrey, width: 1),
            value: isChecked,
            onChanged: toggleCheckbox,
            activeColor: checkboxActiveColor ?? Color(0xFF5D99C6),
            checkColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
