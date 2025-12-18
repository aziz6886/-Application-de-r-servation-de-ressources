import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reservation_model.dart';

class ReservationService {
  final CollectionReference _reservationRef =
  FirebaseFirestore.instance.collection('reservations');

  Future<void> createReservation(ReservationModel reservation) async {
    await _reservationRef.add(reservation.toFirestore());
  }

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

  Future<void> deleteReservation(String reservationId) async {
    await _reservationRef.doc(reservationId).delete();
  }
}
