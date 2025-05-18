class LoginEntity {
  final String id;
  final String nik;
  final String name;
  final String roleName;
  final String email;
  final String phone;
  final String unitId;
  final String unitCode;
  final bool isActive;

  LoginEntity({
    required this.id,
    required this.nik,
    required this.name,
    required this.roleName,
    required this.email,
    required this.phone,
    required this.unitId,
    required this.unitCode,
    required this.isActive,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'nik': nik,
    'name': name,
    'roleName': roleName,
    'email': email,
    'phone': phone,
    'unitId': unitId,
    'unitCode': unitCode,
    'isActive': isActive,
  };

  factory LoginEntity.fromJson(Map<String, dynamic> json) => LoginEntity(
    id: json['id'],
    nik: json['nik'],
    name: json['name'],
    roleName: json['roleName'],
    email: json['email'],
    phone: json['phone'],
    unitId: json['unitId'],
    unitCode: json['unitCode'],
    isActive: json['isActive'],
  );
}