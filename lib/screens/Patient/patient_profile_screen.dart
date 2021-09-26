import 'package:flutter/material.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telehealth_bh_app/business_logic/services/patient_services.dart';
import 'package:provider/provider.dart';

class PatientProfileScreen extends StatelessWidget {
  static final String id = 'PatientProfileScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
        automaticallyImplyLeading: false,
        centerTitle: true,
        titleTextStyle: kAppBarTextStyle.copyWith(fontSize: 16.sp),
        title: Text(
          'Profile',
          style: kAppBarTextStyle.copyWith(fontSize: 16.sp),
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.png'), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 82.w, vertical: 35.h),
                child: CircleAvatar(
                  backgroundColor: Color(0xFF0D47A1).withOpacity(0.75),
                  radius: 196.w,
                  child: Center(
                    child: FittedBox(
                      //TODO: Obtain 1st letter of patient name from firebase upon sign in
                      child: Text(
                        Provider.of<PatientServices>(context, listen: true)
                            .patient
                            .name[0],
                        style:
                            kCircleAvatarTextStyle.copyWith(fontSize: 150.sp),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              //TODO: Obtain patient name from firebase upon sign in
              child: Text(
                'Name: ${Provider.of<PatientServices>(context, listen: true).patient.name}',
                style: kBodyTextStyle.copyWith(fontSize: 18.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              //TODO: Obtain patient gender from firebase
              child: Text(
                'Gender: ${Provider.of<PatientServices>(context, listen: true).patient.gender}',
                style: kBodyTextStyle.copyWith(fontSize: 18.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              //TODO: Obtain patient (personal number)/(CPR number) from firebase
              child: Text(
                'Personal Number: ${Provider.of<PatientServices>(context, listen: true).patient.personalNumber}',
                style: kBodyTextStyle.copyWith(fontSize: 18.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w, bottom: 120.h),
              //TODO: Obtain patient phone number from firebase
              child: Text(
                'Phone Number: ${Provider.of<PatientServices>(context, listen: true).patient.phone}',
                style: kBodyTextStyle.copyWith(fontSize: 18.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
