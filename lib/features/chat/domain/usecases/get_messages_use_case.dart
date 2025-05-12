import 'package:operatortracker/features/chat/domain/entities/message_entity.dart';
import 'package:operatortracker/features/chat/domain/repositories/chat_repository.dart';

class GetChatMessages {
  final ChatRepository repository;
  GetChatMessages(this.repository);

  Future<List<MessageEntity>> call(String unitId) => repository.getMessages(unitId);
}