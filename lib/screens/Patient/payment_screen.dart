import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telehealth_bh_app/components/my_drop_down_button.dart';
import 'package:telehealth_bh_app/components/header_with_textfield.dart';
import 'package:telehealth_bh_app/sizes_helper.dart';
import 'package:telehealth_bh_app/components/small_elevated_button.dart';
import 'appointment_confirmed_screen.dart';

class PaymentScreen extends StatefulWidget {
  static final String id = 'PaymentScreen';
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedCreditCard;
  bool isValidMonth = true, isValidYear = true, isValidCVC = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
        title: Text(
          'Pay and Confirm',
          style: kAppBarTextStyle.copyWith(fontSize: 16.sp),
        ),
        centerTitle: true,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.png'), fit: BoxFit.cover),
        ),
        child: ListView(
          padding: EdgeInsets.fromLTRB(22.w, 19.h, 27.w, 46.h),
          children: [
            Text(
              'Appointment Summary',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Work Sans',
                  color: Colors.black),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Visit Type:  Live Consultation',
              style: kPaymentSummaryTextStyle.copyWith(fontSize: 15.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Doctor Name: Mohamed Abdulraoof almazen',
              style: kPaymentSummaryTextStyle.copyWith(fontSize: 15.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Speciality:  Pediatrics',
              style: kPaymentSummaryTextStyle.copyWith(fontSize: 15.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Date:  7/8/2021',
              style: kPaymentSummaryTextStyle.copyWith(fontSize: 15.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Time:  8 AM',
              style: kPaymentSummaryTextStyle.copyWith(fontSize: 15.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Price:  10 BD',
              style: kPaymentSummaryTextStyle.copyWith(fontSize: 15.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Credit Type: ',
              style: ktextFieldHeader.copyWith(fontSize: 16.sp),
            ),
            SizedBox(
              height: 8.h,
            ),
            MyDropdownButton(
                chosenItem: selectedCreditCard,
                hint: 'Select Credit Type',
                itemsList: ['PayPal', 'Benefit', 'Visa'],
                onChanged: (newVal) {
                  setState(() {
                    selectedCreditCard = newVal;
                  });
                }),
            SizedBox(
              height: 14.h,
            ),
            SizedBox(
              width: 311.w,
              height: 100.h,
              child: HeaderWithTextField(
                  maxLength: 16,
                  textFieldHeader: 'Card Number',
                  hintText: 'Type Credit Card Number',
                  errorText: 'Invalid card number',
                  isValid:
                      true, //TODO: validate credit card number using sandbox sdk
                  textInputType: TextInputType.numberWithOptions(signed: true),
                  obscurePassword: false,
                  onChanged: (newVal) {}),
            ),
            SizedBox(
              height: 14.h,
            ),
            SizedBox(
              width: getWidth(context),
              child: Row(
                children: [
                  Text(
                    'Expiration Date: ',
                    style: ktextFieldHeader.copyWith(fontSize: 16.sp),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 45.w,
                    ),
                  ),
                  Text(
                    'Security Code: ',
                    style: ktextFieldHeader.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              width: getWidth(context),
              child: Row(
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: 60.w),
                      child: SmallTextFieldTypeNumber(
                          maxLength: 2,
                          isValid: isValidMonth,
                          hintText: 'MM',
                          onChanged: (newVal) {})),
                  SizedBox(
                    width: 7.w,
                  ),
                  Text(
                    '/',
                    style: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Work Sans',
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 60.w),
                    child: SmallTextFieldTypeNumber(
                        maxLength: 2,
                        isValid: isValidYear,
                        hintText: 'YY',
                        onChanged: (newVal) {}),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 101.w,
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 60.w),
                    child: SmallTextFieldTypeNumber(
                        maxLength: 3,
                        isValid: isValidMonth,
                        hintText: 'CVC',
                        onChanged: (newVal) {}),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60.h,
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
                padding: EdgeInsets.only(left: 50.w, right: 50.w),
                child: FittedBox(
                  child: SmallElevatedButton(
                    text: 'Pay & Confirm',
                    color: Color(0xFF90CAF9),
                    onPressed: () {
                      //TODO: If all user input is valid proceed the patient to the reminder screen
                      Navigator.pushNamed(
                          context, AppointmentConfirmationScreen.id);
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

class SmallTextFieldTypeNumber extends StatelessWidget {
  final int maxLength;
  final bool isValid;
  final Function(String?) onChanged;
  final String hintText;
  const SmallTextFieldTypeNumber(
      {Key? key,
      required this.isValid,
      required this.hintText,
      required this.maxLength,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength,
      style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
          fontFamily: 'Work Sans',
          fontWeight: FontWeight.w400), //style the user input
      autofocus: false,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.left,
      obscureText: false,
      decoration: InputDecoration(
        //errorText: is ? null : 'Invalid',  //no space for error text
        errorStyle: isValid ? null : kErrorTextStyle.copyWith(fontSize: 14.sp),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 15.sp,
          fontFamily: 'Work Sans',
          fontWeight: FontWeight.w400, //Work Sans light
          color: Color(0xFF9E9E9E),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
        border: OutlineInputBorder(),
      ),
      onChanged: (newVal) {},
    );
  }
}
