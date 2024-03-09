class CompanyUser {
  final String userId;//id của người dùng trong hệ thống
  final String fullName;
  final String email;
  final String password;
  final String typeUser = 'company';
  final String companyId;
  final String companyName;
  final String companyWebsite;
  final String companyDescription;
  final String employeesID;//id của người dùng trong công ty
  bool isLogin = false;

  CompanyUser({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.password,
    required this.companyId,
    required this.companyName,
    required this.companyWebsite,
    required this.companyDescription,
    required this.employeesID,
    required this.isLogin,
  });

  void login() {
    isLogin = true;
  }

  void logout() {
    isLogin = false;
  }

  bool isUserLogin() {
    return isLogin;
  }

  String getUserId() {
    return userId;
  }

  String getFullName() {
    return fullName;
  }

  String getEmail() {
    return email;
  }

  String getPassword() {
    return password;
  }

  String getTypeUser() {
    return typeUser;
  }
  
  String getCompanyId() {
    return companyId;
  }

  String getCompanyName() {
    return companyName;
  }

  String getCompanyWebsite() {
    return companyWebsite;
  }

  String getCompanyDescription() {
    return companyDescription;
  }

  String getEmployeesID() {
    return employeesID;
  }

  void setUserId(String userId) {
    userId = userId;
  }

  void setFullName(String fullName) {
    fullName = fullName;
  }

  void setEmail(String email) {
    email = email;
  }

  void setPassword(String password) {
    password = password;
  }
  
  void setCompanyId(String companyId) {
    companyId = companyId;
  }

  void setCompanyName(String companyName) {
    companyName = companyName;
  }

  void setCompanyWebsite(String companyWebsite) {
    companyWebsite = companyWebsite;
  }

  void setCompanyDescription(String companyDescription) {
    companyDescription = companyDescription;
  }

  void setNumberOfEmployees(String numberOfEmployees) {
    numberOfEmployees = numberOfEmployees;
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'password': password,
      'typeUser': typeUser,
      'companyId': companyId,//id của công ty trong hệ thống
      'companyName': companyName,
      'companyWebsite': companyWebsite,
      'companyDescription': companyDescription,
      'employeesID': employeesID,
      'isLogin': isLogin,
    };
  }

  // @override
  // String toString() {
  //   return 'CompanyUser{userID: $userId , fullName: $fullName, email: $email, password: $password, typeUser: $typeUser, companyID: $companyId, companyName: $companyName, companyWebsite: $companyWebsite, companyDescription: $companyDescription, numberOfEmployees: $numberOfEmployees, isLogin: $isLogin}';
  // }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is CompanyUSer &&
  //       other.fullName == fullName &&
  //       other.email == email &&
  //       other.password == password &&
  //       other.typeUser == typeUser &&
  //       other.companyName == companyName &&
  //       other.companyWebsite == companyWebsite &&
  //       other.companyDescription == companyDescription &&
  //       other.employeesID == employeesID &&
  //       other.isLogin == isLogin;
  // }

  // @override
  // int get hashCode {
  //   return fullName.hashCode ^
  //       email.hashCode ^
  //       password.hashCode ^
  //       typeUser.hashCode ^
  //       companyName.hashCode ^
  //       companyWebsite.hashCode ^
  //       companyDescription.hashCode ^
  //       employeesID.hashCode ^
  //       isLogin.hashCode;
  // }

  factory CompanyUser.fromMap(Map<String, dynamic> map) {
    return CompanyUser(
      userId: map['userId'],
      fullName: map['fullName'],
      email: map['email'],
      password: map['password'],
      companyId: map['companyId'],
      companyName: map['companyName'],
      companyWebsite: map['companyWebsite'],
      companyDescription: map['companyDescription'],
      employeesID: map['employeesID'],
      isLogin: map['isLogin'],
    );
  }

  //user mẫu
  List<CompanyUser> accountList = [
    CompanyUser(
      userId: '1',
      fullName: 'Vinh',
      email: '123@gmail.com',
      password: '123',
      companyId: '001',
      companyName: 'Công ty A',
      companyWebsite: 'www.companyA.com',
      companyDescription: 'Công ty A',
      employeesID: '1',
      isLogin: false
    ),
    CompanyUser(
      userId: '2',
      fullName: 'Pháp Nguyễn',
      email: '234@gmail.com',
      password: '234',
      companyId: '2',
      companyName: 'Công ty B',
      companyWebsite: 'www.companyB.com',
      companyDescription: 'Công ty B',
      employeesID: '2',
      isLogin: true
    ),
    CompanyUser(
      userId: '3',
      fullName: 'Chính Trần',
      email: '345@gmail.com',
      password: '345',
      companyId: '3',
      companyName: 'Công ty C',
      companyWebsite: 'www.companyC.com',
      companyDescription: 'Công ty C',
      employeesID: '3',
      isLogin: false
    ),
  ];
}
