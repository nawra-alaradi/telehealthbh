import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telehealth_bh_app/components/my_drop_down_button.dart';
import 'package:intl/intl.dart';
import 'package:telehealth_bh_app/components/small_elevated_button.dart';
import 'package:telehealth_bh_app/components/my_date_picker_button.dart';
//import 'payment_screen.dart';
import 'package:telehealth_bh_app/components/my_circular_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telehealth_bh_app/business_logic/services/patient_services.dart';
import 'package:provider/provider.dart';
import 'patient_route.dart';

class BookAppointmentScreen extends StatefulWidget {
  static final String id = 'BookAppointmentScreen';
  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final MyCircularProgressIndicator progressIndicator =
      MyCircularProgressIndicator();
  String? _chosenVisit, _chosenSpeciality, _chosenDoctor, _chosenTime;
  List<String> _visitTypes = ['Live Consultation', 'Walk-in appointment'];
  List<String> _specialities = [
    'Cardiology',
    'Chest Diseases',
    'Endocrinology',
    'Gastroenterology',
    'Neurology',
    'Nephrology',
    'General Surgery',
    'Neurosurgery',
    'Thoracic/Vascular Surgery',
    'General Pediatrics'
  ];
  List<String> _doctors = [];
  DateTime? date;
  String _chosenDate =
      ''; //TODO: Use the provider package to notify the selected doctor about the appointment time if confirmed

  List<String> _doctorsUids = [];
  List<String> _doctorsNamesFromFirebase = [];
  String getText() {
    if (date == null) {
      return 'Select Date';
    } else {
      //This will not throw an error since this is executed when the date is not null
      //print('date: $date'); //output format e.g.: 2021-08-10 00:00:00.000
      _chosenDate =
          DateFormat('yyyy-MM-dd').format(date!); //change format to 10/08/2021
      // print('selectedDate: $selectedDate');
      return _chosenDate;
      // or return '${date.month}/${date.day}/${date.year}';
    }
  }

