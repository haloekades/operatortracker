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
}