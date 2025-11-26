import 'package:flutter/material.dart';
import '../../widgets/resource_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Temporary resource list (later will come from Firebase)
    final List<Map<String, dynamic>> resources = [
      {
        "name": "Meeting Room A",
        "description": "Capacity: 10 people",
        "image": "https://via.placeholder.com/150"
      },
      {
        "name": "Conference Room B",
        "description": "Capacity: 20 people",
        "image": "https://via.placeholder.com/150"
      },
      {
        "name": "Company Car",
        "description": "Available for business trips",
        "image": "https://via.placeholder.com/150"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resources"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: resources.length,
        itemBuilder: (context, index) {
          return ResourceCard(
            name: resources[index]["name"],
            description: resources[index]["description"],
            imageUrl: resources[index]["image"],
          );
        },
      ),
    );
  }
}
