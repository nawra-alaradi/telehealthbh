import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telehealth_bh_app/components/my_drop_down_button.dart';
import 'package:telehealth_bh_app/components/small_elevated_button.dart';
import 'package:telehealth_bh_app/screens/Patient/patient_route.dart';

class AppointmentConfirmationScreen extends StatefulWidget {
  static final String id = 'AppointmentConfirmationScreen';
  @override
  _AppointmentConfirmationScreenState createState() =>
      _AppointmentConfirmationScreenState();
}

class _AppointmentConfirmationScreenState
    extends State<AppointmentConfirmationScreen> {
  String? seledtedItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointment Confirmed',
          style: kAppBarTextStyle.copyWith(fontSize: 16.sp),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        //Container used to fill a background screen image
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.png'), fit: BoxFit.cover),
        ),
        child: ListView(
          padding: EdgeInsets.fromLTRB(22.w, 54.h, 27.w, 46.h),
          children: [
            Text(
              'Notify me:',
              style: ktextFieldHeader.copyWith(fontSize: 16.sp),
            ),
            SizedBox(
              height: 8.h,
            ),
            MyDropdownButton(
              chosenItem: seledtedItem,
              hint: 'Select reminder',
              itemsList: [
                'Never',
                '10 minutes before the appointment',
                '20 minutes before the appointment',
                '30 minutes before the appointment'
              ],
              onChanged: (newVal) {
                //TODO: Implement onChanged Functionality
                setState(() {
                  seledtedItem = newVal;
                });
              },
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              'Appointment details:',
              style: ktextFieldHeader.copyWith(fontSize: 16.sp),
            ),
            SizedBox(
              height: 8.h,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(0xFF757575),
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(1.r)),
              // margin: EdgeInsets.fromLTRB(25.w, 10.h, 25.w, 10.h),
              margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
              elevation: 10.w,
              shadowColor: Colors.black.withOpacity(0.75),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                //TODO: interpolate variables inside this text
                child: Text(
                  'Appointment with doctor Dawood Ibrahim has been scheduled. Please join the meeting with your ekey or CPR number as the channel code at the time of the appointment.',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            ElevatedButtonTheme(
              data: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  primary: Color(
                      0xFF90CAF9), //set default color for the elevation button used for (welcome+ dr) screens
                  onPrimary: Color(0x00000000)
                      .withOpacity(0.8), //black color with 80% opacity
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 80.w, right: 80.w),
                child: FittedBox(
                  child: SmallElevatedButton(
                    text: 'Save',
                    color: Color(0xFF90CAF9),
                    onPressed: () {
                      //TODO: Validate that the user has selected a reminder type
                      //TODO: add a reminder for the patient's appointment based on his selection
                      //TODO: Show snackbar indicating suceess or failure of the process
                      Navigator.pushNamed(context, PatientRoute.id);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
