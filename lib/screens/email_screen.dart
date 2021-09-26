import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telehealth_bh_app/business_logic/view modals/form_provider_view_model.dart';
import 'package:telehealth_bh_app/components/small_elevated_button.dart';
import 'package:telehealth_bh_app/components/my_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../business_logic/services/doctor_services.dart';
import 'package:telehealth_bh_app/components/my_circular_progress_indicator.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:telehealth_bh_app/business_logic/services/patient_services.dart';

class EmailScreen extends StatelessWidget {
  static final String id = 'DoctorEmailScreen';

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments
        as String; //we will receive either 'patient' or 'doctor'
    final _formProvider = Provider.of<FormProvider>(context, listen: true);
    final MyCircularProgressIndicator progressIndicator =
        MyCircularProgressIndicator();

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
                          .clearEmailForgotPassword();
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
                  child: MyTextFormField(
                    validator: null,
                    hintText: "Enter your email",
                    errorText: _formProvider.emailForgotPassword.error,
                    labelText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    maxLength: 45,
                    onChnaged: (String val) {
                      Provider.of<FormProvider>(context, listen: false)
                          .validateEmailForgotPassword(val);
                    },
                    onTap: () {},
                    icon: null,
                    controller: null,
                    isObsecure: false,
                  ),
                ),
                SizedBox(
                  height: 150.h,
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
                    padding:
                        EdgeInsets.only(left: 80.w, bottom: 94.h, right: 53.w),
                    child: FittedBox(
                      child: Consumer<FormProvider>(
                        builder: (context, model, child) => SmallElevatedButton(
                          text: 'Send reset',
                          color: Color(0xFF5D99C6),
                          onPressed: (model.validateEmailScreen)
                              ? () async {
                                  bool isFound = (user.compareTo('doctor') == 0)
                                      ? await Provider.of<DoctorServices>(
                                              context,
                                              listen: false)
                                          .ensureEmailExistsInDoctorsDataBase(
                                              _formProvider
                                                  .emailForgotPassword.text!
                                                  .toLowerCase())
                                      : await Provider.of<PatientServices>(
                                              context,
                                              listen: false)
                                          .ensureEmailExistsInPatientsDataBase(
                                              _formProvider
                                                  .emailForgotPassword.text!
                                                  .toLowerCase());
                                  ;
                                  if (isFound) {
                                    progressIndicator.buildShowDialog(context);
                                    await Provider.of<DoctorServices>(context,
                                            listen: false)
                                        .auth
                                        .sendPasswordResetEmail(
                                            email: _formProvider
                                                .emailForgotPassword.text!);

                                    Navigator.pop(
                                        context); //pop off the circular progress indicator
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "A reset email message has been sent to the email address ${_formProvider.emailForgotPassword.text!}\nCheck your inbox to change your password from there",
                                        style: kSnackbarTextStyle.copyWith(
                                            fontSize: 16.sp),
                                      ),
                                      duration: Duration(milliseconds: 9000),
                                    ));
                                    Provider.of<FormProvider>(context,
                                            listen: false)
                                        .clearEmailForgotPassword();
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "Unable to send reset message to the given email address\nThe given email address is not registered in the ${user}s database system",
                                        style: kSnackbarTextStyle.copyWith(
                                            fontSize: 16.sp),
                                      ),
                                      duration: Duration(milliseconds: 9000),
                                    ));
                                  }

                                  //TODO: VERIFY IT IS A VALID EMAIL ADDRESS IN FIREBASE SHOW SPINNER IF TRUE OTHERSOSE MAKE SPINNER FALSE SETSTATE
                                  //TODO: Send an email message to the input email message via Firebase cloud functions
                                  //TODO: Create a popup Alert Dialog once the reset password email message has been sent via Firebase
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
