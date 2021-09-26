import 'package:flutter/material.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../business_logic/services/doctor_services.dart';
import 'package:telehealth_bh_app/business_logic/services/doctor_services.dart';
import 'package:provider/provider.dart';

class DoctorProfileScreen extends StatelessWidget {
  static final String id = 'DoctorProfileScreen';

  @override
  Widget build(BuildContext context) {
    final DoctorServices doctorServicesProvider = Provider.of<DoctorServices>(
        context,
        listen: true); // be notified about dr object changes
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
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
                  backgroundColor: Color(0xFF5D99C6).withOpacity(0.8),
                  radius: 196.w,
                  child: Center(
                    child: FittedBox(
                      //TODO: Obtain first character of dr name from doctor object upon sign in
                      child: Text(
                        doctorServicesProvider.doctor.name[0],
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
              child: Text(
                //TODO: Obtain dr name from firebase upon sign in
                'Name: ${doctorServicesProvider.doctor.name}',
                style: kBodyTextStyle.copyWith(fontSize: 18.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Text(
                //TODO: Obtain dr gender from firebase
                'Gender: ${doctorServicesProvider.doctor.gender}',
                style: kBodyTextStyle.copyWith(fontSize: 18.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Text(
                //TODO: Obtain dr email address from firebase
                'Speciality: ${doctorServicesProvider.doctor.speciality}',
                style: kBodyTextStyle.copyWith(fontSize: 18.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Text(
                //TODO: Obtain dr phone number from firebase
                'Phone Number: ${doctorServicesProvider.doctor.phone}',
                style: kBodyTextStyle.copyWith(fontSize: 18.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w, bottom: 120.h),
              child: Text(
                //TODO: Obtain dr email address from firebase
                'Email Address: ${doctorServicesProvider.doctor.email}',
                style: kBodyTextStyle.copyWith(fontSize: 18.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
