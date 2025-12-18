import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reservation_model.dart';

class AdminService {
  final CollectionReference _ref =
  FirebaseFirestore.instance.collection('reservations');

  /// 🔥 Get ALL reservations
  Stream<List<ReservationModel>> getAllReservations() {
    return _ref
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ReservationModel.fromFirestore(doc))
          .toList();
    });
  }

  /// ✅ Update reservation status
  Future<void> updateStatus(String id, String status) async {
    await _ref.doc(id).update({'status': status});
  }
}
