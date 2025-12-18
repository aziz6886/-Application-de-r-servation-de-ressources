import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/reservation_model.dart';
import '../../providers/calendar_provider.dart';
import '../../services/reservation_service.dart';

class CalendarPage extends StatefulWidget {
  final String resourceId;
  final String resourceName;

  const CalendarPage({
    super.key,
    required this.resourceId,
    required this.resourceName,
  });

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? selectedTimeSlot;

  final ReservationService _reservationService = ReservationService();

  final List<String> timeSlots = [
    "09:00 - 10:00",
    "10:00 - 11:00",
    "11:00 - 12:00",
    "14:00 - 15:00",
    "15:00 - 16:00",
    "16:00 - 17:00",
  ];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<CalendarProvider>()
          .loadReservations(widget.resourceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final calendarProvider = context.watch<CalendarProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Reserve ${widget.resourceName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) =>
                  isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                calendarProvider.setDate(selectedDay);
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  selectedTimeSlot = null;
                });
              },
              calendarFormat: CalendarFormat.month,
            ),

            const SizedBox(height: 20),

            /// ⏰ TIME SLOTS
            const Text(
              "Available Time Slots",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: timeSlots.map((slot) {
                final available =
                calendarProvider.isTimeSlotAvailable(slot);

                return ChoiceChip(
                  label: Text(slot),
                  selected: selectedTimeSlot == slot,
                  selectedColor: Colors.green,
                  disabledColor: Colors.grey.shade400,
                  onSelected: available
                      ? (_) {
                    setState(() {
                      selectedTimeSlot = slot;
                    });
                  }
                      : null,
                );
              }).toList(),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _confirmReservation,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    "Confirm Reservation",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmReservation() async {
    if (_selectedDay == null || selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select date and time")),
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final times = selectedTimeSlot!.split(" - ");

    final startTime = DateTime(
      _selectedDay!.year,
      _selectedDay!.month,
      _selectedDay!.day,
      int.parse(times[0].split(":")[0]),
    );

    final endTime = DateTime(
      _selectedDay!.year,
      _selectedDay!.month,
      _selectedDay!.day,
      int.parse(times[1].split(":")[0]),
    );

    final reservation = ReservationModel(
      id: '',
      resourceId: widget.resourceId,
      resourceName: widget.resourceName,
      userId: user.uid,
      date: _selectedDay!,
      startTime: startTime,
      endTime: endTime,
      status: 'pending',
    );

    await _reservationService.createReservation(reservation);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Reservation created")),
    );

    Navigator.pop(context);
  }
}
