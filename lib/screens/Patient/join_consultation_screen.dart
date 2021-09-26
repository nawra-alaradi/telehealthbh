import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:telehealth_bh_app/components/small_elevated_button.dart';
import 'package:telehealth_bh_app/components/my_checkbox_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:telehealth_bh_app/business_logic/view modals/form_provider_view_model.dart';
import 'package:telehealth_bh_app/components/my_text_form_field.dart';

class JoinConsultationScreen extends StatefulWidget {
  static final String id = 'JoinConsultationScreen';
  @override
  _StartConsultationScreenState createState() =>
      _StartConsultationScreenState();
}

class _StartConsultationScreenState extends State<JoinConsultationScreen> {
  bool isCheckedCamera = false;
  bool isCheckedAudio = false;
  @override
  Widget build(BuildContext context) {
    final _formProvider = Provider.of<FormProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
        centerTitle: true,
        titleTextStyle: kAppBarTextStyle.copyWith(fontSize: 16.sp),
        title: Text(
          'Join Consultation',
          style: kAppBarTextStyle.copyWith(fontSize: 16.sp),
        ),
      ),
      body: Container(
        //Container used to fill a background screen image
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.png'), fit: BoxFit.cover),
        ),
        child: Form(
          child: ListView(
            //Used instead of a column for making space for the keyboard
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 35.h, right: 29.w),
                child: MyTextFormField(
                  validator: null,
                  hintText: "Enter channel code",
                  errorText: _formProvider.channelCode.error,
                  labelText: 'Channel Code',
                  textInputType: TextInputType.number,
                  maxLength: 9,
                  onChnaged: (String val) {
                    Provider.of<FormProvider>(context, listen: false)
                        .validateChannelCode(val);
                  },
                  onTap: () {},
                  icon: null,
                  controller: null,
                  isObsecure: false,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              MyCheckboxListTile(
                text: 'Camera Off',
                isChecked: isCheckedCamera,
                onTap: () {
                  setState(() {
                    isCheckedCamera = !isCheckedCamera; //toggle checkbox
                  });
                },
                toggleCheckbox: (bool? value) {
                  //modified
                  if (value != null) {
                    setState(() {
                      isCheckedCamera = value;
                    });
                  }
                },
                checkboxActiveColor: Color(0xFF59B4FD).withOpacity(0.8),
              ),
              SizedBox(
                height: 20.h,
              ),
              MyCheckboxListTile(
                text: 'Audio Muted',
                isChecked: isCheckedAudio,
                onTap: () {
                  setState(() {
                    isCheckedAudio = !isCheckedAudio; //toggle checkbox
                  });
                },
                toggleCheckbox: (bool? value) {
                  //modified
                  if (value != null) {
                    setState(() {
                      isCheckedAudio = value;
                    });
                  }
                },
                checkboxActiveColor: Color(0xFF59B4FD).withOpacity(0.8),
              ),
              SizedBox(
                height: 145.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.w, bottom: 94.h, right: 40.w),
                child: ElevatedButtonTheme(
                  data: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      primary: Color(
                          0xFF90CAF9), //set default color for the elevation button used for (welcome+ dr) screens
                      onPrimary: Color(0x00000000)
                          .withOpacity(0.8), //black color with 80% opacity
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: FittedBox(
                      child: Consumer<FormProvider>(
                        builder: (context, model, child) => SmallElevatedButton(
                          text: 'Join Consultation',
                          color: Color(0xFF90CAF9),
                          //TODO: IMPLEMENT model.validateConsultationScreen
                          onPressed:
                              (model.validateConsultationScreen) ? () {} : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
