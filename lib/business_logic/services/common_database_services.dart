import 'package:telehealth_bh_app/business_logic/modals/appointment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommonDatabaseServices {
  final _collextionRef = FirebaseFirestore.instance.collection('appointments');

  Stream<List<Appointment>> getAppointmentsByUid(
      String uidKeyField, String uidValue) {
    return _collextionRef
        .where(uidKeyField, isEqualTo: uidValue)
        //.where('status', isEqualTo: 'booked')
        .orderBy('appointment start time stamp', descending: false)
        .snapshots()
        .map((snapshot) {
      print('snapshot doc ${snapshot.docs}');
      return snapshot.docs.map((document) {
        print('document data: ${Appointment.fromJson(document.data())}');
        return Appointment.fromJson(document.data());
      }).toList();
    });
  }
}
