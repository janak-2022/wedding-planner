class Wedding {
  final String id;
  final String name;
  final String userId;
  final DateTime date;
  final String location;
  final String? description;
  final String? imageUrl;
  final double? budget;

  Wedding({
    required this.id,
    required this.name,
    required this.userId,
    required this.date,
    required this.location,
    this.description,
    this.imageUrl,
    this.budget,
  });
}
