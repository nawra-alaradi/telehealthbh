import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'small_elevated_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telehealth_bh_app/constants.dart';

class AppointmentCard extends StatelessWidget {
  final String text, status, buttonTitle, destination;
  final Color? buttonColor;
  const AppointmentCard(
      {Key? key,
      required this.text,
      required this.status,
      this.buttonColor,
      required this.buttonTitle,
      required this.destination})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xFF757575),
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(10.r)),
      //margin: EdgeInsets.fromLTRB(25.w, 10.h, 25.w, 10.h),
      margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
      elevation: 10.w,
      shadowColor: Colors.black.withOpacity(0.75),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 16.w),
            child: Text(
              text,
              style: kCardTextStyle.copyWith(fontSize: 18.sp),
            ),
          ),
          Text(
            'Appointment status: $status',
            style: kCardTextStyle.copyWith(
                fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
          ElevatedButtonTheme(
            data: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: buttonColor ??
                    Color(
                        0xFF5D99C6), //set default color for the elevation button used for (welcome+ dr) screens
                onPrimary: Color(0xFFFFFFFF)
                    .withOpacity(0.8), //black color with 80% opacity
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 19.h, bottom: 23.h),
              child: FittedBox(
                child: SmallElevatedButton(
                    text: buttonTitle,
                    color: Color(0xFF5D99C6),
                    onPressed: (status.compareTo('pending') == 0)
                        ? null
                        : () {
                            Navigator.pushNamed(context, destination);
                          }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
