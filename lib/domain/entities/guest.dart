enum GuestStatus { pending, confirmed, declined, tentative }

class Guest {
  final String id;
  final String weddingId;
  final String name;
  final GuestStatus status;
  final String? email;
  final String? phone;
  final int? plusOnes;
  final String? group;
  final String? dietaryRestrictions;
  final String? notes;
  final bool isInvitationSent;

  Guest({
    required this.id,
    required this.weddingId,
    required this.name,
    required this.status,
    this.email,
    this.phone,
    this.plusOnes,
    this.group,
    this.dietaryRestrictions,
    this.notes,
    this.isInvitationSent = false,
  });
}
