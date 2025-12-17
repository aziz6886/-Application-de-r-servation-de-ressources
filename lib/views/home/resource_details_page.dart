import 'package:flutter/material.dart';
import '../calendar/agenda_avec_reservations.dart';

class ResourceDetailsPage extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;

  const ResourceDetailsPage({
    super.key,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // Name
            Text(
              name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // Description
            Text(
              description,
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 30),

            // Reserve Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalendarPage(resourceName: name),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text("Reserve", style: TextStyle(fontSize: 18)),
                ),

              )

            ),

          ],
        ),
      ),
    );
  }
}
