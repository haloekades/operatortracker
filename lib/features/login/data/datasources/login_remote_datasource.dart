import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:operatortracker/core/constants/api_constants.dart';
import 'package:operatortracker/core/session/SessionManager.dart';
import 'package:operatortracker/injection.dart';
import '../models/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginModel> loginTabletUnit({
    required String unitId,
    required String nik,
    required String shiftId,
    required int loginType,
  });
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginModel> loginTabletUnit({
    required String unitId,
    required String nik,
    required String shiftId,
    required int loginType,
  }) async {
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/login-tablet-unit'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "unit_id": unitId,
        "nik": nik,
        "shift_id": shiftId,
        "login_type": loginType,
      }),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body['status'] == true) {
        final loginModel = LoginModel.fromJson(body['data']);

        // save nik && session
        sl<SessionManager>().nik = loginModel.nik;
        sl<SessionManager>().token = response.headers["set-cookie"];

        return loginModel;
      } else {
        throw Exception(body['message']);
      }
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }
}
