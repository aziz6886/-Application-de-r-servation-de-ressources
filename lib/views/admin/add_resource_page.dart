import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/resource_provider.dart';
import '../../../models/resource_model.dart';

class AddResourcePage extends StatelessWidget {
  AddResourcePage({super.key});

  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final imgCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Resource")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: descCtrl, decoration: const InputDecoration(labelText: "Description")),
            TextField(controller: imgCtrl, decoration: const InputDecoration(labelText: "Image URL")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<ResourceProvider>().add(
                  Resource(
                    id: '',
                    name: nameCtrl.text,
                    description: descCtrl.text,
                    imageUrl: imgCtrl.text,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text("Create"),
            ),
          ],
        ),
      ),
    );
  }
}
