import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telehealth_bh_app/constants.dart';

class NotificationsScreen extends StatelessWidget {
  static final String id = 'NotificationsScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
        title: Text(
          'Notifications',
          style: kAppBarTextStyle.copyWith(fontSize: 18.sp),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        //Container used to fill a background screen image
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.png'), fit: BoxFit.cover),
        ),
        child: ListView(
          padding: EdgeInsets.only(left: 22.w, right: 22.w),
        ),
      ),
    );
  }
}
