//chưa hoàn thiện các biến trong studentUser
//thành viên làm flow student user sẽ hoàn thiện sau
class StudentUser{
  final int? id;
  final String? createAt;
  final String? updatedAt;
  final String? deletedAt;
  final int? userID;
  int? techStack;
  int? skillSet;
  int? languages;
  int? education;
  int? experience;

  StudentUser({
    this.id,
    this.createAt,
    this.updatedAt,
    this.deletedAt,
    this.userID,
    this.techStack,
    this.skillSet,
    this.languages,
    this.education,
    this.experience,
  });
  Map<String, dynamic> toMapStudentUser() => {
    'techStack': techStack,
    'skillSet': skillSet,
    'languages': languages,
    'education': education,
    'experience': experience,
  };
  factory StudentUser.fromMapStudentUser(Map<String, dynamic> map) {
    return StudentUser(
      id: map['id'],
      createAt: map['createAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      userID: map['userID'],
      techStack: map['techStack'],
      skillSet: map['skillSet'],
      languages: map['languages'],
      education: map['education'],
      experience: map['experience'],
    );
  }
  toMapStudent() {}
}