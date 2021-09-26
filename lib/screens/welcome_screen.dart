import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telehealth_bh_app/components/large_elevated_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'WelcomeScreen';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            //Container used to fill a background screen image
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/background.png'),
                  fit: BoxFit.cover),
            ),
            child: ListView(
              padding: EdgeInsets.only(
                  left: 39.w, right: 39.w, bottom: 40.h, top: 40.h),
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'images/logo.png',
                    width: 191.w,
                    height: 284.h,
                  ),
                ),
                SizedBox(
                  height: 38.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50.w),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'TelehealthBH',
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 26.sp,
                          fontFamily: 'Judson',
                          fontWeight: FontWeight.w700,
                        ),
                        // Change this to make it faster or slower
                        speed: const Duration(milliseconds: 320),
                      ),
                    ],
                    // You could replace repeatForever to a fixed number of repeats
                    // with totalRepeatCount: X, where X is the repeats you want.
                    repeatForever: true,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                LargeElevatedButton(
                  text: 'I am Patient',
                  icon: FontAwesomeIcons.user,
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id,
                        arguments: 'patient');
                  },
                ),
                SizedBox(
                  height: 25.h,
                ),
                LargeElevatedButton(
                  text: 'I am Doctor',
                  icon: FontAwesomeIcons.userMd,
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id,
                        arguments: 'doctor');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
