import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;
  final String phoneNumber;
  final String? bio;
  final bool? isOnline;
  final DateTime? lastSeen;
  final DateTime? createdAt;

  const UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.bio,
    this.isOnline,
    this.lastSeen,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      bio: json['bio'],
      isOnline: json['isOnline'],
      lastSeen: (json['lastSeen'] as Timestamp?)?.toDate(),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'isOnline': isOnline,
      'lastSeen': lastSeen != null ? Timestamp.fromDate(lastSeen!) : null,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
    };
  }
}
