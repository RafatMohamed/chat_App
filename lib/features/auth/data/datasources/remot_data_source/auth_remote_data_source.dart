import 'package:firebase_auth/firebase_auth.dart';
import 'package:scholar_chat_proj/features/auth/data/models/users_model.dart';

import '../../../../MainHomeAppView/data/datasources/remot_data_source/user_remote_data_source.dart';

class AuthRemoteDataSource {
  final UserRemoteDataSource _userRemoteDataSource;

  AuthRemoteDataSource({required this._userRemoteDataSource});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        throw FirebaseAuthException(code: 'user-not-found');
      }
      UserModel user = await _userRemoteDataSource.getUser(
        userCredential.user!.uid,
      );
      await _userRemoteDataSource.updateLastSeen(userCredential.user!.uid);
      await _userRemoteDataSource.updateOnlineStatus(user.uid, true);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> register({
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user == null) {
        throw FirebaseAuthException(code: 'user-not-found');
      }
      UserModel user = UserModel(
        uid: userCredential.user!.uid,
        username: userName,
        email: email,
        createdAt: DateTime.now(),
        isOnline: true,
        lastSeen: DateTime.now(),
        phoneNumber: phoneNumber,
      );
      await _userRemoteDataSource.createUser(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      if (_auth.currentUser == null) return;
      await _userRemoteDataSource.updateOnlineStatus(
        _auth.currentUser!.uid,
        false,
      );
      await _userRemoteDataSource.updateLastSeen(_auth.currentUser!.uid);
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  String? getCurrentUserID() {
    return _auth.currentUser?.uid;
  }
}
