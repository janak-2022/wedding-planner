import '../../domain/entities/vendor.dart';

class VendorCategoryModel extends VendorCategory {
  VendorCategoryModel({
    required String id,
    required String name,
    String? description,
    String? iconUrl,
  }) : super(
          id: id,
          name: name,
          description: description,
          iconUrl: iconUrl,
        );

  factory VendorCategoryModel.fromJson(Map<String, dynamic> json) {
    return VendorCategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      iconUrl: json['iconUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconUrl': iconUrl,
    };
  }
}

class VendorReviewModel extends VendorReview {
  VendorReviewModel({
    required String id,
    required String vendorId,
    required String userId,
    required int rating,
    required String comment,
    required DateTime createdAt,
  }) : super(
          id: id,
          vendorId: vendorId,
          userId: userId,
          rating: rating,
          comment: comment,
          createdAt: createdAt,
        );

  factory VendorReviewModel.fromJson(Map<String, dynamic> json) {
    return VendorReviewModel(
      id: json['id'],
      vendorId: json['vendorId'],
      userId: json['userId'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendorId': vendorId,
      'userId': userId,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class VendorModel extends Vendor {
  VendorModel({
    required String id,
    required String weddingId,
    required String name,
    required String categoryId,
    required VendorStatus status,
    double? price,
    String? contactInfo,
    String? website,
    List<String>? imageUrls,
    List<VendorReview>? reviews,
  }) : super(
          id: id,
          weddingId: weddingId,
          name: name,
          categoryId: categoryId,
          status: status,
          price: price,
          contactInfo: contactInfo,
          website: website,
          imageUrls: imageUrls,
          reviews: reviews,
        );

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'],
      weddingId: json['weddingId'],
      name: json['name'],
      categoryId: json['categoryId'],
      status: VendorStatus.values.byName(json['status']),
      price: json['price']?.toDouble(),
      contactInfo: json['contactInfo'],
      website: json['website'],
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      reviews: (json['reviews'] as List?)
          ?.map((review) => VendorReviewModel.fromJson(review))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weddingId': weddingId,
      'name': name,
      'categoryId': categoryId,
      'status': status.name,
      'price': price,
      'contactInfo': contactInfo,
      'website': website,
      'imageUrls': imageUrls,
      'reviews': reviews?.map((review) => (review as VendorReviewModel).toJson()).toList(),
    };
  }
}
