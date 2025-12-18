import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/resource_model.dart';

class ResourceService {
  final _db = FirebaseFirestore.instance.collection('resources');

  Stream<List<Resource>> getResources() {
    return _db.snapshots().map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => Resource.fromMap(doc.id, doc.data()),
      )
          .toList(),
    );
  }

  Future<void> addResource(Resource resource) async {
    await _db.add(resource.toMap());
  }

  Future<void> updateResource(Resource resource) async {
    await _db.doc(resource.id).update(resource.toMap());
  }

  Future<void> deleteResource(String id) async {
    await _db.doc(id).delete();
  }
}
