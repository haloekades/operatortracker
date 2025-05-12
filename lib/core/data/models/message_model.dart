import 'package:operatortracker/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity{
  MessageModel({
    required super.id,
    required super.equipmentId,
    required super.message,
    required super.senderNik,
    required super.senderName,
    required super.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      equipmentId: json['equipment_id'],
      senderNik: json['sender_nik'],
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
      senderName: json['sender_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'equipment_id': equipmentId,
      'sender_nik': senderNik,
      'message': message,
      'created_at': createdAt.toIso8601String(),
      'sender_name': senderName,
    };
  }
}
