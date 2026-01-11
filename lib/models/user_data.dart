

class UserData {
  final String id;
  final String email;
  final String username;
  final DateTime createdAt;

  UserData({
    required this.id,
    required this.email,
    required this.username,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'createdAt': createdAt,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map, String documentId) {
    return UserData(
      id: documentId,
      email: map['email'],
      username: map['username'],
      createdAt: map['createdAt'],
    );
  }
}
