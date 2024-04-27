class AccountModel {
  final String name;
  final String email;
  final String password;
  final bool isLogin;
  

  AccountModel({
    required this.name,
    required this.email,
    required this.password,
    required this.isLogin,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      isLogin: json['isLogin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'isLogin': isLogin,
    };
  }

  //getter
  String get getName => name;
  String get getEmail => email;
  String get getPassword => password;
  bool get getIsLogin => isLogin;
  //setter
  set setName(String name) => name;
  set setEmail(String email) => email;
  set setPassword(String password) => password;
  set setIsLogin(bool isLogin) => isLogin;
  
  //copyWith
  AccountModel copyWith({
    String? name,
    String? email,
    String? password,
    bool? isLogin,
  }) {
    return AccountModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isLogin: isLogin ?? this.isLogin,
    );
  }
}