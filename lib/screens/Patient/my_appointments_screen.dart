import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telehealth_bh_app/components/appointment_card.dart';
import 'package:telehealth_bh_app/screens/Patient/join_consultation_screen.dart';
import 'package:provider/provider.dart';
import 'package:telehealth_bh_app/business_logic/modals/appointment_model.dart';
import 'package:telehealth_bh_app/business_logic/services/patient_services.dart';
import 'package:telehealth_bh_app/business_logic/services/common_database_services.dart';

class MyAppointmentsScreen extends StatelessWidget {
  static final String id = 'MyAppointmentsScreen';
  @override
  Widget build(BuildContext context) {
    final patientServiceProvider = Provider.of<PatientServices>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
        title: Text(
          'My Appointments',
          style: kAppBarTextStyle.copyWith(fontSize: 16.sp),
        ),
        centerTitle: true,
      ),
      body: Container(
          //Container used to fill a background screen image
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.png'), fit: BoxFit.cover),
          ),
          child: StreamBuilder<List<Appointment>>(
            stream: CommonDatabaseServices().getAppointmentsByUid(
                'patientId', patientServiceProvider.patient.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.length != 0) {
                return ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 22.w, vertical: 18.h),
                  itemCount: snapshot.data!.length,
                  // reverse: true,
                  itemBuilder: (context, index) {
                    Appointment appointment = snapshot.data![index];
                    return AppointmentCard(
                      text:
                          'Appointment with doctor ${appointment.doctorName} has been scheduled.\n${appointment.date}, at ${appointment.slot.substring(0, appointment.slot.indexOf('-'))}',
                      status: '${appointment.status}',
                      buttonTitle: 'Join Consultation',
                      destination: JoinConsultationScreen.id,
                      buttonColor: Color(0xFF90CAF9),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Center(
                  child: Text(
                    'There is an issue with the server',
                    style: kCardTextStyle.copyWith(fontSize: 18.sp),
                  ),
                );
              } else if (snapshot.data != null && snapshot.data!.length == 0) {
                print('No data');
                return Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 10.w),
                  child: Center(
                    child: Text(
                      'You have not booked any appointment so far.',
                      style: kCardTextStyle.copyWith(fontSize: 18.sp),
                    ),
                  ),
                );
              } else {
                //TODO: SHOW A CICRCLE AVATAR WITH AN IMAGE THAT INDICATES THERE IS NO INTERNET CONNECTION
                return Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: CircleAvatar(
                    radius: 120.w,
                    child: Image.asset('images/no-connection-image.jpg'),
                  ),
                ));
              }
            },
          )),
    );
  }
}
