import 'package:flutter/material.dart';
import '../models/reservation_model.dart';
import '../services/reservation_service.dart';

class CalendarProvider extends ChangeNotifier {
  final ReservationService _reservationService = ReservationService();

  DateTime selectedDate = DateTime.now();
  List<ReservationModel> reservations = [];

  /// Load reservations for resource
  void loadReservations(String resourceId) {
    _reservationService
        .getReservationsForResource(resourceId)
        .listen((data) {
      reservations = data;
      notifyListeners();
    });
  }

  /// Change selected date
  void setDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  /// Check if time slot is already reserved
  bool isTimeSlotAvailable(String slot) {
    final times = slot.split(" - ");

    final startHour = int.parse(times[0].split(":")[0]);
    final endHour = int.parse(times[1].split(":")[0]);

    for (var r in reservations) {
      if (_isSameDay(r.date, selectedDate)) {
        if (r.startTime.hour == startHour &&
            r.endTime.hour == endHour) {
          return false;
        }
      }
    }
    return true;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }
}
