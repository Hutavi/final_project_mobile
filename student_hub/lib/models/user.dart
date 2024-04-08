import 'package:student_hub/models/company_user.dart';
import 'package:student_hub/models/student_user.dart';

class User {
  final int? id;
  final String? email;
  final String? password;
  final String? fullname;
  final List<dynamic>? role;
  StudentUser? studentUser;
  CompanyUser? companyUser;

  User({
    this.id,
    this.email,
    this.password,
    this.fullname,
    this.role,
    this.studentUser,
    this.companyUser,
  });

  Map<String, dynamic> toMapUser() => {
    'id': id,
    'email': email,
    'password': password,
    'fullname': fullname,
    'role': role?.last,
    'student': studentUser?.toMapStudentUser(),
    'company': companyUser?.toMapCompanyUser(),
  };

  factory User.fromMapUser(Map<String, dynamic> map) => User(
    id: map['id'],
    email: map['email'],
    password: map['password'],
    fullname: map['fullname'],
    role: map['roles'],
    studentUser: map['student'] == null
        ? null
        : StudentUser.fromMapStudentUser(map['student']),
    companyUser: map['company'] == null
        ? null
        : CompanyUser.fromMapCompanyUser(map['company']));

  String printAll(){
    return 'User(id: $id, email: $email, password: $password, fullname: $fullname, role: $role, studentUser: $studentUser, companyUser: $companyUser)';
  }
}

//user mẫu
List<User> userList = [
];