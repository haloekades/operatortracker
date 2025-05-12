import 'package:equatable/equatable.dart';
import 'package:operatortracker/features/chat/domain/entities/message_entity.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<MessageEntity> messages;

  ChatLoaded(this.messages);

  @override
  List<Object?> get props => [messages];
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
class ChatSending extends ChatState {}

