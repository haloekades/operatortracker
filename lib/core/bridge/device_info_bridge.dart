import 'package:flutter/services.dart';

class DeviceInfoBridge {
  static const _channel = MethodChannel('com.ekades.operatortracker');

  static Future<String?> getDeviceId() async {
    try {
      final String? deviceId = await _channel.invokeMethod('getDeviceId');
      return deviceId;
    } on PlatformException catch (e) {
      print('Failed to get device ID: ${e.message}');
      return null;
    }
  }
}
