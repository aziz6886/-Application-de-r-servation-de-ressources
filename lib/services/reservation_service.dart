import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reservation_model.dart';

class ReservationService {
  final CollectionReference _reservationRef =
  FirebaseFirestore.instance.collection('reservations');

  /// CREATE reservation
  Future<void> createReservation(ReservationModel reservation) async {
    await _reservationRef.add(reservation.toFirestore());
  }

  /// GET reservations for a specific resource (used in calendar)
  Stream<List<ReservationModel>> getReservationsForResource(
      String resourceId,
      ) {
    return _reservationRef
        .where('resourceId', isEqualTo: resourceId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ReservationModel.fromFirestore(doc))
          .toList();
    });
  }

  /// GET reservations for a user (My reservations)
  Stream<List<ReservationModel>> getUserReservations(String userId) {
    return _reservationRef
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ReservationModel.fromFirestore(doc))
          .toList();
    });
  }

  /// DELETE reservation (optional)
  Future<void> deleteReservation(String reservationId) async {
    await _reservationRef.doc(reservationId).delete();
  }
}
