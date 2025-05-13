import 'package:operatortracker/features/chat/domain/entities/message_entity.dart';
import 'package:operatortracker/features/chat/domain/repositories/chat_repository.dart';

class SendChatMessageUseCase {
  final ChatRepository repository;
  SendChatMessageUseCase(this.repository);

  Future<MessageEntity> call(String unitId, String message, String categoryId) =>
      repository.sendMessage(unitId, message, categoryId);
}