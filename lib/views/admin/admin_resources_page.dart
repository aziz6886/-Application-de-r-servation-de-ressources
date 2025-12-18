import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/resource_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../models/resource_model.dart';

class AdminResourcesPage extends StatelessWidget {
  const AdminResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!context.watch<AuthProvider>().isAdmin) {
      return const Scaffold(
        body: Center(child: Text("Access denied")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Admin – Resources")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/admin/add-resource');
        },
      ),
      body: StreamBuilder<List<Resource>>(
        stream: context.watch<ResourceProvider>().resourcesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final resources = snapshot.data!;

          return ListView.builder(
            itemCount: resources.length,
            itemBuilder: (context, index) {
              final r = resources[index];

              return ListTile(
                title: Text(r.name),
                subtitle: Text(r.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/admin/edit-resource',
                          arguments: r,
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        context.read<ResourceProvider>().delete(r.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
