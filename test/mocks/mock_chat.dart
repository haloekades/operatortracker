import 'package:mockito/annotations.dart';
import 'package:operatortracker/core/session/storage_manager.dart';
import 'package:operatortracker/features/chat/domain/repositories/chat_repository.dart';
import 'package:operatortracker/features/chat/domain/usecases/get_messages_use_case.dart';
import 'package:operatortracker/features/chat/domain/usecases/listen_chat_messages_use_case.dart';
import 'package:operatortracker/features/chat/domain/usecases/send_message_use_case.dart';

@GenerateMocks([
  ChatRepository,
  GetChatMessagesUseCase,
  SendChatMessageUseCase,
  ListenChatMessagesUseCase,
  StorageManager
])
void main() {}
