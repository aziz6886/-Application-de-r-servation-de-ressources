class Resource {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  Resource({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory Resource.fromMap(String id, Map<String, dynamic> data) {
    return Resource(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  Resource copyWith({
    String? name,
    String? description,
    String? imageUrl,
  }) {
    return Resource(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
