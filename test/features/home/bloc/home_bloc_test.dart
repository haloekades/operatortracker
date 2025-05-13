import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:operatortracker/core/data/models/message_model.dart';
import 'package:operatortracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:operatortracker/features/home/presentation/bloc/home_event.dart';
import 'package:operatortracker/features/home/presentation/bloc/home_state.dart';
import 'package:operatortracker/features/login/domain/entities/login_entity.dart';

import '../../../mocks/mock_websocket_service.mocks.dart';

void main() {
  late MockWebSocketService mockWebSocketService;

  setUp(() {
    mockWebSocketService = MockWebSocketService();
  });

  group('HomeBloc', () {
    final login = LoginEntity(
      id: '123',
      nik: 'EK4NIK000',
      name: 'John Doe',
      roleName: 'Operator',
      email: 'ek4@gmail.com',
      phone: '081000000001',
      unitId: '123455',
      unitCode: '829201',
      isActive: true,
    );

    final msgModel = MessageModel(
      id: '1',
      equipmentId: '1',
      message: 'New incoming message',
      senderNik: 'senderNik',
      senderName: 'senderName',
      createdAt: DateTime.now(),
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoading, HomeLoaded] then HomeLoaded with message when WebSocket callback triggered',
      build: () {
        when(mockWebSocketService.connectMsgEquipment(any, any)).thenAnswer((
          invocation,
        ) async {
          final callback =
              invocation.positionalArguments[1] as void Function(MessageModel);
          callback(msgModel);
        });

        return HomeBloc(mockWebSocketService);
      },
      act: (bloc) => bloc.add(HomeStarted(login)),
      expect:
          () => [
            isA<HomeLoading>(),
            isA<HomeLoaded>().having(
              (s) => s.loginEntity.nik,
              'nik',
              'EK4NIK000',
            ),
            isA<HomeLoaded>().having(
              (s) => s.message,
              'message',
              msgModel,
            ),
          ],
    );
  });
}
