import '../../domain/entities/login_entity.dart';

class LoginModel {
  final String id;
  final String nik;
  final String name;
  final String email;
  final String roleName;
  final String phone;
  final String unitId;
  final String unitCode;
  final bool isActive;

  LoginModel({
    required this.id,
    required this.nik,
    required this.name,
    required this.email,
    required this.roleName,
    required this.phone,
    required this.unitId,
    required this.unitCode,
    required this.isActive,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['id'],
      nik: json['nik'],
      name: json['name'],
      email: json['email'],
      roleName: json['role_name'],
      phone: json['phone'],
      unitId: json['unit_id'],
      unitCode: json['unit_code'],
      isActive: json['is_active'],
    );
  }

  LoginEntity toEntity() {
    return LoginEntity(
      id: id,
      name: name,
      nik: nik,
      email: email,
      roleName: roleName,
      phone: phone,
      unitId: unitId,
      unitCode: unitCode,
      isActive: isActive,
    );
  }
}
