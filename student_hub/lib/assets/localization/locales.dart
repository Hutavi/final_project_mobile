import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [
  MapLocale('en', LocaleData.EN),
  MapLocale('vi', LocaleData.VI)
];

mixin LocaleData {
  //Student, Company
  static const String student = 'student';
  static const String company = 'company';

  //Homepage
  static const String homeTitle = 'homeTitle';
  static const String homeDescribeItem = 'describe_item';
  static const String homeMoreInfo = 'home_more_info';

  //Login page
  static const String loginTitle = 'login_title';
  static const String email = 'email';
  static const String password = 'password';
  static const String emailPlaholder = 'email_placeholder';
  static const String passwordPlaceholder = 'password_placeholder';
  static const String loginButton = 'login_button';
  static const String forgotPassword = 'forgot_password';
  static const String registerButton = 'register_button';
  static const String userRequiered = 'user_required';
  static const String userNotFound = 'user_not_found';
  static const String passwordRequiered = 'password_required';
  static const String passwordWrong = 'password_wrong';
  static const String clickHere = 'click_here';
  static const String dontHaveAccount = 'dont_have_account';

  static const Map<String, dynamic> EN = {
    //Home page
    student: 'Student',
    company: 'Company',
    homeTitle: 'Build your product with high-skilled student ',
    homeDescribeItem:
        'Find and onboard best-skilled student for your product. Student works to gain experience & skills from real-world projects',
    homeMoreInfo:
        'StudentHub is university market place to connect high-skilled student and company on a real-world project',

    //Login page
    loginTitle: 'Login with StudentHub',
    email: 'Email',
    password: 'Password',
    emailPlaholder: 'Enter your email',
    passwordPlaceholder: 'Enter your password',
    loginButton: 'Sign In',
    forgotPassword: 'Forgot password?',
    registerButton: 'Sign Up',
    dontHaveAccount: 'Don\'t have an an Student Hub account?',
    userRequiered: 'Username or email is required',
    userNotFound: 'User not found',
    passwordRequiered: 'Password is required',
    passwordWrong: 'Password is wrong',
    clickHere: 'Click here',
  };

  static const Map<String, dynamic> VI = {
    //Home page
    student: 'Sinh viên',
    company: 'Công ty',
    homeTitle: 'Xây dựng sản phẩm của bạn với sinh viên có kỹ năng cao',
    homeDescribeItem:
        'Tìm và onboard sinh viên có kỹ năng tốt nhất cho sản phẩm của bạn. Sinh viên làm việc để có được kinh nghiệm và kỹ năng từ các dự án thực tế',
    homeMoreInfo:
        'StudentHub là nơi kết nối sinh viên có kỹ năng cao và công ty trên dự án thực tế',

    //Login page
    loginTitle: 'Đăng nhập với StudentHub',
    email: 'Email',
    password: 'Mật khẩu',
    emailPlaholder: 'Nhập email của bạn',
    passwordPlaceholder: 'Nhập mật khẩu của bạn',
    loginButton: 'Đăng nhập',
    forgotPassword: 'Quên mật khẩu?',
    registerButton: 'Đăng ký',
    userRequiered: 'Tên người dùng hoặc email là bắt buộc',
    userNotFound: 'Người dùng không tồn tại',
    passwordRequiered: 'Mật khẩu là bắt buộc',
    passwordWrong: 'Mật khẩu không đúng',
    clickHere: 'Nhấn vào đây',
    dontHaveAccount: 'Chưa có tài khoản Student Hub?',
  };
}
