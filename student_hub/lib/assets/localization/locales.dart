import 'package:flutter_localization/flutter_localization.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

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
  static const String proposals = 'proposals';
  // static const String message = 'message';
  static const String hired = 'hired';
  static const String dayAgo = 'day_ago';
  static const String minutesAgo = 'minutes_ago';
  static const String hoursAgo = 'hours_ago';

  //dashboard->SendHired
  static const String lessThanOneMonth = 'less_than_one_month';
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
  static const String cancel = 'cancel';
  static const String send = 'send';
  static const String projectScope = 'project_scope';
  static const String teamSize = 'team_size';
  static const String excellent = 'excellent';
  static const String activeProposal = 'active_proposal';
  static const String noActiveProposal = 'no_active_proposal';
  static const String submitted = 'submitted';
  static const String submittedProposal = 'submitted_proposal';

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
    viewHired : 'View hired',
    archieveThisProject: 'Archieve this project',
    editPosting: 'Edit posting',
    removePosting: 'Remove posting',
    startWorkingThisProject: 'Start working this project',
    studentsAreLookingFor: 'Students are looking for',
    proposals: 'Proposals',
    hired: 'Hired',
    dayAgo: 'day ago',
    minutesAgo: 'minutes ago',
    hoursAgo: 'hours ago',
    
    //dashboard->SendHired
    lessThanOneMonth: 'Less than 1 month',
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
    cancel: 'Cancel',
    send: 'Send',
    projectScope: 'Project scope',
    teamSize: 'Team size',
    excellent: 'Excellent',

    //dashboard->studentRole
    activeProposal: 'Active proposal',
    noActiveProposal: 'You have no active proposal',
    submitted: 'Submitted',
    submittedProposal: 'Submitted proposal',
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
    viewHired : 'Xem đã thuê',
    archieveThisProject: 'Lưu trữ dự án này',
    editPosting: 'Chỉnh sửa bài đăng',
    removePosting: 'Xóa bài đăng',
    startWorkingThisProject: 'Bắt đầu làm việc trên dự án này',
    studentsAreLookingFor: 'Sinh viên đang tìm kiếm',
    proposals: 'Proposals',
    // message: 'Tin nhắn',
    hired: 'Đã thuê',
    dayAgo: 'ngày trước',
    minutesAgo: 'phút trước',
    hoursAgo: 'giờ trước',

    //dashboard->SendHired
    lessThanOneMonth: 'Dưới 1 tháng',
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
    cancel: 'Hủy',
    send: 'Gửi',
    projectScope: 'Phạm vi dự án',
    teamSize: 'Kích thước nhóm',
    excellent: 'Xuất sắc',
    activeProposal: 'Proposal đang hoạt động',
    noActiveProposal: 'Bạn không có proposal nào',
    submitted: 'Đã gửi',
    submittedProposal: 'Proposal đã gửi',
  };
}