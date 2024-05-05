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
  static const String emailRequired = 'email_required';
  static const String userNotFound = 'user_not_found';
  static const String passwordRequiered = 'password_required';
  static const String passwordWrong = 'password_wrong';
  static const String clickHere = 'click_here';
  static const String dontHaveAccount = 'dont_have_account';

  //Register page
  static const String titleRegister = 'title_register';
  static const String studentRegister = 'student_register';
  static const String companyRegister = 'company_register';
  static const String registerAcc = 'register_acc';
  static const String registerByStudentTitle = 'register_by_student_title';
  static const String registerByCompanyTitle = 'register_by_company_title';
  static const String registerFullname = 'register_fullname';
  static const String fullNamePlaholder = 'full_name_placeholder';
  static const String fullNameRequired = 'full_name_required';
  static const String emailExist = 'email_exist';
  static const String registerConfirmPass = 'register_confirm_pass';
  static const String createButton = 'create_button';
  static const String validPassword = 'valid_password';
  static const String passworkWeak = 'password_weak';
  static const String passwordShort = 'password_short';
  static const String passwordNotMatch = 'password_not_match';
  static const String requiredConfirmPassword = 'required_confirm_password';
  static const String sayYes = 'say_yes';
  static const String regisSuccess = 'regis_success';
  static const String verifyEmail = 'verify_email';

  //Forgot password
  static const String forgotPassTitle = 'forgot_pass_title';
  static const String forgotLabel = 'forgot_label';
  static const String forgotButton = 'forgot_button';
  static const String forgotSuccess = 'forgot_success';

  //Modal
  static const String cancel = 'cancel';
  static const String confirm = 'confirm';
  static const String close = 'close';
  static const String success = 'success';
  static const String error = 'error';
  static const String warning = 'warning';
  static const String info = 'info';

  //

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
    emailRequired: 'Email is required',
    userNotFound: 'User not found',
    passwordRequiered: 'Password is required',
    passwordWrong: 'Password is wrong',
    clickHere: 'Click here',

    //register page
    titleRegister: 'Join as Company or Student',
    studentRegister: 'I am a student, find jobs for me',
    companyRegister: 'I am a company, find engineer for project',
    registerAcc: 'Register Account',
    registerByCompanyTitle: 'Sign up as Company',
    registerByStudentTitle: 'Sign up as Student',
    registerFullname: 'Fullname',
    fullNamePlaholder: 'Enter your fullname',
    fullNameRequired: 'Fullname is required',
    emailExist: 'Email is already exist',
    validPassword: 'Password (8 or more characters)',
    passworkWeak: 'Password is too weak',
    passwordShort: 'Password is too short',
    passwordNotMatch: 'Password not match',
    requiredConfirmPassword: 'Confirm password is required',
    sayYes: 'Yes, I understand and agree to StudentHub',
    registerConfirmPass: 'Confirm Password',
    createButton: 'Create Account',
    regisSuccess: 'Register success',
    verifyEmail: 'Please verify your email',

    //Forgot password
    forgotPassTitle: 'Forgot password',
    forgotLabel: 'Enter your email to reset password',
    forgotButton: 'Reset password',
    forgotSuccess: 'New password has been sent to your email.',

    //Modal
    cancel: 'Cancel',
    confirm: 'Confirm',
    close: 'Close',
    success: 'Success',
    error: 'Error',
    warning: 'Warning',
    info: 'Info',
  };

  ///

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
    emailRequired: 'Email là bắt buộc',
    userNotFound: 'Người dùng không tồn tại',
    passwordRequiered: 'Mật khẩu là bắt buộc',
    passwordWrong: 'Mật khẩu không đúng',
    clickHere: 'Nhấn vào đây',
    dontHaveAccount: 'Chưa có tài khoản Student Hub?',

    //register page
    titleRegister: 'Tham gia với vai trò Sinh viên hoặc Công ty',
    studentRegister: 'Tôi là sinh viên, tìm việc cho tôi',
    companyRegister: 'Tôi là công ty, tìm kỹ sư cho dự án',
    registerAcc: 'Đăng ký tài khoản',
    registerByCompanyTitle: 'Đăng ký với vai trò Công ty',
    registerByStudentTitle: 'Đăng ký với vai trò Sinh viên',
    registerFullname: 'Họ và tên',
    fullNameRequired: 'Họ và tên là bắt buộc',
    emailExist: 'Email đã tồn tại',
    fullNamePlaholder: 'Nhập họ và tên của bạn',
    validPassword: 'Mật khẩu (8 ký tự trở lên)',
    registerConfirmPass: 'Xác nhận mật khẩu',
    passworkWeak: 'Mật khẩu quá yếu',
    passwordShort: 'Mật khẩu quá ngắn',
    passwordNotMatch: 'Mật khẩu không khớp',
    requiredConfirmPassword: 'Xác nhận mật khẩu là bắt buộc',
    sayYes: 'Có, tôi hiểu và đồng ý với StudentHub',
    createButton: 'Tạo tài khoản',
    regisSuccess: 'Đăng ký thành công',
    verifyEmail: 'Hãy thực hiện xác nhận email của bạn',

    //Forgot password
    forgotPassTitle: 'Quên mật khẩu',
    forgotLabel: 'Nhập email của bạn để đặt lại mật khẩu',
    forgotButton: 'Đặt lại mật khẩu',
    forgotSuccess: 'Mật khẩu mới đã được gửi đến email của bạn.',

    //Modal
    cancel: 'Hủy',
    confirm: 'Xác nhận',
    close: 'Đóng',
    success: 'Thành công',
    error: 'Lỗi',
    warning: 'Cảnh báo',
    info: 'Thông báo',
  };
}
