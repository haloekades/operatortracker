import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operatortracker/core/services/websocket_service.dart';
import 'package:operatortracker/features/home/presentation/bloc/home_event.dart';
import 'package:operatortracker/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(HomeLoading()) {
    on<HomeStarted>(_onStarted);
    on<HomeShowMessage>((event, emit) async {
      emit(HomeLoaded(loginEntity: event.loginEntity, message: event.message));
    });
  }

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    emit(HomeLoaded(loginEntity: event.loginEntity));

    await WebSocketService().connectMsgEquipment(
      event.loginEntity.unitId,
          (message) {
        add(HomeShowMessage(event.loginEntity, message));
      },
    );
  }
}