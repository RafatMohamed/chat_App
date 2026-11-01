class UserEntity {
  final String username;
  final String email;
  final String phoneNumber;
  final String? bio;
  final bool? isOnline;
  final DateTime? lastSeen;

  const UserEntity({
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.bio,
    this.isOnline,
    this.lastSeen,
  });
}
