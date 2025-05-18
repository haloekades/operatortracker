import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operatortracker/core/session/storage_manager.dart';
import 'package:operatortracker/features/login/domain/entities/login_entity.dart';
import 'package:operatortracker/features/login/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final StorageManager storage;

  LoginBloc({required this.loginUseCase, required this.storage}) : super(LoginInitial()) {
    on<LoginStarted>((event, emit) async {
      final user = await storage.loadLoginEntity();
      final token = await storage.loadToken();

      if (user != null && token != null) {
        emit(LoginSuccess(user));
      }
    });

    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final result = await loginUseCase.execute(
          unitId: "5a60d043c1",
          nik: event.nik,
          shiftId: "048C-DS",
          loginType: 1,
        );
        emit(LoginSuccess(result));
      } catch (e) {
        emit(LoginError(e.toString()));
      }
    });
  }
}
