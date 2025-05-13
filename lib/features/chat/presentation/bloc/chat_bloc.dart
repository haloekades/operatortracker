import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operatortracker/features/chat/domain/usecases/get_messages_use_case.dart';
import 'package:operatortracker/features/chat/domain/usecases/listen_chat_messages_use_case.dart';
import 'package:operatortracker/features/chat/domain/usecases/send_message_use_case.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatMessagesUseCase getMessages;
  final SendChatMessageUseCase sendMessage;
  final ListenChatMessagesUseCase listenMessages;

  ChatBloc({
    required this.getMessages,
    required this.sendMessage,
    required this.listenMessages,
  }) : super(ChatInitial()) {
    on<FetchChatMessages>((event, emit) async {
      emit(ChatLoading());
      try {
        final messages = await getMessages(event.unitId);
        emit(ChatLoaded(messages));
        listenMessages(event.unitId, (newMsg) {
          add(NewChatMessageReceived(newMsg));
        });
      } catch (e) {
        emit(ChatError('Failed to load messages'));
      }
    });

    on<SendChatMessageEvent>((event, emit) async {
      final newMsg = await sendMessage(event.unitId, event.message, '1');
      add(NewChatMessageReceived(newMsg));
    });

    on<NewChatMessageReceived>((event, emit) {
      final currentState = state;
      if (currentState is ChatLoaded) {
        final updated = List.of(currentState.messages)..insert(0, event.message);
        emit(ChatLoaded(List.of(updated)));
      }
    });
  }
}
