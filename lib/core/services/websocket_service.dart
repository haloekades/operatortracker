import 'dart:convert';
import 'package:centrifuge/centrifuge.dart';
import 'package:flutter/material.dart';
import 'package:operatortracker/core/data/models/message_model.dart';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  WebSocketService._internal();

  late Client _client;
  bool _isConnected = false;
  Subscription? _subscription;

  Future<void> connect(String deviceId, VoidCallback onActivated) async {
    final url = 'wss://dev-wss.apps-madhani.com/connection/websocket';
    final channel = 'ws/fms-dev/equipments/devices/$deviceId/activated';

    _client = createClient(url, config: ClientConfig());

    try {
      await _client.connect();
      debugPrint('[WebSocket] Connected');
      _isConnected = true;

      _subscription = _client.getSubscription(channel);

      _subscription!.publishStream.listen((PublishEvent event) {
        final decoded = jsonDecode(utf8.decode(event.data));
        debugPrint('[WebSocket] Received: $decoded');

        if (decoded is Map<String, dynamic> && decoded['is_active'] == true) {
          onActivated();
        }
      });

      await _subscription!.subscribe();
      debugPrint('[WebSocket] Subscribed to $channel');
    } catch (e) {
      debugPrint('[WebSocket] Error: $e');
    }
  }

  Future<void> connectMsgEquipment(String unitId,
      void Function(MessageModel messageModel) onMessageReceived) async {
    final url = 'wss://dev-wss.apps-madhani.com/connection/websocket';
    final channel = 'ws/fms-dev/monitoring/messages/equipments/$unitId';

    _client = createClient(url, config: ClientConfig());

    try {
      await _client.connect();
      debugPrint('[WebSocket] Connected');
      _isConnected = true;

      _subscription = _client.getSubscription(channel);

      _subscription!.publishStream.listen((PublishEvent event) {
        final decoded = jsonDecode(utf8.decode(event.data));
        debugPrint('[WebSocket] Received: $decoded');

        if (decoded is Map<String, dynamic>) {
          final data = jsonDecode(utf8.decode(event.data));
          final match = data['equipment_id'] == unitId;

          if (match) {
            onMessageReceived(MessageModel.fromJson(data));
          }
        }
      });

      await _subscription!.subscribe();
      debugPrint('[WebSocket] Subscribed to $channel');
    } catch (e) {
      debugPrint('[WebSocket] Error: $e');
    }
  }

  void disconnect() {
    if (_isConnected) {
      _client.disconnect();
      _isConnected = false;
      debugPrint('[WebSocket] Disconnected');
    }
  }
}
