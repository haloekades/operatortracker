import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String equipmentId;
  final String message;
  final String senderNik;
  final String? senderName;
  final DateTime createdAt;

  MessageEntity({
    required this.id,
    required this.equipmentId,
    required this.message,
    required this.senderNik,
    this.senderName,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, equipmentId, message, senderNik, senderName, createdAt];
}