import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telehealth_bh_app/business_logic/modals/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
// import 'package:telehealth_bh_app/business_logic/modals/appointment_model.dart';

class PatientServices with ChangeNotifier {
  CollectionReference _firestore =
      FirebaseFirestore.instance.collection('patients');
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  Patient _patient = Patient(
      uid: ' ',
      personalNumber: "  ",
      email: '',
      birthDate: "  ",
      phone: "  ",
      name: "  ",
      gender: "  ",
      nationality:
          " "); //this is similar to a firebaseAuth user object but with additional attributes

  Patient get patient => _patient;

  User? get user => _user;

  FirebaseAuth get auth => _auth;

  // Stream<List<Appointment>> getPatientAppointments() {
  //   return FirebaseFirestore.instance
  //       .collection('appointments')
  //       .where('patientId', isEqualTo: patient.uid)
  //       .orderBy('appointment start time stamp', descending: true)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //           .map((document) => Appointment.fromJson(document.data()))
  //           .toList());
  // }

  Future<void> addAppointment(
      {required String doctorId,
      required String doctorName,
      required String date,
      required String slot,
      required String status,
      required String vistType,
      required Timestamp createdOn,
      required Timestamp startTime,
      required Timestamp endTime}) async {
    FirebaseFirestore.instance
        .collection('appointments')
        .doc("${doctorId}_${patient.uid}")
        .set({
      'appointmentId': '${doctorId}_${patient.uid}',
      'patientId': patient.uid,
      'patient name': patient.name,
      'patient personal number': patient.personalNumber,
      'doctorId': doctorId,
      'doctor name': doctorName,
      'date': date,
      'slot': slot,
      'status': status,
      'visit type': vistType,
      'createdOn': createdOn,
      'appointment start time stamp': startTime,
      'appointment end time stamp': endTime
    });
  }

  Future<String> patientSignIn(String? email, String? password) async {
    if (email != null && password != null) {
      QuerySnapshot querySnapshot =
          await _firestore.where('email', isEqualTo: email.toLowerCase()).get();
      final _docData = querySnapshot.docs.map((doc) => doc.data()).toList();
      print(_docData);
      if (_docData.isEmpty)
        return 'Inavlid Email';
      else {
        //sign the patient in if his email is verified
        //
        try {
          UserCredential userCredential = await _auth
              .signInWithEmailAndPassword(email: email, password: password);
          _user = userCredential.user;

          if (_user != null && !_user!.emailVerified) {
            return 'Your email has not been verified. Please verify your email';
          } else {
            //user has verified his email
            if (_user != null) {
              //user has verified his email
              final String uid = _user!.uid;
              print('Patient uid is $uid');
              DocumentSnapshot documentDetails =
                  await _firestore.doc(uid).get();
              print(documentDetails.data());
              _patient = Patient(
                  uid: _user!.uid,
                  name: documentDetails['name'],
                  personalNumber: documentDetails['personal number'],
                  gender: documentDetails['gender'],
                  birthDate: documentDetails['date of birth'],
                  nationality: documentDetails['nationality'],
                  phone: documentDetails['phone number'],
                  email: documentDetails['email']);
              print('name: ${_patient.name}');
              print('personal number: ${_patient.personalNumber}');
              print('gender: ${_patient.gender}');
              print('birth date: ${_patient.birthDate}');
              print('nationality: ${_patient.nationality}');
              print('phone: ${_patient.phone}');
              print('email: ${_patient.email}');
              notifyListeners(); //inform listeners about the  patient details
              return 'signed in successfully';
            }
          }
        } on FirebaseAuthException catch (e) {
          print('part1 is caught with error ${e.toString()}');
          print(e.toString());
          return 'Invalid password';
        } catch (e) {
          print('part2 is caught with error ${e.toString()}');
          return 'Unverified email';
        }
        return 'sth wrong';
      }
    } else {
      return 'no email and password are provided';
    }
  }

  Future<String> RegisterNewPatient(
      String name,
      String personalNumber,
      String gender,
      String DOB,
      String nationality,
      String phoneNumber,
      String email,
      String password) async {
    try {
      //Step 1 check is there a patient with this personal number but with another email address?
      QuerySnapshot querySnapshot = await _firestore
          .where('personal number', isEqualTo: personalNumber)
          .get();
      final _docData = querySnapshot.docs.map((doc) => doc.data()).toList();
      print(_docData);
      if (_docData.isNotEmpty)
        return 'An account already exists with this personal number. Please sign in to the application';
      // return 'An account with the email address ${(_docData[0] as Map<String, dynamic>)['email']} is associated with $personalNumber please sign in to the application';
      //Step2: create the account
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      _user = userCredential.user;
      //send email verification to the user
      if (!_user!.emailVerified) {
        await _user!.sendEmailVerification();
      }
      //create a new document inside patient collection with the user credentials
      print('this part is being executed');
      await _firestore.doc(_user!.uid).set({
        'name': name,
        'personal number': personalNumber,
        'gender': gender,
        'date of birth': DOB,
        'nationality': nationality,
        'phone number': phoneNumber,
        'email': email.toLowerCase(),
        'createdOn': FieldValue.serverTimestamp()
        // ignore: invalid_return_type_for_catch_error
      }).catchError((onError) {
        print('failed to add the patient $onError');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'An account already exists for this email.';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
    //todo: sign the user out to enforce email verificaton

    return 'An account with the email address $email has been successfully created. Please verify your account. Check your email inbox.';
  }

  Future<bool> ensureEmailExistsInPatientsDataBase(String emailAddress) async {
    //check patient collection is the email registered??
    var querySnapshot = await _firestore
        .where('email', isEqualTo: emailAddress.toLowerCase())
        .get();
    final _docData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //found a match
    if (_docData.isNotEmpty)
      return true;
    //did not find a match
    else
      return false;
  }

  //TODO: I am not sure if i need to add notify listeners here
  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
