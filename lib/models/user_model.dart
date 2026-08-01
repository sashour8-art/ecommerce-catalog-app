class UserModel {
  final String uid;
  final String name;
  final String phone;
  final String email;

  UserModel({
    required this.uid,
    required this.name,
    required this.phone,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String uid) {
    return UserModel(
      uid: uid,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
    );
  }

  // Note: password is intentionally NOT stored in Firestore.
  // Firebase Auth already manages the password securely.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
    };
  }
}