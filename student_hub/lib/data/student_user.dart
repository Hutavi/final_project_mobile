import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class StudentUser extends Equatable {
  final String id;
  final String username;
  final String phone;
  final String email;
  final String avatarUrl;
  final String status;

  const StudentUser({
    required this.id,
    required this.username,
    required this.phone,
    required this.email,
    required this.avatarUrl,
    required this.status,
  });

  StudentUser copyWith({
    String? id,
    String? username,
    String? phone,
    String? email,
    String? avatarUrl,
    String? status,
  }) {
    return StudentUser(
      id: id ?? this.id,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      status: status ?? this.status,
    );
  }

  factory StudentUser.fromJson(Map<String, dynamic> json) {
    return StudentUser(
      id: json['id'] ?? const Uuid().v4(),
      username: json['username'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      avatarUrl:
          json['avatar_url'] ?? 'https://source.unsplash.com/random/?profile',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'phone': phone,
      'email': email,
      'avatarUrl': avatarUrl,
      'status': status,
    };
  }

  @override
  List<Object?> get props => [id, username, phone, email, avatarUrl, status];
}

List<StudentUser> studentUserList = [
  StudentUser(
    id: "0",
    username: "User 0",
    phone: "+1234567890",
    email: "user0@example.com",
    avatarUrl: "https://source.unsplash.com/random/?profile",
    status: "Active",
  ),
  StudentUser(
    id: "1",
    username: "User 1",
    phone: "+1234567891",
    email: "user0@example.com",
    avatarUrl: "https://source.unsplash.com/random/?profile",
    status: "Active",
  ),
];