  //Customize the initialDay and firstDay to be the next valid day of the week
  DateTime getInitialDate() {
    //If today is Thursday I need to add three days
    if (DateTime.now().weekday == 4)
      return DateTime.now().add(Duration(days: 3));
    //If Today is Friday add two days to set initialDay and first day
    else if (DateTime.now().weekday == 5)
      return DateTime.now().add(Duration(days: 2));
    //else if today is saturday or any other day add 1 day as an initial day
    else
      return DateTime.now().add(Duration(days: 1));
  }

//Function to output date picker and update
  Future pickDate(BuildContext context) async {
    // final initialDate = DateTime.now().add(Duration(days: 1));
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ??
          getInitialDate(), //if the date is null show the date of today otherwise show the selected date
      firstDate: getInitialDate(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      //Fridays and Saturdays are off days
      selectableDayPredicate: (DateTime val) =>
          (val.weekday == 5 || val.weekday == 6) ? false : true,
      builder: (context, child) {
        _chosenTime =
            null; // reset the time slots since the user may have picked another date
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
    setState(() => date = newDate);
    progressIndicator.buildShowDialog(context);
    await filterTimeSlots(DateFormat('yyyy-MM-dd').format(date!));
    Navigator.pop(context);
  }

//TODO: retrieve the time slots from firebase
  List<String> _timeSlots = [
    '08:00-08:30',
    '08:30-09:00',
    '09:00-09:30',
    '09:30-10:00',
    '10:00-10:30',
    '10:30-11:00',
    '11:00-11:30',
    '11:30-12:00',
    '12:00-12:30',
    '12:30-13:00',
    '13:00-13:30',
    '13:30-14:00'
  ];

  Future getDoctorsNamesFromFirebase(String speciality) async {
    //whenever a new speciality is selected; start with fresh lists
    _doctorsNamesFromFirebase = [];
    _doctorsUids = [];
    print(speciality);
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('doctors')
        .where('speciality', isEqualTo: speciality)
        .get()
        .catchError((onError) {
      print('Somethig wrong with fliter time slots');
    });

    final _docData = querySnapshot.docs
        .map((doc) => doc.data())
        .toList(); // convert into a list
    print(_docData);
    for (int i = 0; i < _docData.length; i++) {
      _doctorsNamesFromFirebase
          .add((_docData[i] as Map<String, dynamic>)['name']);
      print((_docData[i] as Map<String, dynamic>)['name']);
      _doctorsUids.add(querySnapshot.docs[i].id);
    }
    print(_doctorsNamesFromFirebase);
    print(_doctorsUids);
    setState(() {
      _doctors = _doctorsNamesFromFirebase;
    });
    // return _doctorsNamesFromFirebase;
  }

  Future filterTimeSlots(String pickedDate) async {
    // repopulate the time slots whenever a new date has been chosen
    _timeSlots = [
      '08:00-08:30',
      '08:30-09:00',
      '09:00-09:30',
      '09:30-10:00',
      '10:00-10:30',
      '10:30-11:00',
      '11:00-11:30',
      '11:30-12:00',
      '12:00-12:30',
      '12:30-13:00',
      '13:00-13:30',
      '13:30-14:00'
    ];

    List<String> tokenTimeSlots = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('date', isEqualTo: pickedDate)
        .where('doctorId',
            isEqualTo:
                _doctorsUids[_doctorsNamesFromFirebase.indexOf(_chosenDoctor!)])
        .get()
        .catchError(
            (onError) => print('sth wrong with filterTimeSlots() method'));

    print('docs: ${querySnapshot.docs}');
    final _docData = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList(); // convert into a list
    print('This appointment has been booked before$_docData');
    for (int i = 0; i < _docData.length; i++) {
      tokenTimeSlots.add((_docData[i])['slot']);
      _timeSlots.remove((_docData[i])['slot']);
    }
    //update the UI
    setState(() {
      _timeSlots;
    });
  }

  //Cover all error issues
  Future<bool> getMyBookedApptAtSameDateTime() async {
    //Find an appointment for the patient that has been accepted before at the same date and time
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('date', isEqualTo: _chosenDate)
        .where('slot', isEqualTo: _chosenTime)
        .where('status', isEqualTo: 'accepted')
        .where('patientId',
            isEqualTo: Provider.of<PatientServices>(context, listen: false)
                .patient
                .uid)
        .get()
        .catchError((onError) =>
            print('sth wrong with getMyBookedApptAtSameDateTime() method'));
    print('docs: ${querySnapshot.docs}');
    final _docData = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList(); // convert into a list
    print('This appointment has been booked before$_docData');
    if (_docData.isNotEmpty)
      return false; //if the patient has an appointment at the same date and time then he can not schedule another appointment
    else {
      //Find an appointment for the patient that is pending at the same date and time
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('date', isEqualTo: _chosenDate)
          .where('slot', isEqualTo: _chosenTime)
          .where('status', isEqualTo: 'pending')
          .where('patientId',
              isEqualTo: Provider.of<PatientServices>(context, listen: false)
                  .patient
                  .uid)
          .get()
          .catchError((onError) =>
              print('sth wrong with getMyBookedApptAtSameDateTime() method'));
      print('docs: ${querySnapshot.docs}');
      final _docData = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList(); // convert into a list
      print('This appointment has been booked before$_docData');
      if (_docData.isNotEmpty)
        return false; //if the patient has an appointment at the same date and time then he can not schedule another appointment
      else
        return true; //else the patient can proceed to book a new appointment
    }

    //suppose the user have booked an appointment with the same doctor and wants to book a new appointment with him ==>
    //show an Alert Dialog that says he has already booked an appointment with this doctor ==> Does he wish to continue ? this will overwrite the appointment with the different date and time
    //Does he wish to cancel ==> just pop up the dialog and do nothing ==> the user is expected to choose another doctor so do not book the appointment==> do not go to the else part
  }

  Future<bool> hadAlreadyBookedAppointmentWithSelectedDoc() async {
    //Find an appointment for the patient that has been booked before at the same date and time
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('doctorId',
            isEqualTo:
                _doctorsUids[_doctorsNamesFromFirebase.indexOf(_chosenDoctor!)])
        .where('patientId',
            isEqualTo: Provider.of<PatientServices>(context, listen: false)
                .patient
                .uid)
        .where('status', isEqualTo: 'pending')
        .get()
        .catchError((onError) => print(
            'sth wrong with hadAlreadyBookedAppointmentWithSelectedDoc() method'));
    print('docs: ${querySnapshot.docs}');
    final _docData = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList(); // convert into a list
    print('This appointment has been booked before$_docData');
    if (_docData.isNotEmpty)
      return false; //if the patient has an appointment at the same date and time then he can not schedule another appointment
    else
      return true; //else the patient can proceed to book a new appointment
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
        centerTitle: true,
        titleTextStyle: kAppBarTextStyle.copyWith(fontSize: 16.sp),
        title: Text(
          'Book an Appointment',
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
        child: ListView(
          padding:
              EdgeInsets.only(top: 43.h, left: 22.w, right: 27.w, bottom: 46.h),
          children: [
            MyDropdownButton(
              chosenItem: _chosenVisit,
              hint: 'Select Visit Type',
              itemsList: _visitTypes,
              onChanged: (String? newValue) {
                setState(() {
                  _chosenVisit = newValue!;
                });
              },
            ),
            SizedBox(
              height: 27.h,
            ),
            MyDropdownButton(
              chosenItem: _chosenSpeciality,
              hint: 'Select Speciality',
              itemsList: (_chosenVisit == null) ? [] : _specialities,
              onChanged: (String? newValue) async {
                setState(() {
                  _chosenSpeciality = newValue!;
                  _chosenDoctor = null;
                  _chosenTime = null;
                  date = null;
                  //TODO: Acquire the list of doctors names with this speciality
                });
                if (_chosenSpeciality != null) {
                  progressIndicator.buildShowDialog(context);
                  await getDoctorsNamesFromFirebase(_chosenSpeciality!);
                  Navigator.pop(context);
                }
                //print(_chosenSpeciality);
              },
            ),
            SizedBox(
              height: 27.h,
            ),
            MyDropdownButton(
              chosenItem: _chosenDoctor,
              hint: 'Select a Doctor',
              itemsList: _doctors,
              onChanged: (String? newValue) {
                setState(() {
                  _chosenDoctor = newValue!;
                });
              },
            ),
            SizedBox(
              height: 27.h,
            ),
            MyDatePickerButton(
              text: getText(),
              onPressed: (_chosenVisit == null ||
                      _chosenSpeciality == null ||
                      _chosenDoctor == null)
                  ? null
                  : () => pickDate(context),
            ),
            SizedBox(
              height: 27.h,
            ),
            MyDropdownButton(
              chosenItem: _chosenTime,
              hint: 'Select a Time Slot',
              itemsList: (_chosenVisit == null ||
                      _chosenSpeciality == null ||
                      _chosenDoctor == null ||
                      date == null)
                  ? []
                  : _timeSlots,
              onChanged: (String? newValue) {
                setState(() {
                  _chosenTime = newValue!;
                });
              },
            ),
            SizedBox(
              height: 27.h,
            ),
            Row(
              children: [
                Text(
                  'Price',
                  style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Container(
                  width: 75.w,
                  height: 38.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.w),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                    child: Text(
                      '10 BD',
                      style: TextStyle(
                          fontFamily: 'Work Sans',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 72.h,
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
                padding: EdgeInsets.only(left: 80.w, right: 80.w),
                child: FittedBox(
                  child: SmallElevatedButton(
                    text: 'Book',
                    color: Color(0xFF90CAF9),
                    onPressed: (_chosenVisit == null ||
                            _chosenSpeciality == null ||
                            _chosenDoctor == null ||
                            _chosenTime == null ||
                            date == null)
                        ? null
                        : () async {
                            print('date value as a datetime: $date');
                            print('DateTime.now result ${DateTime.now()}');
                            print(
                                'concatenation Results $_chosenDate ${_chosenTime!.substring(0, _chosenTime!.indexOf('-'))}:00.000');
                            DateTime appointmentStartTime = DateTime.parse(
                                '$_chosenDate ${_chosenTime!.substring(0, _chosenTime!.indexOf('-'))}:00.000');
                            DateTime appointmentEndTime = DateTime.parse(
                                '$_chosenDate ${_chosenTime!.substring(_chosenTime!.indexOf('-') + 1, _chosenTime!.length)}:00.000');

                            //TODO: Validate all user input, if all are valid go to next screen
                            //TODO: Check user type resident or citizen
                            //TODO: if resident go to payment screen
                            //TODO: VERIFY THAT THE USER HAS NOT BOOKED AN APPOINTMENT BEFORE AT SAME DATE AND TIME
                            bool result = await getMyBookedApptAtSameDateTime();
                            if (!result) {
                              //false means the patient can not book an appointment at same date and time with another doctor

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  'You have an appointment at this date and time please choose another time slot',
                                  style: kSnackbarTextStyle.copyWith(
                                      fontSize: 16.sp),
                                ),
                                duration: Duration(milliseconds: 5000),
                              ));
                            } else {
                              //TODO: CHECK DID THE PATIENT BOOKED AN APPOINTMENT WITH THE DOCTOR BEFORE BUT WISHES TO CHANGE THE TIME OR DATE
                              bool res =
                                  await hadAlreadyBookedAppointmentWithSelectedDoc();
                              if (!res) {
                                //user had booked an appointment with this doctor
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        title: Text(
                                          'Warning',
                                          style: kBodyTextStyle.copyWith(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        contentPadding: EdgeInsets.all(20.sp),
                                        content: Text(
                                          'You have booked an appointment with this doctor before, but its date and time have not reached.\nDo you wish to proceed with the new changes or cancel the change?',
                                          style: kAppBarTextStyle.copyWith(
                                              fontSize: 16.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: Text(
                                              'Cancel',
                                              style: kBodyTextStyle.copyWith(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.lightBlueAccent,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              //overwrite the appointment
                                              Provider.of<PatientServices>(
                                                      context,
                                                      listen: false)
                                                  .addAppointment(
                                                      doctorId: _doctorsUids[
                                                          _doctorsNamesFromFirebase
                                                              .indexOf(
                                                                  _chosenDoctor!)],
                                                      doctorName:
                                                          _chosenDoctor!,
                                                      date: _chosenDate,
                                                      slot: _chosenTime!,
                                                      status: 'pending',
                                                      vistType: _chosenVisit!,
                                                      createdOn:
                                                          Timestamp.now(),
                                                      startTime: Timestamp.fromDate(
                                                          appointmentStartTime),
                                                      endTime: Timestamp.fromDate(
                                                          appointmentEndTime));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  'The changes have successfully been applied to your appointment.',
                                                  style: kSnackbarTextStyle
                                                      .copyWith(
                                                          fontSize: 16.sp),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 5000),
                                              ));
                                              Navigator.pop(context, 'Proceed');
                                              Navigator.pushNamed(
                                                  context, PatientRoute.id);
                                            },
                                            child: Text(
                                              'Proceed',
                                              style: kBodyTextStyle.copyWith(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.lightBlueAccent,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              }

                              //add the new document with its id as docId_patId
                              //set its fields to the input fields
                              else {
                                Provider.of<PatientServices>(context,
                                        listen: false)
                                    .addAppointment(
                                        doctorId: _doctorsUids[
                                            _doctorsNamesFromFirebase
                                                .indexOf(_chosenDoctor!)],
                                        doctorName: _chosenDoctor!,
                                        date: _chosenDate,
                                        slot: _chosenTime!,
                                        status: 'pending',
                                        vistType: _chosenVisit!,
                                        createdOn: Timestamp.now(),
                                        startTime: Timestamp.fromDate(
                                            appointmentStartTime),
                                        endTime: Timestamp.fromDate(
                                            appointmentEndTime));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'The appointment has been successfully booked',
                                    style: kSnackbarTextStyle.copyWith(
                                        fontSize: 16.sp),
                                  ),
                                  duration: Duration(milliseconds: 5000),
                                ));
                                Navigator.pop(context);
                                //Navigator.pushNamed(context, PaymentScreen.id);
                                //TODO: if citizen go to reminder screen
                                // Navigator.pushNamed(
                                //     context, AppointmentConfirmationScreen.id);
                              }
                            }
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
