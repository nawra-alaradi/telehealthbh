import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'doctor_start_consultation.dart';
import 'package:telehealth_bh_app/screens/welcome_screen.dart';
import 'package:telehealth_bh_app/components/appointment_card.dart';
import '../../business_logic/services/doctor_services.dart';
import 'package:telehealth_bh_app/business_logic/view modals/form_provider_view_model.dart';
import 'package:provider/provider.dart';
import 'package:telehealth_bh_app/business_logic/services/common_database_services.dart';
import 'package:telehealth_bh_app/business_logic/modals/appointment_model.dart';
import 'package:telehealth_bh_app/components/editable_appointment_card.dart';

class RequestsScreen extends StatefulWidget {
  static final String id = 'RequestsScreen';
  @override
  _RequestsScreenState createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen>
    with AutomaticKeepAliveClientMixin {
  //TODO: Retrieve the list of Appointments from firebase and put their text into  appointment cards use .add

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final DoctorServices doctorServicesProvider = Provider.of<DoctorServices>(
        context,
        listen: true); // be notified about dr object changes

    return Scaffold(
      drawer: Drawer(
        child: ListTile(
          tileColor: Colors.grey[350],
          //selectedTileColor: Colors.amber,
          onTap: () {
            //clear the email and password cache to disable sign in without authentication
            Provider.of<FormProvider>(context, listen: false).clearCache();
            doctorServicesProvider.signOut();
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
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
        centerTitle: true,
        titleTextStyle: kAppBarTextStyle.copyWith(fontSize: 16.sp),
        title: Text(
          'TelehealthBH',
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //TODO: Obtain doctor name for the current user from firebase
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Welcome Doctor ${doctorServicesProvider.doctor.name}!', //by this time doctor object must not be null since the doctor has already been authenticated
                    style: kBodyTextStyle.copyWith(fontSize: 20.sp),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Appointment Requests:',
                    style: kBodyTextStyle.copyWith(
                        color: Color(0xFF0D47A1), fontSize: 18.sp),
                  ),
                ),
                StreamBuilder<List<Appointment>>(
                  stream: CommonDatabaseServices().getAppointmentsByUid(
                      'doctorId', doctorServicesProvider.doctor.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data!.length != 0) {
                      print('I am here');
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          // reverse: true,
                          itemBuilder: (context, index) {
                            Appointment appointment = snapshot.data![index];
                            return (appointment.status.compareTo('pending') ==
                                    0)
                                ? EditableAppointmentCard(
                                    text:
                                        '${index + 1}. Patient ${appointment.patientName} with the personal number ${appointment.patientPersonalNumber} has scheduled a ${appointment.visitType} with you.\n${appointment.date}, at ${appointment.slot.substring(0, appointment.slot.indexOf('-'))}',
                                    status: '${appointment.status}')
                                : AppointmentCard(
                                    text:
                                        '${index + 1}. Patient ${appointment.patientName} with the personal number ${appointment.patientPersonalNumber} has scheduled a ${appointment.visitType} with you.\n${appointment.date}, at ${appointment.slot.substring(0, appointment.slot.indexOf('-'))}',
                                    status: '${appointment.status}',
                                    buttonTitle: 'Start Consultation',
                                    destination: StartConsultationScreen.id,
                                    buttonColor: Color(0xFF5D99C6),
                                  );
                          });
                    } else if (snapshot.data != null &&
                        snapshot.data!.length == 0) {
                      print('No data');
                      return Padding(
                        padding: EdgeInsets.only(top: 150.h, bottom: 150.h),
                        child: Center(
                          child: Text(
                            'You have no appointment requests.',
                            style: kCardTextStyle.copyWith(
                                fontSize: 18.sp, color: Colors.black),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error.toString());
                      return Center(
                        child: Text(
                          'There is an issue with the server',
                          style: kCardTextStyle.copyWith(fontSize: 18.sp),
                        ),
                      );
                    } else {
                      return Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: CircleAvatar(
                          radius: 120.w,
                          child: Image.asset('images/no-connection-image.jpg'),
                        ),
                      ));
                      //TODO: SHOW A CICRCLE AVATAR WITH AN IMAGE THAT INDICATES THERE IS NO INTERNET CONNECTION
                      //return Center(child: CircularProgressIndicator());
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
