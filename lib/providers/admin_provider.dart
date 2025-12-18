import 'package:flutter/material.dart';
import '../models/reservation_model.dart';
import '../services/admin_service.dart';

class AdminProvider extends ChangeNotifier {
  final AdminService _service = AdminService();

  Stream<List<ReservationModel>> get reservations =>
      _service.getAllReservations();

  Future<void> approve(String id) async {
    await _service.updateStatus(id, 'approved');
  }

  Future<void> reject(String id) async {
    await _service.updateStatus(id, 'rejected');
  }
}
