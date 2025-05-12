import 'package:operatortracker/features/chat/domain/entities/message_entity.dart';

abstract class ChatEvent {}

class FetchChatMessages extends ChatEvent {
  final String unitId;
  FetchChatMessages(this.unitId);
}

class SendChatMessageEvent extends ChatEvent {
  final String unitId;
  final String message;
  SendChatMessageEvent(this.unitId, this.message);
}

class NewChatMessageReceived extends ChatEvent {
  final MessageEntity message;

  NewChatMessageReceived(this.message);
}