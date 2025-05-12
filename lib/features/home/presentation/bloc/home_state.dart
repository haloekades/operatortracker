import 'package:equatable/equatable.dart';
import 'package:operatortracker/core/data/models/message_model.dart';
import 'package:operatortracker/features/login/domain/entities/login_entity.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  final LoginEntity loginEntity;
  final MessageModel? message;

  const HomeLoaded({required this.loginEntity, this.message});

  @override
  List<Object?> get props => [loginEntity, message];
}