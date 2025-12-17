import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../providers/calendar_provider.dart';
import '../../models/reservation_model.dart';

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
    context.read<CalendarProvider>().loadReservations(widget.resourceId);
  }

  @override
  Widget build(BuildContext context) {
    final calendar = context.watch<CalendarProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Reserve ${widget.resourceName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// CALENDAR
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) =>
                  isSameDay(_selectedDay, day),
              enabledDayPredicate: (day) =>
                  calendar.isDateAvailable(day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarFormat: CalendarFormat.month,
            ),

            const SizedBox(height: 20),

            const Text(
              "Available Time Slots",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            /// TIME SLOTS
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: timeSlots.map((slot) {
                final isSelected = selectedTimeSlot == slot;
                return ChoiceChip(
                  label: Text(slot),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedTimeSlot = slot;
                    });
                  },
                );
              }).toList(),
            ),

            const Spacer(),

            /// CONFIRM BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_selectedDay == null || selectedTimeSlot == null)
                    ? null
                    : () async {
                  final userId =
                      FirebaseAuth.instance.currentUser!.uid;

                  final times =
                  selectedTimeSlot!.split(" - ");

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
                    userId: userId,
                    date: _selectedDay!,
                    startTime: startTime,
                    endTime: endTime,
                    status: 'pending',
                  );

                  await context
                      .read<CalendarProvider>()
                      .createReservation(reservation);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                        Text("Reservation created successfully")),
                  );

                  Navigator.pop(context);
                },
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
}
