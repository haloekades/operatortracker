import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operatortracker/features/login/domain/entities/login_entity.dart';
import 'package:operatortracker/features/login/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
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
