import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/resource_provider.dart';
import '../../../models/resource_model.dart';
import '../../widgets/resource_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resources"),
        centerTitle: true,
      ),

      body: StreamBuilder<List<Resource>>(
        stream: context.watch<ResourceProvider>().resourcesStream,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No resources available"));
          }

          final resources = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: resources.length,
            itemBuilder: (context, index) {
              final r = resources[index];
              return ResourceCard(
                name: r.name,
                description: r.description,
                imageUrl: r.imageUrl,
              );
            },
          );
        },
      ),
    );
  }
}
