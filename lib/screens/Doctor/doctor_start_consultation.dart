import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telehealth_bh_app/business_logic/view modals/form_provider_view_model.dart';
import 'package:telehealth_bh_app/components/my_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:telehealth_bh_app/components/small_elevated_button.dart';
import 'package:telehealth_bh_app/components/my_checkbox_list_tile.dart';

class StartConsultationScreen extends StatefulWidget {
  static final String id = 'StartConsultationScreen';
  @override
  _StartConsultationScreenState createState() =>
      _StartConsultationScreenState();
}

class _StartConsultationScreenState extends State<StartConsultationScreen> {
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
          'Start Consultation',
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
                  //modified 13th Aug
                  if (value != null) {
                    setState(() {
                      isCheckedCamera = value;
                    });
                  }
                },
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
                  //modified 13th Aug
                  if (value != null) {
                    setState(() {
                      isCheckedAudio = value;
                    });
                  }
                },
              ),
              SizedBox(
                height: 145.h,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 100.w, bottom: 94.h, right: 100.w),
                child: FittedBox(
                  child: Consumer<FormProvider>(
                    builder: (context, model, child) => SmallElevatedButton(
                      text: 'Start',
                      color: Color(0xFF5D99C6),
                      onPressed:
                          (model.validateConsultationScreen) ? () {} : null,
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
