import '../../domain/entities/wedding.dart';

class WeddingModel extends Wedding {
  WeddingModel({
    required String id,
    required String name,
    required String userId,
    required DateTime date,
    required String location,
    String? description,
    String? imageUrl,
    double? budget,
  }) : super(
          id: id,
          name: name,
          userId: userId,
          date: date,
          location: location,
          description: description,
          imageUrl: imageUrl,
          budget: budget,
        );

  factory WeddingModel.fromJson(Map<String, dynamic> json) {
    return WeddingModel(
      id: json['id'],
      name: json['name'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      budget: json['budget']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userId': userId,
      'date': date.toIso8601String(),
      'location': location,
      'description': description,
      'imageUrl': imageUrl,
      'budget': budget,
    };
  }
}
