import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:operatortracker/core/constants/api_constants.dart';
import '../../domain/entities/device_entity.dart';

abstract class InstallationRemoteDataSource {
  Future<DeviceEntity?> checkDevice(String deviceId);
  Future<bool> registerDevice(String deviceId);
  Future<bool> loginAdmin(String nik, String password);
  Future<bool> activateDevice(String deviceId);
}

class InstallationRemoteDataSourceImpl implements InstallationRemoteDataSource {
  final http.Client client;
  static const String baseUrl = ApiConstants.baseUrl;

  InstallationRemoteDataSourceImpl({required this.client});

  @override
  Future<DeviceEntity?> checkDevice(String deviceId) async {
    final response = await client.get(Uri.parse('$baseUrl/equipments/devices/$deviceId'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['status'] == true) {
        final data = jsonData['data'];
        return DeviceEntity(id: data['id'], isActive: data['is_active']);
      }
    }
    return null;
  }

  @override
  Future<bool> registerDevice(String deviceId) async {
    final response = await client.post(
      Uri.parse('$baseUrl/equipments/devices'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': deviceId,
        'head_unit_sn': deviceId.length > 20 ? deviceId.substring(0, 20) : deviceId
      }),
    );
    return response.statusCode == 201;
  }

  @override
  Future<bool> loginAdmin(String nik, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nik': nik,
        'password': password,
      }),
    );
    return response.statusCode == 200;
  }

  @override
  Future<bool> activateDevice(String deviceId) async {
    final response = await client.post(
      Uri.parse('$baseUrl/equipments/devices/$deviceId/activation'),
      headers: {'Content-Type': 'application/json'},
    );

    print("ekadestest: response $response");

    return response.statusCode == 200;
  }
}