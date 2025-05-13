import '../../domain/entities/guest.dart';

class GuestModel extends Guest {
  GuestModel({
    required String id,
    required String weddingId,
    required String name,
    required GuestStatus status,
    String? email,
    String? phone,
    int? plusOnes,
    String? group,
    String? dietaryRestrictions,
    String? notes,
    bool isInvitationSent = false,
  }) : super(
          id: id,
          weddingId: weddingId,
          name: name,
          status: status,
          email: email,
          phone: phone,
          plusOnes: plusOnes,
          group: group,
          dietaryRestrictions: dietaryRestrictions,
          notes: notes,
          isInvitationSent: isInvitationSent,
        );

  factory GuestModel.fromJson(Map<String, dynamic> json) {
    return GuestModel(
      id: json['id'],
      weddingId: json['weddingId'],
      name: json['name'],
      status: GuestStatus.values.byName(json['status']),
      email: json['email'],
      phone: json['phone'],
      plusOnes: json['plusOnes'],
      group: json['group'],
      dietaryRestrictions: json['dietaryRestrictions'],
      notes: json['notes'],
      isInvitationSent: json['isInvitationSent'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weddingId': weddingId,
      'name': name,
      'status': status.name,
      'email': email,
      'phone': phone,
      'plusOnes': plusOnes,
      'group': group,
      'dietaryRestrictions': dietaryRestrictions,
      'notes': notes,
      'isInvitationSent': isInvitationSent,
    };
  }
}
