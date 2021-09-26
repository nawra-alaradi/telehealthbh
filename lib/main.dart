import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:telehealth_bh_app/business_logic/view%20modals/form_provider_view_model.dart';
import 'package:telehealth_bh_app/screens/welcome_screen.dart';
import 'screens/email_screen.dart';
import 'package:telehealth_bh_app/screens/Patient/patient_route.dart';
import 'package:telehealth_bh_app/screens/Doctor/doctor_start_consultation.dart';
import 'package:telehealth_bh_app/screens/Doctor/doctor_profile_screen.dart';
import 'package:telehealth_bh_app/screens/Doctor/doctor_home.dart';
import 'package:telehealth_bh_app/screens/Doctor/requests_screen.dart';
import 'package:telehealth_bh_app/screens/Patient/book_appointment_screen.dart';
import 'package:telehealth_bh_app/screens/Patient/payment_screen.dart';
import 'package:telehealth_bh_app/screens/Patient/appointment_confirmed_screen.dart';
import 'package:telehealth_bh_app/screens/Patient/my_appointments_screen.dart';
import 'package:telehealth_bh_app/screens/Patient/join_consultation_screen.dart';
import 'package:telehealth_bh_app/screens/Patient/notifications_screen.dart';
import 'package:telehealth_bh_app/screens/Patient/patient_profile_screen.dart';
import 'package:telehealth_bh_app/screens/Patient/patient_home_screen.dart';
import 'package:telehealth_bh_app/business_logic/services/firebase_initialization.dart';
import 'package:telehealth_bh_app/business_logic/services/doctor_services.dart';
import 'package:telehealth_bh_app/business_logic/services/patient_services.dart';
import 'screens/Patient/patient_registration_screen.dart';
import 'package:telehealth_bh_app/screens/login_screen.dart';
import 'screens/login_screen.dart';
import 'package:telehealth_bh_app/screens/Patient/chatbot_screen.dart';
void main() async {
  //added 7th sep

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FirebaseService service = FirebaseService();
  await service.initializeFlutterFire();
  final patientServices = PatientServices();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<PatientServices>(
      create: (_) => patientServices, //modified 7th sept
    ),
    ChangeNotifierProvider<DoctorServices>(
      create: (_) => DoctorServices(),
    ),
    ChangeNotifierProvider<FormProvider>(
      create: (_) => FormProvider(),
    ),
  ], child: new MyApp()));
}

//for the time being  ignore: use_key_in_widget_constructors; consider it later
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: () => MaterialApp(
        theme: ThemeData(
          primaryColor: const Color(
              0xFF0D47A1), // for the main parts of the screen like app var
          primaryColorLight:
              const Color(0xFF5472d3), // variations of the primary color
          primaryColorDark: const Color(0xFF002171),
          backgroundColor: Colors
              .transparent, // set transparent background to allow the image fills the background
          primaryColorBrightness: Brightness.dark,
          scaffoldBackgroundColor: Colors
              .transparent, // set transparent background to allow the image fills the background of the screen
          hintColor: const Color(0xFF9E9E9E),
          dividerColor: const Color(0xFFBDBDBD),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          textTheme: const TextTheme(
            button: TextStyle(
              color: Color(0xFFFFFFFF),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Color(
                  0xFF5D99C6), //set default color for the elevation button used for (welcome+ dr) screens
              onPrimary: Color(0x00000000)
                  .withOpacity(0.8), //black color with 80% opacity
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          EmailScreen.id: (context) => EmailScreen(),
          StartConsultationScreen.id: (context) => StartConsultationScreen(),
          DoctorProfileScreen.id: (context) => DoctorProfileScreen(),
          DoctorHome.id: (context) => DoctorHome(),
          RequestsScreen.id: (context) => RequestsScreen(),
          PatientRoute.id: (context) => PatientRoute(),
          PatientHomeScreen.id: (context) => PatientHomeScreen(),
          BookAppointmentScreen.id: (context) => BookAppointmentScreen(),
          PaymentScreen.id: (context) => PaymentScreen(),
          AppointmentConfirmationScreen.id: (context) =>
              AppointmentConfirmationScreen(),
          MyAppointmentsScreen.id: (context) => MyAppointmentsScreen(),
          PatientProfileScreen.id: (context) => PatientProfileScreen(),
          NotificationsScreen.id: (context) => NotificationsScreen(),
          JoinConsultationScreen.id: (context) => JoinConsultationScreen(),
          PatientRegistrationScreen.id: (context) =>
              PatientRegistrationScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          ChatbotScreen.id:(context)=>ChatbotScreen(),
        },
      ),
    );
  }
}
