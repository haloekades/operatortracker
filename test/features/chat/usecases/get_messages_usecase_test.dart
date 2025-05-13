import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:operatortracker/features/chat/domain/entities/message_entity.dart';
import 'package:operatortracker/features/chat/domain/usecases/get_messages_use_case.dart';
import '../../../mocks/mock_chat.mocks.dart';

void main() {
  late GetChatMessagesUseCase usecase;
  late MockChatRepository mockRepo;

  setUp(() {
    mockRepo = MockChatRepository();
    usecase = GetChatMessagesUseCase(mockRepo);
  });

  test('should return list of messages from repository', () async {
    final unitId = 'unit-1';
    final messages = [
      MessageEntity(
        id: '1',
        equipmentId: '2',
        message: 'Hello',
        senderNik: '1234',
        createdAt: DateTime.now(),
      ),
    ];

    when(mockRepo.getMessages(unitId)).thenAnswer((_) async => messages);

    final result = await usecase(unitId);

    expect(result, equals(messages));
    verify(mockRepo.getMessages(unitId)).called(1);
  });
}
