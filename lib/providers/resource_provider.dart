import 'package:flutter/material.dart';
import '../models/resource_model.dart';
import '../services/resource_service.dart';

class ResourceProvider extends ChangeNotifier {
  final ResourceService _service = ResourceService();

  Stream<List<Resource>> get resourcesStream => _service.getResources();
}
