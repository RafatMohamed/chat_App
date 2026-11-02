import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat_proj/features/auth/data/models/users_model.dart';

class UserRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late var collection = _firestore
      .collection('users')
      .withConverter(
        fromFirestore: (snapshot, options) {
          return UserModel.fromJson(snapshot.data()!);
        },
        toFirestore: (user, options) => user.toJson(),
      );

  Future<UserModel> createUser(UserModel user) async {
    await collection.doc(user.uid).set(user);
    return user;
  }

  // Future<UserModel> getUser(String uid) async {
  //   var snapshot = await collection.doc(uid).get();
  //   final user = snapshot.data();
  //
  //   if (!snapshot.exists || user == null) {
  //     throw Exception('user-profile-not-found');
  //   }
  //
  //   return user;
  // }

  Stream<UserModel> getUserStream(String uid) {
    return collection.doc(uid).snapshots().map((event) {
      if (!event.exists || event.data() == null) {
        throw Exception('user-profile-not-found');
      }
      return event.data()!;
    });
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await collection.doc(user.uid).update({
        'username': user.username,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'bio': user.bio,
      });
    } catch (e) {
      if (e is FirebaseException) {
        throw Exception(e.code);
      }
      rethrow;
    }
  }

  Future<void> deleteUser(String uid) async {
    await collection.doc(uid).delete();
  }

  Future<void> updateLastSeen(String uid) async {
    await collection.doc(uid).update({'lastSeen': Timestamp.now()});
  }

  Future<void> updateOnlineStatus(String uid, bool isOnline) async {
    await collection.doc(uid).update({'isOnline': isOnline});
  }

  Future<List<UserModel>> getUsers() async {
    var snapshot = await collection.orderBy("createdAt").get();
    final users = snapshot.docs.map((doc) => doc.data()).toList();
    return users;
  }

  Future<List<UserModel>> getUsersFiltered(String query) async {
    final normalizedQuery = query.trim();

    if (normalizedQuery.isEmpty) return [];

    var usersFiltedBy = await Future.wait([
      collection.orderBy("username").startAt([normalizedQuery]).endAt([
        '$normalizedQuery\uf8ff',
      ]).get(),

      collection.orderBy("phoneNumber").startAt([normalizedQuery]).endAt([
        '$normalizedQuery\uf8ff',
      ]).get(),
    ]);

    final users = <String, UserModel>{};

    for (final snapshot in usersFiltedBy) {
      for (final doc in snapshot.docs) {
        users[doc.id] = doc.data();
      }
    }

    final list = users.values.toList()
      ..sort((a, b) => a.username.compareTo(b.username));

    return list;
  }
}
