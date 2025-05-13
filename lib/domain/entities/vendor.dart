enum VendorStatus { pending, confirmed, declined, cancelled }

class VendorCategory {
  final String id;
  final String name;
  final String? description;
  final String? iconUrl;

  VendorCategory({
    required this.id,
    required this.name,
    this.description,
    this.iconUrl,
  });
}

class VendorReview {
  final String id;
  final String vendorId;
  final String userId;
  final int rating;
  final String comment;
  final DateTime createdAt;

  VendorReview({
    required this.id,
    required this.vendorId,
    required this.userId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });
}

class Vendor {
  final String id;
  final String weddingId;
  final String name;
  final String categoryId;
  final VendorStatus status;
  final double? price;
  final String? contactInfo;
  final String? website;
  final List<String>? imageUrls;
  final List<VendorReview>? reviews;

  Vendor({
    required this.id,
    required this.weddingId,
    required this.name,
    required this.categoryId,
    required this.status,
    this.price,
    this.contactInfo,
    this.website,
    this.imageUrls,
    this.reviews,
  });
}
