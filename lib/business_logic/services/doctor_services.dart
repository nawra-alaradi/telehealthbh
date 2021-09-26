import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:telehealth_bh_app/business_logic/modals/doctor_model.dart';
import 'package:flutter/foundation.dart';

class DoctorServices extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _firestore =
      FirebaseFirestore.instance.collection('doctors');
  User? _user;
  Doctor _doctor = Doctor(
      uid: ' ',
      email: "  ",
      name: "  ",
      gender: "  ",
      phone: "  ",
      speciality: "  "); //Used to load the doctor's document

  Doctor get doctor => _doctor;
  User? get user => _user;
  FirebaseAuth get auth => _auth;

  Future<bool> doctorSignIn(String? email, String? password) async {
    try {
      //TODO: CHECK DOES THE EMAIL.TOLOWERCASE() EXISTS WITHIN THE DOCTORS COLLECTION? ==> QUERY DOCTORS COLLECTION IF EMPTY DO  NOT ALLOW SIGN IN

      if (email != null && password != null) {
        QuerySnapshot querySnapshot = await _firestore
            .where('email', isEqualTo: email.toLowerCase())
            .get();
        final _docData = querySnapshot.docs.map((doc) => doc.data()).toList();
        print(_docData);
        if (_docData.isEmpty) return false;

        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        _user = userCredential.user;
        if (_user != null) {
          final String uid = _user!.uid;
          print('Doctor uid is $uid');
          DocumentSnapshot documentDetails = await _firestore.doc(uid).get();
          print(documentDetails.data());
          _doctor = Doctor(
              uid: _user!.uid,
              email: documentDetails['email'],
              name: documentDetails['name'],
              gender: documentDetails['gender'],
              phone: documentDetails['phone number'],
              speciality: documentDetails['speciality']);
          print('email: ${_doctor.email}');
          print('name: ${_doctor.name}');
          print('gender: ${_doctor.gender}');
          print('phone: ${_doctor.phone}');
          print('speciality: ${_doctor.speciality}');
        }
      }
      notifyListeners(); //notify listeners about the doctor object change
      return true;
    } catch (e) {
      notifyListeners();
      return false;
    }
  }

  // sign out    //TODO: Do I need to notify listeners?
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //TODO: Do I need to notify listeners?
  //This method is used to validate the email address once the doctor requests to reset his password
  Future<bool> ensureEmailExistsInDoctorsDataBase(String emailAddress) async {
    var querySnapshot =
        await _firestore.where('email', isEqualTo: emailAddress).get();
    final _docData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //found a match
    if (_docData.isNotEmpty)
      return true;
    //did not find a match
    else
      return false;
  }
  //DEprectaed does not work at all !! :((
  // Doctor _doctorDataFromFirebase(Map<String, dynamic> document) {
  //   Doctor(
  //       email: document['email'],
  //       name: document['name'],
  //       gender: document['gender'],
  //       phone: document['phone number'],
  //       speciality: document['speciality']);
  // }
}
