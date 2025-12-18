import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationModel {
  final String id;
  final String resourceId;
  final String resourceName;
  final String userId;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final String status; // pending, approved, rejected

  ReservationModel({
    required this.id,
    required this.resourceId,
    required this.resourceName,
    required this.userId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  factory ReservationModel.fromFirestore(
      DocumentSnapshot doc,
      ) {
    final data = doc.data() as Map<String, dynamic>;

    return ReservationModel(
      id: doc.id,
      resourceId: data['resourceId'],
      resourceName: data['resourceName'],
      userId: data['userId'],
      date: (data['date'] as Timestamp).toDate(),
      startTime: (data['startTime'] as Timestamp).toDate(),
      endTime: (data['endTime'] as Timestamp).toDate(),
      status: data['status'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'resourceId': resourceId,
      'resourceName': resourceName,
      'userId': userId,
      'date': Timestamp.fromDate(date),
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'status': status,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
