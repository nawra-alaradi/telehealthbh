import 'package:flutter/material.dart';
import 'package:telehealth_bh_app/components/my_drop_down_button.dart';
import 'package:telehealth_bh_app/components/my_date_picker_button.dart';
import 'package:telehealth_bh_app/components/my_text_form_field.dart';
import 'package:telehealth_bh_app/components/my_circular_progress_indicator.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telehealth_bh_app/components/small_elevated_button.dart';
import 'package:intl/intl.dart';
import 'package:telehealth_bh_app/extension_class.dart';
import 'package:telehealth_bh_app/business_logic/services/patient_services.dart';
import 'package:provider/provider.dart';

class PatientRegistrationScreen extends StatefulWidget {
  static final String id = 'PatientRegistrationScreen';
  @override
  _PatientRegistrationScreenState createState() =>
      _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  //text editing controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _personalNumberController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final MyCircularProgressIndicator progressIndicator =
      MyCircularProgressIndicator();

  //global keys
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedGender;
  DateTime? birthDate;
  String selectedDate = '';
  List<String> genders = ['Female', 'Male'];

  String getText() {
    if (birthDate == null) {
      return 'Select your birth date';
    } else {
      //This will not throw an error since this is executed when the birth date is not null
      //print('date: $date'); //output format e.g.: 2021-08-10 00:00:00.000
      selectedDate = DateFormat('dd/MM/yyyy')
          .format(birthDate!); //change format to 10/08/2021
      // print('selectedDate: $selectedDate');
      return selectedDate;
      // or return '${date.month}/${date.day}/${date.year}';
    }
  }

