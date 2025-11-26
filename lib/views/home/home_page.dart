import 'package:flutter/material.dart';
import '../../widgets/resource_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Temporary resource list (later will come from Firebase)
    final List<Map<String, dynamic>> resources = [
      {
        "name": "• Salles de réunion",
        "description": "Capacity: 10 people",
        "image": ""
      },
      {
        "name": "véhicules",
        "description": "Capacity: 20 people",
        "image": ""
      },
      {
        "name": "ordinateurs",
        "description": "Available for business trips",
        "image": ""
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
