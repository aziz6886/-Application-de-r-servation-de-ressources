import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/resource_provider.dart';
import '../../../models/resource_model.dart';

class EditResourcePage extends StatelessWidget {
  final Resource resource;

  const EditResourcePage({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    final nameCtrl = TextEditingController(text: resource.name);
    final descCtrl = TextEditingController(text: resource.description);
    final imgCtrl = TextEditingController(text: resource.imageUrl);

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Resource")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameCtrl),
            TextField(controller: descCtrl),
            TextField(controller: imgCtrl),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<ResourceProvider>().update(
                  resource.copyWith(
                    name: nameCtrl.text,
                    description: descCtrl.text,
                    imageUrl: imgCtrl.text,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
