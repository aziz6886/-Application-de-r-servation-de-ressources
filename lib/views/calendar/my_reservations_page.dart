import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/reservation_model.dart';
import '../../services/reservation_service.dart';

class MyReservationsPage extends StatelessWidget {
  MyReservationsPage({super.key});

  final ReservationService _reservationService = ReservationService();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Not authenticated")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Reservations"),
      ),
      body: StreamBuilder<List<ReservationModel>>(
        stream: _reservationService.getUserReservations(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No reservations yet"));
          }

          final reservations = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              final r = reservations[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(r.resourceName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Text(
                        "Date: ${r.date.toLocal().toString().split(' ')[0]}",
                      ),
                      Text(
                        "Time: ${_formatTime(r.startTime)} - ${_formatTime(r.endTime)}",
                      ),
                      Text(
                        "Status: ${r.status.toUpperCase()}",
                        style: TextStyle(
                          color: _statusColor(r.status),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  trailing: r.status == 'pending'
                      ? IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await _reservationService
                          .deleteReservation(r.id);
                    },
                  )
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return "$h:$m";
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
