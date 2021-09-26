import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telehealth_bh_app/sizes_helper.dart';
import 'package:telehealth_bh_app/screens/welcome_screen.dart';
import 'book_appointment_screen.dart';
import 'my_appointments_screen.dart';
import 'package:telehealth_bh_app/business_logic/view modals/form_provider_view_model.dart';
import 'package:provider/provider.dart';
import 'package:telehealth_bh_app/business_logic/services/patient_services.dart';
import 'chatbot_screen.dart';

class PatientHomeScreen extends StatelessWidget {
  static final String id = 'PatientHomeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            //CHATBOT
            ListTile(
              tileColor: Colors.grey[350],
              //selectedTileColor: Colors.amber,
              onTap: () {
                //TODO: GO TO CHATBOT SCREEN
                Navigator.pushNamed(context, ChatbotScreen.id);
              },
              title: Text(
                "Chat bot",
                style: kBodyTextStyle.copyWith(fontSize: 16.sp),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              trailing: Icon(
                FontAwesomeIcons.robot,
                size: 15.w,
              ),
            ),
            //SIGN OUT
            ListTile(
              tileColor: Colors.grey[400],
              //selectedTileColor: Colors.amber,
              onTap: () {
                Provider.of<FormProvider>(context, listen: false)
                    .clearCache(); //clear the global variables of the sign in pages
                Provider.of<PatientServices>(context, listen: false).signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              },
              title: Text(
                'Sign out',
                style: kBodyTextStyle.copyWith(fontSize: 16.sp),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              trailing: Icon(
                FontAwesomeIcons.signOutAlt,
                size: 15.w,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
        title: Text(
          'TelehealthBH',
          style: kAppBarTextStyle.copyWith(fontSize: 16.sp),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.png'), fit: BoxFit.cover),
          ),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 32.w),
                //TODO: OBTAIN PATIENT NAME FROM FIREBASE
                child: Text(
                  'Welcome ${Provider.of<PatientServices>(context, listen: true).patient.name}!',
                  style: kBodyTextStyle.copyWith(fontSize: 18.sp),
                ),
              ),
              SizedBox(
                height: 64.h,
              ),
              SizedBox(
                width: getWidth(context),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, BookAppointmentScreen.id);
                            },
                            icon: Center(
                              child: Icon(
                                FontAwesomeIcons.solidCalendarPlus,
                                color: Color(0xFF0D47A1).withOpacity(0.8),
                              ),
                            ),
                            iconSize: 114.h,
                            padding: EdgeInsets.only(left: 32.w, right: 68.w),
                          ),
                          SizedBox(
                            height: 20..h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 36.w),
                            child: Text(
                              '  Book Now',
                              style: kPaymentSummaryTextStyle.copyWith(
                                  fontSize: 16.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, MyAppointmentsScreen.id);
                            },
                            icon: Icon(FontAwesomeIcons.solidCalendarCheck,
                                color: Color(0xFF0D47A1).withOpacity(0.8)),
                            iconSize: 114.h,
                            padding: EdgeInsets.only(left: 40.w, right: 32.w),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'My appointments',
                            style: kPaymentSummaryTextStyle.copyWith(
                                fontSize: 16.sp),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
