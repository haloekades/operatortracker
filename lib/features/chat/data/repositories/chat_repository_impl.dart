import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:operatortracker/core/constants/api_constants.dart';
import 'package:operatortracker/core/data/models/message_model.dart';
import 'package:operatortracker/core/services/websocket_service.dart';
import 'package:operatortracker/core/session/SessionManager.dart';
import 'package:operatortracker/features/chat/domain/entities/message_entity.dart';
import 'package:operatortracker/features/chat/domain/repositories/chat_repository.dart';
import 'package:operatortracker/injection.dart';

class ChatRepositoryImpl implements ChatRepository {
  final http.Client client;
  final WebSocketService webSocketService;

  ChatRepositoryImpl(this.client, this.webSocketService);

  @override
  Future<List<MessageEntity>> getMessages(String unitId) async {
    final response = await client.get(
      headers: {
        'Content-Type': 'application/json',
        'Cookie': sl<SessionManager>().token ?? '',
      },
      Uri.parse(
        '${ApiConstants.baseUrl}/monitoring/messages?page=1&limit=10&sort=created_at,desc&equipment_id=$unitId',
      ),
    );

    final jsonData = jsonDecode(response.body);
    final List<dynamic> data = jsonData['data'];
    return data.map((e) => MessageModel.fromJson(e)).toList();
  }

  @override
  Future<MessageEntity> sendMessage(
    String unitId,
    String message,
    String categoryId,
  ) async {
    final body = {
      "equipment_id": unitId,
      "message": message,
      "device_type": "Mobile",
      "category_id": categoryId,
    };
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/monitoring/messages'),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': sl<SessionManager>().token ?? '',
      },
      body: jsonEncode(body),
    );

    final jsonData = jsonDecode(response.body);
    return MessageModel.fromJson(jsonData['data']);
  }

  @override
  void listenToMessages(String unitId, void Function(MessageEntity) onMessage) {
    webSocketService.connectMsgEquipment(unitId, (messageModel) {
      onMessage(messageModel);
    });
  }
}
