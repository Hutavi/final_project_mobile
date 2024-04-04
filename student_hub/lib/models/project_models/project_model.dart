// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProjectModel {
  String? title;
  String? describe;
  String? proposals;
  bool favorite;
  
  ProjectModel({
    this.title,
    this.describe,
    this.proposals,
    required this.favorite,
  });

  ProjectModel copyWith({
    String? title,
    String? describe,
    String? proposals,
  }) {
    return ProjectModel(
      title: title ?? this.title,
      describe: describe ?? this.describe,
      proposals: proposals ?? this.proposals,
      favorite: false,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'describe': describe,
      'proposals': proposals,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      title: map['title'] != null ? map['title'] as String : null,
      describe: map['describe'] != null ? map['describe'] as String : null,
      proposals: map['proposals'] != null ? map['proposals'] as String : null,
      favorite: false,
    );
  }
}
