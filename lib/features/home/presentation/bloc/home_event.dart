import 'package:equatable/equatable.dart';
import 'package:operatortracker/core/data/models/message_model.dart';
import 'package:operatortracker/features/login/domain/entities/login_entity.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeStarted extends HomeEvent {
  final LoginEntity loginEntity;
  const HomeStarted(this.loginEntity);

  @override
  List<Object> get props => [loginEntity];
}

class HomeShowMessage extends HomeEvent {
  final MessageModel message;
  final LoginEntity loginEntity;
  const HomeShowMessage(this.loginEntity, this.message);

  @override
  List<Object> get props => [loginEntity, message];
}
