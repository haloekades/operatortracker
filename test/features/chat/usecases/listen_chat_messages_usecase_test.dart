import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:operatortracker/features/chat/domain/entities/message_entity.dart';
import 'package:operatortracker/features/chat/domain/usecases/listen_chat_messages_use_case.dart';
import '../../../mocks/mock_chat.mocks.dart';

void main() {
  late ListenChatMessagesUseCase usecase;
  late MockChatRepository mockChatRepository;

  setUp(() {
    mockChatRepository = MockChatRepository();
    usecase = ListenChatMessagesUseCase(mockChatRepository);
  });

  test('should listen to messages using repository', () {
    final unitId = 'unit-1';
    final fakeMessage = MessageEntity(
      id: '1',
      equipmentId: '2',
      message: 'New message',
      senderNik: '1234',
      createdAt: DateTime.now(),
    );

    void Function(MessageEntity)? capturedCallback;

    when(mockChatRepository.listenToMessages(any, any)).thenAnswer((
      invocation,
    ) {
      final callback =
          invocation.positionalArguments[1] as void Function(MessageEntity);
      capturedCallback = callback;
    });

    MessageEntity? receivedMessage;

    usecase(unitId, (message) {
      receivedMessage = message;
    });

    capturedCallback?.call(fakeMessage);

    expect(receivedMessage, isNotNull);
    expect(receivedMessage!.message, 'New message');
    verify(mockChatRepository.listenToMessages(unitId, any)).called(1);
  });
}
