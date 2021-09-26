import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'small_elevated_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telehealth_bh_app/constants.dart';

class EditableAppointmentCard extends StatelessWidget {
  final String text, status;
  const EditableAppointmentCard({
    Key? key,
    required this.text,
    required this.status,
  }) : super(key: key);
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
          Padding(
            padding: EdgeInsets.fromLTRB(
              37.w,
              19.h,
              37.w,
              23.h,
            ),
            child: FittedBox(
              child: Row(
                children: [
                  ElevatedButtonTheme(
                    data: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF27D458),
                        onPrimary: Color(0x00000000)
                            .withOpacity(0.8), //black color with 80% opacity
                      ),
                    ),
                    child: SmallElevatedButton(
                        text: 'Accept',
                        color: Color(0xFF27D458),
                        onPressed: () => {}),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  ElevatedButtonTheme(
                    data: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFEF6F6F),
                        onPrimary: Color(0x00000000)
                            .withOpacity(0.8), //black color with 80% opacity
                      ),
                    ),
                    child: SmallElevatedButton(
                        text: 'Reject',
                        color: Color(0xFFEF6F6F),
                        onPressed: () => {}),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
