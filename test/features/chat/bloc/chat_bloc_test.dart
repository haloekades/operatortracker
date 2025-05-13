import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:operatortracker/features/chat/domain/entities/message_entity.dart';
import 'package:operatortracker/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:operatortracker/features/chat/presentation/bloc/chat_event.dart';
import 'package:operatortracker/features/chat/presentation/bloc/chat_state.dart';

import '../../../mocks/mock_chat.mocks.dart';


void main() {
  late MockGetChatMessagesUseCase mockGetMessages;
  late MockSendChatMessageUseCase mockSendMessage;
  late MockListenChatMessagesUseCase mockListenMessages;

  setUp(() {
    mockGetMessages = MockGetChatMessagesUseCase();
    mockSendMessage = MockSendChatMessageUseCase();
    mockListenMessages = MockListenChatMessagesUseCase();
  });

  group('ChatBloc', () {
    final mockMessage = MessageEntity(
      id: '1',
      equipmentId: '2',
      message: "Hello",
      senderNik: "123",
      createdAt: DateTime.now(),
    );

    blocTest<ChatBloc, ChatState>(
      'emits [ChatLoading, ChatLoaded] when FetchChatMessages succeeds',
      build: () {
        when(mockGetMessages.call(any))
            .thenAnswer((_) async => [mockMessage]);

        // We mock listenMessages but don't trigger callback for this test
        when(mockListenMessages.call(any, any)).thenReturn(null);

        return ChatBloc(
          getMessages: mockGetMessages,
          sendMessage: mockSendMessage,
          listenMessages: mockListenMessages,
        );
      },
      act: (bloc) => bloc.add(FetchChatMessages("unit123")),
      expect: () => [
        isA<ChatLoading>(),
        isA<ChatLoaded>()
            .having((s) => s.messages.length, 'messages length', 1),
      ],
    );

    blocTest<ChatBloc, ChatState>(
      'emits ChatLoaded with new message when SendChatMessageEvent is added',
      build: () {
        when(mockGetMessages.call(any))
            .thenAnswer((_) async => [mockMessage]);

        when(mockSendMessage.call(any, any, any))
            .thenAnswer((_) async => mockMessage);

        when(mockListenMessages.call(any, any)).thenReturn(null);

        return ChatBloc(
          getMessages: mockGetMessages,
          sendMessage: mockSendMessage,
          listenMessages: mockListenMessages,
        );
      },
      seed: () => ChatLoaded([mockMessage]),
      act: (bloc) => bloc.add(SendChatMessageEvent("unit123", "New Message")),
      expect: () => [
        isA<ChatLoaded>().having((s) => s.messages.length, 'updated messages', 2),
      ],
    );
  });
}
