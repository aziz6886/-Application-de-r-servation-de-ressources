import 'package:flutter/material.dart';
import '../models/resource_model.dart';
import '../services/resource_service.dart';

class ResourceProvider extends ChangeNotifier {
  final ResourceService _service = ResourceService();

  Stream<List<Resource>> get resourcesStream => _service.getResources();


  Future<void> add(Resource resource) async {
    await _service.addResource(resource);
    notifyListeners();
  }
  Future<void> update(Resource resource) async {
    await _service.updateResource(resource);
    notifyListeners();
  }
  Future<void> delete(String resourceId) async {
    await _service.deleteResource(resourceId);
    notifyListeners();
  }

}
