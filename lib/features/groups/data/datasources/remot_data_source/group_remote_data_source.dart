import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat_proj/features/chat/data/model/message_model.dart';
import 'package:uuid/uuid.dart';

import '../../model/group_model.dart';

class GroupRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late CollectionReference<GroupModel> collectionGroup = _firestore
      .collection('groups')
      .withConverter<GroupModel>(
        fromFirestore: (snapshot, options) {
          return GroupModel.fromJson(snapshot.data()!);
        },
        toFirestore: (group, options) => group.toJson(),
      );

  Future<GroupModel> createGroup({
    required String name,
    required String createdBy,
    required List<String> members,
  }) async {
    final groupId = const Uuid().v4();

    final allMembers = {createdBy, ...members}.toList();

    final groupModel = GroupModel(
      groupId: groupId,
      name: name,
      members: allMembers,
      createdBy: createdBy,
      lastMessage: '',
      lastMessageAt: DateTime.now(),
      createdAt: DateTime.now(),
    );

    await collectionGroup.doc(groupId).set(groupModel);

    return groupModel;
  }

  Stream<List<GroupModel>> getGroupsStream(String uid) {
    return collectionGroup
        .where('members', arrayContains: uid)
        .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => doc.data()).toList();
        });
  }

  Future<void> sendGroupMessage({
    required String groupId,
    required String sendId,
    required String message,
  }) async {
    final messageId = const Uuid().v4();

    final messageModel = MessageModel(
      messageId: messageId,
      senderId: sendId,
      text: message,
      createdAt: DateTime.now(),
    );

    final batch = _firestore.batch();

    final groupRef = collectionGroup.doc(groupId);
    batch.update(groupRef, {
      'lastMessage': message,
      'lastMessageAt': Timestamp.now(),
    });

    final messagesCollection = groupRef
        .collection('messages')
        .withConverter<MessageModel>(
          fromFirestore: (snapshot, options) {
            return MessageModel.fromJson(snapshot.data()!);
          },
          toFirestore: (message, options) => message.toJson(),
        );

    batch.set(
      messagesCollection.doc(messageId),
      messageModel,
      SetOptions(merge: true),
    );

    await batch.commit();
  }

  Stream<List<MessageModel>> getGroupMessagesStream(String groupId) {
    final messagesCollection = collectionGroup
        .doc(groupId)
        .collection('messages')
        .withConverter<MessageModel>(
          fromFirestore: (snapshot, options) {
            return MessageModel.fromJson(snapshot.data()!);
          },
          toFirestore: (message, options) => message.toJson(),
        );

    return messagesCollection
        .orderBy('createdAt')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
