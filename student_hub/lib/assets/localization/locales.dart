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

  //Change password
  static const String changePassBtn = 'change_pass_btn';
  static const String changePassTitle = 'change_pass_title';
  static const String oldPassword = 'old_password';
  static const String oldPasswordPlaholder = 'old_password_placeholder';
  static const String newPassword = 'new_password';
  static const String newPasswordPlaholder = 'new_password_placeholder';
  static const String oldPasswordRequired = 'old_password_required';
  static const String newPasswordRequired = 'new_password_required';
  static const String newPasswordWeak = 'new_password_weak';
  static const String changePassSuccess = 'change_pass_success';
  static const String changePassFailed = 'change_pass_failed';

  //Modal
  static const String cancel = 'cancel';
  static const String confirm = 'confirm';
  static const String close = 'close';
  static const String success = 'success';
  static const String error = 'error';
  static const String warning = 'warning';
  static const String info = 'info';

  //Project list
  static const String searchProjectTitle = 'search_project_title';
  static const String searchProject = 'search_project';
  static const String filterByTitle = 'filter_by';
  static const String projectLenght = 'project_lenght';
  static const String lessThanOneMonth = 'less_than_one_month';
  static const String oneToThreeMonth = 'one_to_three_month';
  static const String threeToSixMonth = 'three_to_six_month';
  static const String moreThanSixMonth = 'more_than_six_month';
  static const String studentNeeded = 'student_needed';
  static const String studentNeededPlaholder = 'student_needed_placeholder';
  static const String proposalsLessThan = 'proposals_less_than';
  static const String proposalLessThanPlaholder =
      'proposal_less_than_placeholder';
  static const String clearFilter = 'clear_filter';
  static const String applyProject = 'apply_project';
  static const String notFoundProject = 'not_found_project';

  //Saved project
  static const String savedProjectTitle = 'saved_project_title';
  static const String applyNow = 'apply_now';
  static const String save = 'save';

  //Item project
  static const String createdToday = 'created_today';
  static const String createdYesterday = 'created_yesterday';
  static const String createdDayAgo = 'created_day_ago';
  static const String projectDetailTilte = 'project_detail_title';
  static const String studentLookingFor = 'student_looking_for';
  static const String proposals = 'proposals';
  static const String time = 'time';
  static const String projectScope = 'project_scope';

  //
  //navigation menu
  static const String project = 'project';
  static const String dashboard = 'dashboard';
  static const String message = 'message';
  static const String alerts = 'alerts';

  //Dashboard
  static const String yourProject = 'your_project';
  static const String allProject = 'all_project';
  static const String working = 'working';
  static const String archieved = 'archieved';
  static const String haveNotProjectYet = 'have_not_project_yet';
  static const String haveNotProjectWorking = 'have_not_project_working';
  static const String haveNotProjectArchieved = 'have_not_project_archieved';
  static const String viewProposal = 'view_proposal';
  static const String viewMesseges = 'view_messeges';
  static const String viewHired = 'view_hired';
  static const String archieveThisProject = 'archieve_this_project';
  static const String editPosting = 'edit_posting';
  static const String removePosting = 'remove_posting';
  static const String startWorkingThisProject = 'start_working_this_project';
  static const String studentsAreLookingFor = 'students_are_looking_for';
  // static const String proposals = 'proposals';
  // static const String message = 'message';
  static const String hired = 'hired';
  static const String dayAgo = 'day_ago';
  static const String minutesAgo = 'minutes_ago';
  static const String hoursAgo = 'hours_ago';

  //dashboard->SendHired
  // static const String lessThanOneMonth = 'less_than_one_month';
  static const String oneToThreeMonths = 'one_to_three_months';
  static const String threeToSixMonths = 'three_to_six_months';
  static const String moreThanSixMonths = 'more_than_six_months';
  static const String fourthYearStudent = 'fourth_year_student';
  static const String thirdYearStudent = 'third_year_student';
  static const String secondYearStudent = 'second_year_student';
  static const String firstYearStudent = 'first_year_student';
  static const String noDataToProcess = 'no_data_to_process';
  static const String detail = 'detail';
  static const String noHaveProposal = 'no_have_project';
  static const String noHaveMessage = 'no_have_message';
  static const String hiredOffer = 'hired_offer';
  static const String confirmSendOffer = 'confirm_send_offer';
  static const String send = 'send';
  // static const String projectScope = 'project_scope';
  static const String teamSize = 'team_size';
  static const String excellent = 'excellent';
  static const String activeProposal = 'active_proposal';
  static const String noActiveProposal = 'no_active_proposal';
  static const String submitted = 'submitted';
  static const String submittedProposal = 'submitted_proposal';
  static const String forgotPasswordTitle = 'forgot_password_title';
  static const String enterEmailToResetPassword =
      'enter_email_to_reset_password';
  static const String resetPassword = 'reset_password';
  static const String registerTitle = 'register_title';
  static const String registerContent = 'register_content';
  static const String closeBtn = 'close_btn';
  static const String signUpAsCompany = 'sign_up_as_company';
  static const String signUpAsStudent = 'sign_up_as_student';
  static const String fullname = 'fullname';
  static const String enterFullname = 'enter_fullname';
  static const String fullnameRequired = 'fullname_required';
  static const String enterWorkEmailAddr = 'enter_work_email_addr';
  static const String workEmailAddrIsRequired = 'work_email_addr_is_required';
  static const String emailIsInvalid = 'email_is_invalid';
  static const String emailAlreadyExists = 'email_already_exists';
  static const String passwordEightOrMoreCharacters =
      'password_eight_or_more_characters';
  static const String passwordTooWeak = 'password_too_weak';
  static const String passwordTooShort = 'password_too_short';
  static const String confirmPassword = 'confirm_password';

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
    clickHere: ' Click here',

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

    //Project list
    searchProjectTitle: 'Search project',
    searchProject: 'Search for project',
    filterByTitle: 'Filter by',
    projectLenght: 'Project lenght',
    lessThanOneMonth: 'Less than 1 month',
    oneToThreeMonth: '1 to 3 months',
    threeToSixMonth: '3 to 6 months',
    moreThanSixMonth: 'More than 6 months',
    studentNeeded: 'Student needed',
    studentNeededPlaholder: 'Enter students needed',
    proposalsLessThan: 'Proposals less than',
    proposalLessThanPlaholder: 'Enter proposals less than',
    clearFilter: 'Clear filter',
    applyProject: 'Apply',
    notFoundProject: 'Not found project',

    //Saved project
    savedProjectTitle: 'Saved project',
    applyNow: 'Apply now',
    save: 'Save',

    //Item project
    createdToday: 'Created today',
    createdYesterday: 'Created yesterday',
    createdDayAgo: 'Created %a days ago',
    projectDetailTilte: 'Project detail',
    studentLookingFor: 'Student are looking for',
    proposals: 'Proposals students',
    time: 'Time',
    projectScope: 'Project scope',

    //Modal
    cancel: 'Cancel',
    confirm: 'Confirm',
    close: 'Close',
    success: 'Success',
    error: 'Error',
    warning: 'Warning',
    info: 'Info',

    //forgot password
    forgotPasswordTitle: 'Forgot Password',
    enterEmailToResetPassword: 'Enter your email to reset password',
    resetPassword: 'Reset Password',

    //Change password
    changePassBtn: 'Change password',
    changePassTitle: 'Change new password',
    oldPassword: 'Old password',
    oldPasswordPlaholder: 'Enter your old password',
    newPassword: 'New password',
    newPasswordPlaholder: 'Enter your new password',
    oldPasswordRequired: 'Old password is required',
    newPasswordRequired: 'New password is required',
    newPasswordWeak: 'New password is weak',
    changePassSuccess: 'Change password success',
    changePassFailed: 'Change password failed',

    //register by screen
    registerTitle: 'Register successfully',
    registerContent: 'Please check your email to verify your account',
    closeBtn: 'Close',
    signUpAsCompany: 'Sign up as company',
    signUpAsStudent: 'Sign up as student',
    fullname: 'Fullname',
    enterFullname: 'Enter your fullname',
    fullnameRequired: 'Fullname is required',
    enterWorkEmailAddr: 'Enter your work email address',
    workEmailAddrIsRequired: 'Work email address is required',
    emailIsInvalid: 'Email is invalid',
    emailAlreadyExists: 'Email already exists',
    passwordEightOrMoreCharacters: 'Password must be 8 or more characters',
    passwordTooWeak: 'Password is too weak',
    passwordTooShort: 'Password is too short',
    confirmPassword: 'Confirm password',

    //navigation menu
    project: 'Project',
    dashboard: 'Dashboard',
    message: 'Message',
    alerts: 'Alerts',

    //dashboard
    yourProject: 'Your project',
    allProject: 'All project',
    working: 'Working',
    archieved: 'Archieved',
    haveNotProjectYet: 'You have not project yet',
    haveNotProjectWorking: 'You have not working project yet',
    haveNotProjectArchieved: 'You have not archieved project yet',
    viewProposal: 'View proposal',
    viewMesseges: 'View messeges',
    viewHired: 'View hired',
    archieveThisProject: 'Archieve this project',
    editPosting: 'Edit posting',
    removePosting: 'Remove posting',
    startWorkingThisProject: 'Start working this project',
    studentsAreLookingFor: 'Students are looking for',
    // proposals: 'Proposals',
    hired: 'Hired',
    dayAgo: 'day ago',
    minutesAgo: 'minutes ago',
    hoursAgo: 'hours ago',

    //dashboard->SendHired
    // lessThanOneMonth: 'Less than 1 month',
    oneToThreeMonths: '1-3 months',
    threeToSixMonths: '3-6 months',
    moreThanSixMonths: 'More than 6 months',
    fourthYearStudent: 'Fourth year student',
    thirdYearStudent: 'Third year student',
    secondYearStudent: 'Second year student',
    firstYearStudent: 'First year student',
    noDataToProcess: 'No data to process',
    detail: 'Detail',
    noHaveProposal: 'You have not proposal yet',
    noHaveMessage: 'You have not message yet',
    hiredOffer: 'Hired offer',
    confirmSendOffer:
        'Do you really want to send hired offer for student to do this project?',
    send: 'Send',
    // projectScope: 'Project scope',
    teamSize: 'Team size',
    excellent: 'Excellent',

    //dashboard->studentRole
    activeProposal: 'Active proposal',
    noActiveProposal: 'You have no active proposal',
    submitted: 'Submitted',
    submittedProposal: 'Submitted proposal',
  };

  /// Vietnamese
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
    clickHere: ' Nhấn vào đây',
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

    //change password'
    changePassBtn: 'Đổi mật khẩu',
    changePassTitle: 'Đổi mật khẩu mới',
    oldPassword: 'Mật khẩu cũ',
    oldPasswordPlaholder: 'Nhập mật khẩu cũ của bạn',
    newPassword: 'Mật khẩu mới',
    newPasswordPlaholder: 'Nhập mật khẩu mới của bạn',
    oldPasswordRequired: 'Mật khẩu cũ là bắt buộc',
    newPasswordRequired: 'Mật khẩu mới là bắt buộc',
    newPasswordWeak: 'Mật khẩu mới quá yếu',
    changePassSuccess: 'Đổi mật khẩu thành công',
    changePassFailed: 'Đổi mật khẩu thất bại',

    //Project list
    searchProjectTitle: 'Tìm kiếm dự án',
    searchProject: 'Tìm kiếm dự án',
    filterByTitle: 'Lọc theo',
    projectLenght: 'Thời gian dự án',
    lessThanOneMonth: 'Dưới 1 tháng',
    oneToThreeMonth: '1 đến 3 tháng',
    threeToSixMonth: '3 đến 6 tháng',
    moreThanSixMonth: 'Hơn 6 tháng',
    studentNeeded: 'Sinh viên cần',
    studentNeededPlaholder: 'Nhập số sinh viên cần',
    proposalsLessThan: 'Đề xuất ít hơn',
    proposalLessThanPlaholder: 'Nhập số đề xuất ít hơn',
    clearFilter: 'Xóa bộ lọc',
    applyProject: 'Ứng tuyển',
    notFoundProject: 'Không tìm thấy dự án',
    projectScope: 'Phạm vi dự án',

    //Saved project
    savedProjectTitle: 'Dự án đã lưu',
    applyNow: 'Ứng tuyển ngay',
    save: 'Lưu',

    //Item project
    createdToday: 'Được tạo hôm nay',
    createdYesterday: 'Được tạo hôm qua',
    createdDayAgo: 'Được tạo %a ngày trước',
    projectDetailTilte: 'Chi tiết dự án',
    studentLookingFor: 'Sinh viên đang tìm kiếm',
    proposals: 'Đề xuất sinh viên',
    time: 'Thời gian',

    //Modal
    cancel: 'Hủy',
    confirm: 'Xác nhận',
    close: 'Đóng',
    success: 'Thành công',
    error: 'Lỗi',
    warning: 'Cảnh báo',
    info: 'Thông báo',

    //forgot password
    forgotPasswordTitle: 'Quên mật khẩu',
    enterEmailToResetPassword: 'Nhập email của bạn để đặt lại mật khẩu',
    resetPassword: 'Đặt lại mật khẩu',

    //register by screen
    registerTitle: 'Đăng ký thành công',
    registerContent: 'Vui lòng kiểm tra email của bạn để xác minh tài khoản',
    closeBtn: 'Đóng',
    signUpAsCompany: 'Đăng ký với tư cách công ty',
    signUpAsStudent: 'Đăng ký với tư cách sinh viên',
    fullname: 'Họ và tên',
    enterFullname: 'Nhập họ và tên của bạn',
    fullnameRequired: 'Họ và tên là bắt buộc',
    enterWorkEmailAddr: 'Nhập địa chỉ email công việc của bạn',
    workEmailAddrIsRequired: 'Địa chỉ email công việc là bắt buộc',
    emailIsInvalid: 'Email không hợp lệ',
    emailAlreadyExists: 'Email đã tồn tại',
    passwordEightOrMoreCharacters: 'Mật khẩu phải có 8 ký tự trở lên',
    passwordTooWeak: 'Mật khẩu quá yếu',
    passwordTooShort: 'Mật khẩu quá ngắn',
    confirmPassword: 'Xác nhận mật khẩu',

    //navigation menu
    project: 'Dự án',
    dashboard: 'Bảng điều khiển',
    message: 'Tin nhắn',
    alerts: 'Thông báo',

    //dashboard
    yourProject: 'Dự án của bạn',
    allProject: 'Tất cả dự án',
    working: 'Đang làm việc',
    archieved: 'Đã lưu trữ',
    haveNotProjectYet: 'Bạn chưa có dự án nào',
    haveNotProjectWorking: 'Bạn chưa có dự án nào đang làm việc',
    haveNotProjectArchieved: 'Bạn chưa có dự án nào đã lưu trữ',
    viewProposal: 'Xem proposal',
    viewMesseges: 'Xem tin nhắn',
    viewHired: 'Xem đã thuê',
    archieveThisProject: 'Lưu trữ dự án này',
    editPosting: 'Chỉnh sửa bài đăng',
    removePosting: 'Xóa bài đăng',
    startWorkingThisProject: 'Bắt đầu làm việc trên dự án này',
    studentsAreLookingFor: 'Sinh viên đang tìm kiếm',
    // proposals: 'Proposals',
    hired: 'Đã thuê',
    dayAgo: 'ngày trước',
    minutesAgo: 'phút trước',
    hoursAgo: 'giờ trước',

    //dashboard->SendHired
    // lessThanOneMonth: 'Dưới 1 tháng',
    oneToThreeMonths: '1-3 tháng',
    threeToSixMonths: '3-6 tháng',
    moreThanSixMonths: 'Hơn 6 tháng',
    fourthYearStudent: 'Sinh viên năm 4',
    thirdYearStudent: 'Sinh viên năm 3',
    secondYearStudent: 'Sinh viên năm 2',
    firstYearStudent: 'Sinh viên năm 1',
    noDataToProcess: 'Không có dữ liệu để xử lý',
    detail: 'Chi tiết',
    noHaveProposal: 'Bạn chưa có proposal nào',
    noHaveMessage: 'Bạn chưa có tin nhắn nào',
    hiredOffer: 'Đề nghị thuê',
    confirmSendOffer:
        'Bạn có thực sự muốn gửi đề nghị thuê cho sinh viên thực hiện dự án này không?',
    send: 'Gửi',
    // projectScope: 'Phạm vi dự án',
    teamSize: 'Kích thước nhóm',
    excellent: 'Xuất sắc',
    activeProposal: 'Proposal đang hoạt động',
    noActiveProposal: 'Bạn không có proposal nào',
    submitted: 'Đã gửi',
    submittedProposal: 'Proposal đã gửi',
  };
}
