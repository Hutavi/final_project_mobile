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
  static const String applyNow = 'apply_now';
  static const String saved = 'saved';
  static const String edit = 'edit';
  static const String continu = 'continu';
  static const String failed = 'failed';
  
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
  static const String homeScript = 'home_script';

  //posting - page1
  static const String postingTitle = 'posting_title';
  static const String postingDescribeItem = 'posting_describe_item';
  static const String postingPlaceholder = 'posting_placeholder';
  static const String postingExampleTitle = 'posting_example_title';
  static const String postingExample = 'posting_example';
  static const String postingExample1 = 'posting_example1';
  static const String nextScope = 'next_scope';
  //posting - page2
  static const String postingScopeTitle = 'posting_scope_title';
  static const String postingScopeDescribeItem = 'posting_scope_describe_item';
  static const String postingScopeHowLong = 'posting_scope_how_long';
  static const String postingScopeHowManyStudents = 'posting_scope_how_many_students';
  static const String numberOfStudents = 'number_of_students';
  static const String nextDescription = 'next_description';
  //posting - page3
  static const String postingDescriptionTitle = 'posting_description_title';
  static const String postingDescriptionDescribeItem = 'posting_description_describe_item';
  static const String postingDescriptionLine1 = 'posting_description_line1';
  static const String postingDescriptionLine2 = 'posting_description_line2';
  static const String postingDescriptionLine3 = 'posting_description_line3';
  static const String projectDescription = 'project_description';
  static const String reviewYourPost = 'review_your_post';
  //posting - page4
  static const String reviewTitle = 'review_title';
  static const String studentRequired = 'student_required';
  static const String postJob = 'post_job';

  //reviewPost
  static const String projectDetail = 'project_detail';
  static const String editProject = 'edit_project';

  //edit projetc
  static const String projectTitle = 'project_title';

  //project save page
  static const String savedProjects = 'saved_projects';

  //projectItem favorite
  static const String created = 'created';

  //project search
  static const String searchForProject = 'search_for_project'; 

  //submit proposal
  static const String submitProposal = 'submit_proposal';
  static const String coverLetter = 'cover_letter';
  static const String submitProposalScript = 'submit_proposal_script';

  //switch account page
  static const String home = 'home';
  static const String profile = 'profile';
  static const String settings = 'settings';
  static const String language = 'language';
  static const String logOut = 'log_out';

  //editProfile Company
  static const String edtProfileCompanyTitle = 'edt_profile_company_title';
  static const String companyName = 'company_name';
  static const String website = 'website';
  static const String description = 'description';
  static const String itJustMe = 'it_just_me';
  static const String employees = 'employees';
  static const String moreThan = 'more_than';
  static const String howManyPeopleInYourCompany = 'how_many_people_in_your_company';

  //create profile company
  static const String tellUsAboutYourCompany = 'tell_us_about_your_company';
  static const String yourWayConnectWith = 'your_way_connect_with';

  //welcome screen
  static const String welcomeLine1 = 'welcome_line1';
  static const String getStarted = 'get_started';

  //create profile student
  static const String updateProfile = 'update_profile';
  static const String createdProfile = 'created_profile';
  static const String createdLanguage = 'created_language';
  static const String updatedLanguage = 'updated_language';
  static const String createdEducation = 'created_education';
  static const String updatedEducation = 'updated_education';
  static const String removeLanguage = 'remove_language';
  static const String removeEducation = 'remove_education';
  static const String welcomeLine2 = 'welcome_line2';
  static const String techStack = 'tech_stack';
  static const String selectTechStack = 'select_tech_stack';
  static const String skillSet = 'skill_set';
  static const String selectSkillSet = 'select_skill_set'; 
  static const String create = 'create';
  static const String education = 'education';



  
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
    saved: 'Saved', 
    edit: 'Edit',
    continu: 'Continue',
    failed: 'Failed',

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
    homeScript: 'StudentHub is university market place to connect high-skilled student and company on a real-world project',

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

    //posting - page1
    postingTitle: '1/4 - Let\'s start with a strong title',
    postingDescribeItem:
        'This helps your post stand out to the right students. It\'s the first thing they will see, so make it impressive',
    postingPlaceholder: 'Write a title for your post',
    postingExampleTitle: 'Example title',
    postingExample: 'Build responsive WorldPress site with booking/paying functionality',
    postingExample1: 'Facebook ad specialist need for product launch',
    nextScope: 'Next Scope',
    //posting - page2
    postingScopeTitle: '2/4 - Next, estimate the scope of your job',
    postingScopeDescribeItem: 'Consider the size of your project and the timeline',
    postingScopeHowLong: 'How long will your project take?',
    postingScopeHowManyStudents: 'How many students do you want for this project?',
    numberOfStudents: 'Number of students',
    nextDescription: 'Next: Description',
    //posting - page3
    postingDescriptionTitle: '3/4 - Next, provide project description',
    postingDescriptionDescribeItem: 'Students are looking for:',
    postingDescriptionLine1: 'Clear expectations about your project or deliverables',
    postingDescriptionLine2: 'The skills required for your project',
    postingDescriptionLine3: 'Details about your project',
    projectDescription: 'Project Description',
    reviewYourPost: 'Review your post',
    //posting - page4
    reviewTitle: '4/4-Project details',
    studentRequired: 'Student required',
    postJob: 'Post a job',

    //reviewPost
    projectDetail: 'Project details',
    editProject: 'Edit project',

    //edit projetc
    projectTitle: 'Project title',

    //project save page
    savedProjects: 'Save projects',
    //projectItem favorite
    created: 'Created',

    //project_search
    searchForProject: 'Search for project',

    //submit proposal
    submitProposal: 'Submit proposal',
    coverLetter: 'Cover letter',
    submitProposalScript: 'Describe why do you fit to this project',

    //switch account page
    home: 'Home',
    profile: 'Profile',
    settings: 'Settings',
    language: 'Language',
    logOut: 'Log out',

    //editProfile Company
    edtProfileCompanyTitle: 'Welcome to Student Hub',
    companyName: 'Company name',
    website: 'Website',
    description: 'Description',
    itJustMe: 'It\'s just me',
    employees: 'Employees',
    moreThan: 'More than',
    howManyPeopleInYourCompany: 'How many people are in your company?',
    
    //create profile company
    tellUsAboutYourCompany: 'Tell us about your company and you will be on',
    yourWayConnectWith: 'your way connect with high-skilled students',
  
    //welcome screen
    welcomeLine1: 'Let\'s start with your first project post!',
    getStarted: 'Get Started',  
    
    //create profile student
    updateProfile: 'Update Profile',
    createdProfile: 'Created Profile',
    createdLanguage: 'Created Language',
    updatedLanguage: 'Updated Language',
    createdEducation: 'Created Education',
    updatedEducation: 'Updated Education',
    removeLanguage: 'Remove Language',
    removeEducation: 'Remove Education',
    welcomeLine2: 'Tell us about yourself and you will be on your way to connect with real-world projects',
    techStack: 'Techstack',
    selectTechStack: 'Select techstack',
    skillSet: 'Skillset',
    selectSkillSet: 'Select skillset',
    create: 'Create',
    education: 'Education',


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
    saved: 'Đã lưu',
    edit: 'Chỉnh sửa',
    continu: 'Tiếp tục',
    failed: 'Thất bại',

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
    homeScript: 'StudentHub là nơi kết nối sinh viên có kỹ năng cao và công ty trên dự án thực tế',

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

    //posting - page1
    postingTitle: '1/4 - Hãy bắt đầu với một tiêu đề mạnh mẽ',
    postingDescribeItem:
        'Điều này giúp bài đăng của bạn nổi bật với sinh viên phù hợp. Đây là điều đầu tiên họ sẽ thấy, vì vậy hãy làm cho nó ấn tượng',
    postingPlaceholder: 'Viết tiêu đề cho bài đăng của bạn',
    postingExampleTitle: 'Tiêu đề minh họa',
    postingExample: 'Xây dựng trang web WorldPress phản hồi với chức năng đặt phòng/thanh toán',
    postingExample1: 'Chuyên gia quảng cáo Facebook cần cho ra mắt sản phẩm',
    nextScope: 'Phạm vi tiếp theo',
    //posting - page2
    postingScopeTitle: '2/4 - Tiếp theo, ước lượng phạm vi công việc của bạn',
    postingScopeDescribeItem: 'Xem xét kích thước dự án của bạn và thời gian',
    postingScopeHowLong: 'Dự án của bạn sẽ mất bao lâu?',
    postingScopeHowManyStudents: 'Bạn muốn bao nhiêu sinh viên tham gia dự án này?',
    numberOfStudents: 'Số lượng sinh viên',
    nextDescription: 'Tiếp theo: Mô tả',
    //posting - page3
    postingDescriptionTitle: '3/4 - Tiếp theo, cung cấp mô tả dự án',
    postingDescriptionDescribeItem: 'Sinh viên đang tìm kiếm:',
    postingDescriptionLine1: 'Kỳ vọng rõ ràng về dự án hoặc sản phẩm của bạn',
    postingDescriptionLine2: 'Kỹ năng cần thiết cho dự án của bạn',
    postingDescriptionLine3: 'Chi tiết về dự án của bạn',
    projectDescription: 'Mô tả dự án',
    reviewYourPost: 'Xem lại bài đăng của bạn',
    //posting - page4
    reviewTitle: '4/4-Chi tiết dự án',
    studentRequired: 'Số lượng sinh viên',
    postJob: 'Đăng bài',

    //reviewPost
    projectDetail: 'Chi tiết dự án',
    editProject: 'Chỉnh sửa',
    
    //edit projetc
    projectTitle: 'Tiêu đề dự án',

    //project save page
    savedProjects: 'Dự án đã lưu',
    //projectItem favorite
    created: 'Đã tạo',

    //project search
    searchForProject: 'Tìm kiếm dự án',

    //submit proposal
    submitProposal: 'Gửi proposal',
    coverLetter: 'Thư xin việc',
    submitProposalScript: 'Mô tả lý do bạn phù hợp với dự án này',

    //switch account page
    home: 'Trang chủ',
    profile: 'Hồ sơ',
    settings: 'Cài đặt',
    language: 'Ngôn ngữ',
    logOut: 'Đăng xuất',

    //editProfile Company
    edtProfileCompanyTitle: 'Chào mừng đến với Student Hub',
    companyName: 'Tên công ty',
    website: 'Trang web',
    description: 'Mô tả',
    itJustMe: 'Chỉ có mình tôi',
    employees: 'nhân viên',
    moreThan: 'Hơn',
    howManyPeopleInYourCompany: 'Có bao nhiêu người trong công ty của bạn?',

    //create profile company
    tellUsAboutYourCompany: 'Hãy cho chúng tôi biết về công ty của bạn và bạn sẽ trên',
    yourWayConnectWith: 'đường kết nối với sinh viên có kỹ năng cao',

    //welcome screen
    welcomeLine1: 'Hãy bắt đầu với bài đăng dự án đầu tiên của bạn!',
    getStarted: 'Bắt đầu',

    //create profile student
    updateProfile: 'Cập nhật hồ sơ',
    createdProfile: 'Tạo hồ sơ',
    createdLanguage: 'Tạo ngôn ngữ',
    updatedLanguage: 'Cập nhật ngôn ngữ',
    createdEducation: 'Tạo học vấn',
    updatedEducation: 'Cập nhật học vấn',
    removeLanguage: 'Xóa ngôn ngữ',
    removeEducation: 'Xóa học vấn',
    welcomeLine2: 'Hãy cho chúng tôi biết về bạn và bạn sẽ trên đường kết nối với các dự án thực tế',
    techStack: 'Công nghệ sử dụng',
    selectTechStack: 'Chọn công nghệ sử dụng',
    skillSet: 'Kỹ năng',
    create: 'Tạo',
    education: 'Học vấn',

  };    
}
