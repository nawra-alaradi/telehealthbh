import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String patientId, patientName, patientPersonalNumber;
  final String doctorId, doctorName;
  final String date,
      slot,
      status,
      visitType,
      createdOn,
      appointmentStartTimestamp,
      appointmentEndTimestamp;

  Appointment(
      {required this.patientId,
      required this.patientName,
      required this.patientPersonalNumber,
      required this.doctorId,
      required this.doctorName,
      required this.date,
      required this.slot,
      required this.status,
      required this.visitType,
      required this.createdOn,
      required this.appointmentStartTimestamp,
      required this.appointmentEndTimestamp});

  Appointment.fromJson(Map<String, dynamic> parsedJson)
      : patientId = parsedJson['patientId'],
        patientName = parsedJson['patient name'],
        patientPersonalNumber = parsedJson['patient personal number'],
        doctorId = parsedJson['doctorId'],
        doctorName = parsedJson['doctor name'],
        date = parsedJson['date'],
        slot = parsedJson['slot'],
        status = parsedJson['status'],
        visitType = parsedJson['visit type'],
        createdOn = (parsedJson['createdOn'] as Timestamp).toDate().toString(),
        appointmentStartTimestamp =
            (parsedJson['appointment start time stamp'] as Timestamp)
                .toDate()
                .toString(), //convert Timestamp into a datetime
        appointmentEndTimestamp =
            (parsedJson['appointment end time stamp'] as Timestamp)
                .toDate()
                .toString();
}