  Future pickDate(BuildContext context) async {
    // final initialDate = DateTime.now().add(Duration(days: 1));
    final newDate = await showDatePicker(
      context: context,
      initialDate: birthDate ??
          DateTime
              .now(), //if the date is null show the date of today otherwise show the selected date
      firstDate: DateTime(DateTime.now().year - 120),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return SingleChildScrollView(
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Color(0xFF90C6F2),
              colorScheme: ColorScheme.light(
                primary: Color(0xFF90C6F2), // header background color
                onPrimary: Colors.black, // header text color
                onSurface: Colors.black, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.black, // button text color
                ),
              ),
            ),
            child: child!,
          ),
        );
      },
    );

    if (newDate == null) return; //if patient did not select a date return
    //otherwise update date to selected date
    setState(() => birthDate = newDate);
  }

  // bool _isSubmitButtonEnabled() {
  //   return (_nameController.text.isNotEmpty &&
  //       _personalNumberController.text.isNotEmpty &&
  //       _nationalityController.text.isNotEmpty &&
  //       _phoneController.text.isNotEmpty &&
  //       _emailController.text.isNotEmpty &&
  //       _passwordController.text.isNotEmpty);
  // }
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
        title: Text(
          'Register New Patient',
          style: kAppBarTextStyle.copyWith(fontSize: 16.sp),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.png'), fit: BoxFit.cover),
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: () {
              if (_formKey.currentState != null) {
                setState(() {
                  _isButtonEnabled = _formKey.currentState!.validate();
                });
              }
            },
            child: ListView(
              padding: EdgeInsets.only(top: 20.h, bottom: 30.h, right: 27.w),
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 27.w),
                  child: MyTextFormField(
                    validator: (String? value) {
                      if (value == null)
                        return null;
                      else if (value.isEmpty)
                        return 'This field is required*';
                      else if (value.isValidName)
                        return null;
                      else
                        return 'Please enter a valid name';
                    },
                    hintText: "Enter your Name",
                    errorText: null,
                    labelText: 'Name',
                    textInputType: TextInputType.text,
                    maxLength: 60,
                    onChnaged: (String val) {},
                    onTap: () {},
                    icon: null,
                    controller: _nameController,
                    isObsecure: false,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 27.w),
                  child: MyTextFormField(
                    validator: (String? value) {
                      if (value == null)
                        return null;
                      else if (value.isEmpty)
                        return 'This field is required*';
                      else if (value.isValidPersonalNumber)
                        return null;
                      else
                        return 'Personal number must be 9 digits';
                    },
                    hintText: "Enter your personal number",
                    errorText: null,
                    labelText: 'Personal Number',
                    textInputType: TextInputType.number,
                    maxLength: 9,
                    onChnaged: (String val) {},
                    onTap: () {},
                    icon: null,
                    controller: _personalNumberController,
                    isObsecure: false,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                //TODO: GENDER DROPDOWN BUTTON
                Padding(
                  padding: EdgeInsets.only(left: 27.w),
                  child: MyDropdownButton(
                    chosenItem: selectedGender,
                    hint: 'Select your gender',
                    itemsList: genders,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 27.w),
                  child: MyDatePickerButton(
                    text: getText(),
                    onPressed: () => pickDate(context),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 27.w),
                  child: MyTextFormField(
                    validator: (String? value) {
                      if (value == null)
                        return null;
                      else if (value.isEmpty)
                        return 'This field is required*';
                      else if (value.isValidNationality)
                        return null;
                      else
                        return 'Please enter a valid nationality';
                    },
                    hintText: "Enter your nationality",
                    errorText: null,
                    labelText: 'Nationality',
                    textInputType: TextInputType.text,
                    maxLength: 30,
                    onChnaged: (String val) {},
                    onTap: () {},
                    icon: null,
                    controller: _nationalityController,
                    isObsecure: false,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 27.w),
                  child: MyTextFormField(
                    validator: (String? value) {
                      if (value == null)
                        return null;
                      else if (value.isEmpty)
                        return 'This field is required*';
                      else if (value.isValidPhone)
                        return null;
                      else
                        return 'Phone number must be\nin the form of +xxx yyyyyyyy';
                    },
                    hintText: "Enter your phone number",
                    errorText: null,
                    labelText: 'Phone Number',
                    textInputType: TextInputType.phone,
                    maxLength: 13,
                    onChnaged: (String val) {},
                    onTap: () {},
                    icon: null,
                    controller: _phoneController,
                    isObsecure: false,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 27.w),
                  child: MyTextFormField(
                    validator: (String? value) {
                      if (value == null)
                        return null;
                      else if (value.isEmpty)
                        return 'This field is required*';
                      else if (value.isValidEmail)
                        return null;
                      else
                        return 'Please enter a valid email';
                    },
                    hintText: "Enter your email",
                    errorText: null,
                    labelText: 'email',
                    textInputType: TextInputType.emailAddress,
                    maxLength: 50,
                    onChnaged: (String val) {},
                    onTap: () {},
                    icon: null,
                    controller: _emailController,
                    isObsecure: false,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 27.w),
                  child: MyTextFormField(
                    validator: (String? value) {
                      if (value == null)
                        return null;
                      else if (value.isEmpty)
                        return 'This field is required*';
                      else if (value.isValidPassword)
                        return null;
                      else
                        return 'Password must be 6-20 characters';
                    },
                    hintText: "Enter your password",
                    errorText: null,
                    labelText: 'Password',
                    textInputType: TextInputType.text,
                    maxLength: 20,
                    onChnaged: (String val) {},
                    onTap: () {},
                    icon: null,
                    controller: _passwordController,
                    isObsecure: true,
                  ),
                ),
                SizedBox(
                  height: 30.h,
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
                    padding: EdgeInsets.only(left: 100.w, right: 73.w),
                    child: FittedBox(
                      child: SmallElevatedButton(
                        text: 'Register',
                        color: Color(0xFF90CAF9),
                        //TODO: make this async function that calls CitizenSignIn() method before pushing next screen
                        //TODO: MAKE ModalProgressHUD set state as well to show the spinner if signin in returns true otherwise make spinner false
                        onPressed: (_formKey.currentState != null &&
                                _formKey.currentState!.validate() &&
                                selectedDate.isNotEmpty &&
                                selectedGender != null &&
                                _isButtonEnabled)
                            ? () async {
                                progressIndicator.buildShowDialog(context);
                                String res = await Provider.of<PatientServices>(
                                        context,
                                        listen: false)
                                    .RegisterNewPatient(
                                        _nameController.text,
                                        _personalNumberController.text,
                                        selectedGender!,
                                        selectedDate,
                                        _nationalityController.text,
                                        _phoneController.text,
                                        _emailController.text.toLowerCase(),
                                        _passwordController.text);
                                Navigator.pop(
                                    context); //remove circular progress indicator
                                if (res.compareTo(
                                        'Account with ${_emailController.text.toLowerCase()} has been successfully created. Please verify your email. Check your email inbox.') ==
                                    0) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      res,
                                      style: kSnackbarTextStyle.copyWith(
                                          fontSize: 16.sp),
                                    ),
                                    duration: Duration(milliseconds: 2000),
                                  ));
                                  Navigator.pop(
                                      context); //go back to login screen
                                } else {
                                  //there is some error show it to the user
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      res,
                                      style: kSnackbarTextStyle.copyWith(
                                          fontSize: 16.sp),
                                    ),
                                    duration: Duration(milliseconds: 10000),
                                  ));
                                }
                              }
                            : null,
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _personalNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dateController.dispose();
    _nationalityController.dispose();
    _phoneController.dispose();
  }
}
