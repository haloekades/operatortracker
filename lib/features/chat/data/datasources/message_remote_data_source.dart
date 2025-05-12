import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:operatortracker/core/data/models/message_model.dart';

class MessageRemoteDataSource {
  final String baseUrl;

  MessageRemoteDataSource({required this.baseUrl});

  Future<List<MessageModel>> getMessages(String unitId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/monitoring/messages?page=1&limit=10&sort=created_at,desc&equipment_id=$unitId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<MessageModel>.from(
        data['data'].map((item) => MessageModel.fromJson(item)),
      );
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<void> sendMessage(String unitId, String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/monitoring/messages'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'equipment_id': unitId,
        'message': message,
        'device_type': 'Mobile',
        'category_id': '1',
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to send message');
    }
  }
}
