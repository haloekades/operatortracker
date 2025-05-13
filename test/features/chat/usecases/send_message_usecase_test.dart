import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:operatortracker/features/chat/domain/entities/message_entity.dart';
import 'package:operatortracker/features/chat/domain/usecases/send_message_use_case.dart';

import '../../../mocks/mock_chat.mocks.dart';

void main() {
  late SendChatMessageUseCase usecase;
  late MockChatRepository mockRepo;

  setUp(() {
    mockRepo = MockChatRepository();
    usecase = SendChatMessageUseCase(mockRepo);
  });

  test('should send chat message', () async {
    final message = MessageEntity(
      id: '1',
      equipmentId: '222',
      message: 'Hello',
      senderNik: '1234',
      createdAt: DateTime.now(),
    );

    when(
      mockRepo.sendMessage('unit1', 'Hello', '1234'),
    ).thenAnswer((_) async => message);

    final result = await usecase('unit1', 'Hello', '1234');

    expect(result, equals(message));
    verify(mockRepo.sendMessage('unit1', 'Hello', '1234'));
  });
}
