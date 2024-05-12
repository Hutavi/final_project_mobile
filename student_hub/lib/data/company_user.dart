class CompanyUser {
  final String userId; //id của người dùng trong hệ thống
  final String fullName;
  final String email;
  final String password;
  final String typeUser = 'company';
  final String companyId;
  final String companyName;
  final String companyWebsite;
  final String companyDescription;
  final String employeesID; //id của người dùng trong công ty
  bool isLogin = false;
  bool signedIn = false; // Thêm trường signedIn

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
    required this.signedIn,
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

  Map<String, dynamic> toMapCompanyUser() {
    return {
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'password': password,
      'typeUser': typeUser,
      'companyId': companyId, //id của công ty trong hệ thống
      'companyName': companyName,
      'companyWebsite': companyWebsite,
      'companyDescription': companyDescription,
      'employeesID': employeesID,
      'isLogin': isLogin,
      'signedIn': signedIn, // Thêm signedIn vào đây
    };
  }

  factory CompanyUser.fromMapCompanyUser(Map<String, dynamic> map) {
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
      signedIn: map['signedIn'], // Thêm signedIn vào đây
    );
  }
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
    isLogin: false,
    signedIn: true, // Thêm signedIn vào đây
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
    isLogin: true,
    signedIn: true, // Thêm signedIn vào đây
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
    isLogin: false,
    signedIn: true, // Thêm signedIn vào đây
  ),
];
