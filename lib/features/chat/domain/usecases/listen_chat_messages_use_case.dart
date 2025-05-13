import 'package:operatortracker/features/chat/domain/entities/message_entity.dart';
import 'package:operatortracker/features/chat/domain/repositories/chat_repository.dart';

class ListenChatMessagesUseCase {
  final ChatRepository repository;
  ListenChatMessagesUseCase(this.repository);

  void call(String unitId, void Function(MessageEntity) onMessage) =>
      repository.listenToMessages(unitId, onMessage);
}