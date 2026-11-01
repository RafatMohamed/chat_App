import 'package:scholar_chat_proj/features/auth/data/models/users_model.dart';
import 'package:scholar_chat_proj/features/auth/domain/entities/user_entities.dart';

class AppMappers {
  static UserEntity toUserEntity(UserModel user) {
    return UserEntity(
      username: user.username,
      email: user.email,
      phoneNumber: user.phoneNumber,
      bio: user.bio,
      isOnline: user.isOnline,
      lastSeen: user.lastSeen,
    );
  }
}
