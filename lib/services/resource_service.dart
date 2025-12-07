import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/resource_model.dart';

class ResourceService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // STREAM: Get resources in real-time
  Stream<List<Resource>> getResources() {
    return _db.collection('resources').snapshots().map(
          (snapshot) {
        return snapshot.docs.map(
              (doc) => Resource.fromMap(doc.id, doc.data()),
        ).toList();
      },
    );
  }
}
