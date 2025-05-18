import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operatortracker/core/session/storage_manager.dart';
import 'package:operatortracker/features/chat/domain/usecases/get_messages_use_case.dart';
import 'package:operatortracker/features/chat/domain/usecases/listen_chat_messages_use_case.dart';
import 'package:operatortracker/features/chat/domain/usecases/send_message_use_case.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatMessagesUseCase getMessages;
  final SendChatMessageUseCase sendMessage;
  final ListenChatMessagesUseCase listenMessages;
  final StorageManager storageManager;

  ChatBloc({
    required this.getMessages,
    required this.sendMessage,
    required this.listenMessages,
    required this.storageManager
  }) : super(ChatInitial()) {
    on<FetchChatMessages>((event, emit) async {
      emit(ChatLoading());
      try {
        final messages = await getMessages(event.unitId);
        final loginEntity = await storageManager.loadLoginEntity();
        emit(ChatLoaded(messages, loginEntity?.nik ??''));
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

    on<NewChatMessageReceived>((event, emit) async {
      final currentState = state;
      final loginEntity = await storageManager.loadLoginEntity();

      if (currentState is ChatLoaded) {
        final updated = List.of(currentState.messages)..insert(0, event.message);
        emit(ChatLoaded(List.of(updated), loginEntity?.nik ?? ''));
      }
    });
  }
}
