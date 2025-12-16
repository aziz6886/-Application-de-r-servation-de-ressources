import 'package:flutter/material.dart';
import '../models/reservation_model.dart';
import '../services/reservation_service.dart';

class CalendarProvider extends ChangeNotifier {
  final ReservationService _reservationService = ReservationService();

  DateTime selectedDate = DateTime.now();
  List<ReservationModel> reservations = [];

  /// Change selected date
  void selectDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  /// Listen to reservations for a resource
  void loadReservations(String resourceId) {
    _reservationService
        .getReservationsForResource(resourceId)
        .listen((data) {
      reservations = data;
      notifyListeners();
    });
  }

  /// Check if selected date is available
  bool isDateAvailable(DateTime date) {
    for (var reservation in reservations) {
      if (_isSameDay(reservation.date, date)) {
        return false;
      }
    }
    return true;
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year &&
        d1.month == d2.month &&
        d1.day == d2.day;
  }
}
