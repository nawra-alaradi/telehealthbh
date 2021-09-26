import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telehealth_bh_app/constants.dart';

class MyDropdownButton extends StatelessWidget {
  final void Function(String?) onChanged;
  final String? chosenItem;
  final String hint;
  final List<String> itemsList;
  const MyDropdownButton(
      {Key? key,
      required this.chosenItem,
      required this.hint,
      required this.itemsList,
      required this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 10.w,
          right: 10.w), // padding for the text inside the dropdown menu
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.w),
          borderRadius: BorderRadius.circular(10.r)),
      child: DropdownButton(
        value: chosenItem,
        onChanged: onChanged,
        items: itemsList.map<DropdownMenuItem<String>>((String itemValue) {
          return DropdownMenuItem<String>(
              value: itemValue, child: Text(itemValue));
        }).toList(),
        hint: Text(
          hint,
          style: kDropdownHintTextStyle.copyWith(fontSize: 14.sp),
        ),
        dropdownColor: Colors.grey[200],
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 25.w,
        isExpanded: true,
        underline: SizedBox(),
        style: kDropdownItemTextStyle.copyWith(fontSize: 14.sp),
      ),
    );
  }
}
