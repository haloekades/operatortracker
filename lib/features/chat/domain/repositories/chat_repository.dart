import 'package:operatortracker/features/chat/domain/entities/message_entity.dart';

abstract class ChatRepository {
  Future<List<MessageEntity>> getMessages(String unitId);
  Future<MessageEntity> sendMessage(String unitId, String message, String categoryId);
  void listenToMessages(String unitId, void Function(MessageEntity message) onMessage);
}
