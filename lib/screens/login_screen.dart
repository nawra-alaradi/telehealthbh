import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:telehealth_bh_app/business_logic/view modals/form_provider_view_model.dart';
import 'package:telehealth_bh_app/components/my_text_form_field.dart';
import 'package:telehealth_bh_app/components/small_elevated_button.dart';
import 'package:telehealth_bh_app/components/my_text_button.dart';
import 'email_screen.dart';
import 'package:telehealth_bh_app/screens/Doctor/doctor_home.dart';
import '../../business_logic/services/doctor_services.dart';
import 'package:telehealth_bh_app/components/my_circular_progress_indicator.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:telehealth_bh_app/screens/Patient/patient_registration_screen.dart';
import 'package:telehealth_bh_app/business_logic/services/patient_services.dart';
import 'package:telehealth_bh_app/screens/Patient/patient_route.dart';

class LoginScreen extends StatelessWidget {
  static final String id = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments
        as String; //we will receive either 'patient' or 'doctor'
    final _formProvider = Provider.of<FormProvider>(context, listen: true);
    final MyCircularProgressIndicator progressIndicator =
        MyCircularProgressIndicator();
    final DoctorServices doctorServiceProvider =
        Provider.of<DoctorServices>(context, listen: false);
    final PatientServices patientServiceProvider =
        Provider.of<PatientServices>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.png'), fit: BoxFit.cover),
          ),
          child: Form(
            child: ListView(
              padding: EdgeInsets.only(bottom: 30.h, right: 27.w),
              children: [
                Align(
                  alignment: Alignment.topLeft, // back arrow icon button
                  child: IconButton(
                    onPressed: () {
                      Provider.of<FormProvider>(context, listen: false)
                          .clearDoctorCredentials();

                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 25.h,
                    ),
                    color: Colors.black87,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 27.w),
                  child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'images/logo.png',
                        height: 120.h,
                        width: 95.w,
                      )),
                ),
                SizedBox(
                  height: 41.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 27.w),
                  child: MyTextFormField(
                    validator: null,
                    hintText: "Enter your email",
                    errorText: _formProvider.email.error,
                    labelText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    maxLength: 45,
                    onChnaged: (String val) {
                      Provider.of<FormProvider>(context, listen: false)
                          .validateEmail(val);
                    },
                    onTap: () {},
                    icon: null,
                    controller: null,
                    isObsecure: false,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 27.w),
                  child: MyTextFormField(
                    validator: null,
                    hintText: "Enter your Password",
                    errorText: _formProvider.doctorPassword.error,
                    labelText: 'Password',
                    textInputType: TextInputType.text,
                    maxLength: 20,
                    onChnaged: (String val) {
                      Provider.of<FormProvider>(context, listen: false)
                          .validateDoctorPassword(val);
                    },
                    onTap: () {},
                    icon: null,
                    controller: null,
                    isObsecure: true,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 27.w),
                  child: MyTextButton(
                    text: 'Forgot your password?',
                    onPressed: () {
                      (user.compareTo('patient') == 0)
                          ? Navigator.pushNamed(context, EmailScreen.id,
                              arguments: 'patient')
                          : Navigator.pushNamed(context, EmailScreen.id,
                              arguments: 'doctor');
                    },
                  ),
                ),
                Visibility(
                  visible: (user.compareTo('patient') == 0) ? true : false,
                  child: Padding(
                    padding: EdgeInsets.only(left: 27.w),
                    child: MyTextButton(
                      text: 'New patient? Register',
                      onPressed: () {
                        Navigator.pushNamed(
                            context, PatientRegistrationScreen.id);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                ElevatedButtonTheme(
                  data: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      primary: (user.compareTo('doctor') == 0)
                          ? Color(0xFF5D99C6)
                          : Color(
                              0xFF90CAF9), //set default color for the elevation button used for (welcome+ dr) screens
                      onPrimary: Color(0x00000000)
                          .withOpacity(0.8), //black color with 80% opacity
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 100.w, right: 73.w),
                    child: FittedBox(
                      child: Consumer<FormProvider>(
                        builder: (context, formModel, child) =>
                            SmallElevatedButton(
                          text: 'Sign in',
                          color: Color(0xFF5D99C6),
                          onPressed: (formModel.validateDoctorLoginScreen)
                              ? () async {
                                  if (user.compareTo('doctor') == 0) {
                                    progressIndicator.buildShowDialog(context);
                                    bool result = await doctorServiceProvider
                                        .doctorSignIn(formModel.email.text,
                                            formModel.doctorPassword.text);
                                    Navigator.of(context).pop();
                                    //TODO: make this async function that calls DoctorSignIn() method before pushing next screen
                                    //TODO: MAKE ModalProgressHUD set state as well to show the spinner if signin in returns true otherwise make spinner false
                                    if (result) {
                                      Provider.of<FormProvider>(context,
                                              listen: false)
                                          .clearCache(); //clear the global variables of the sign in pages
                                      Navigator.pushNamed(
                                          context, DoctorHome.id);
                                    } else {
                                      print('something wrong');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          "Invalid email and/or password",
                                          style: kSnackbarTextStyle.copyWith(
                                              fontSize: 16.sp),
                                        ),
                                        duration: Duration(milliseconds: 1000),
                                      ));
                                    }
                                  } else {
                                    // this is a patient
                                    progressIndicator.buildShowDialog(context);
                                    String res = await patientServiceProvider
                                        .patientSignIn(formModel.email.text,
                                            formModel.doctorPassword.text);
                                    Navigator.of(context).pop();
                                    if (res.compareTo(
                                            'signed in successfully') ==
                                        0) {
                                      Provider.of<FormProvider>(context,
                                              listen: false)
                                          .clearCache(); //clear the global variables of the sign in pages
                                      Navigator.pushNamed(
                                          context, PatientRoute.id);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          res,
                                          style: kSnackbarTextStyle.copyWith(
                                              fontSize: 16.sp),
                                        ),
                                        duration: Duration(milliseconds: 5000),
                                      ));
                                    }
                                  }
                                }
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
