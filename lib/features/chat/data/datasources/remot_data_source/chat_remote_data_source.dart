import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat_proj/core/constants/enum/enum_app.dart';
import 'package:scholar_chat_proj/core/generate_chat_id.dart';
import 'package:scholar_chat_proj/features/chat/data/model/message_model.dart';
import 'package:uuid/uuid.dart';

import '../../model/chat_model.dart';

class ChatRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late CollectionReference<ChatModel> collectionChat = _firestore
      .collection('chats')
      .withConverter<ChatModel>(
        fromFirestore: (snapshot, options) {
          return ChatModel.fromJson(snapshot.data()!);
        },
        toFirestore: (chat, options) => chat.toJson(),
      );

  Future<void> sendMessage({
    required String sendId,
    required String receiveId,
    required String message,
  }) async {
    if (sendId == receiveId) return;

    final idChat = generateChatId(sendId, receiveId);
    final messageId = const Uuid().v4();

    final chatSnapshot = await collectionChat.doc(idChat).get();

    ChatModel chatModel = ChatModel(
      chatId: idChat,
      participants: [sendId, receiveId],
      type: ChatType.private.name,
      lastMessage: message,
      lastMessageAt: DateTime.now(),
      createdAt: chatSnapshot.exists
          ? chatSnapshot.data()!.createdAt
          : DateTime.now(),
    );

    MessageModel messageModel = MessageModel(
      messageId: messageId,
      senderId: sendId,
      text: message,
      createdAt: DateTime.now(),
    );

    final batch = _firestore.batch();

    final chatRef = collectionChat.doc(idChat);
    batch.set(chatRef, chatModel);
    final messagesCollection = chatRef
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

  Stream<List<ChatModel>> getRecentChatsStream(String uid) {
    return collectionChat
        .where('participants', arrayContains: uid)
        .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => doc.data()).toList();
        });
  }

  Stream<List<MessageModel>> getMessagesStream(String chatId) {
    final messagesCollection = collectionChat
        .doc(chatId)
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
