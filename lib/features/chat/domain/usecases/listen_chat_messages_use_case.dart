import 'package:operatortracker/features/chat/domain/entities/message_entity.dart';
import 'package:operatortracker/features/chat/domain/repositories/chat_repository.dart';

class ListenChatMessages {
  final ChatRepository repository;
  ListenChatMessages(this.repository);

  void call(String unitId, void Function(MessageEntity) onMessage) =>
      repository.listenToMessages(unitId, onMessage);
}