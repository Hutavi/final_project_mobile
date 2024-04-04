class ProjectForListModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? companyId;
  int? projectScopeFlag;
  String? title;
  String? description;
  int? typeFlag;
  int? numberOfStudents;

  ProjectForListModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.companyId,
    this.projectScopeFlag,
    this.title,
    this.description,
    this.typeFlag,
    this.numberOfStudents,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'companyId': companyId,
      'projectScopeFlag': projectScopeFlag,
      'title': title,
      'description': description,
      'typeFlag': typeFlag,
      'numberOfStudents': numberOfStudents,
    };
  }

  factory ProjectForListModel.fromJson(Map<String, dynamic> json) {
    return ProjectForListModel(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      companyId: json['companyId'],
      projectScopeFlag: json['projectScopeFlag'],
      title: json['title'],
      description: json['description'],
      typeFlag: json['typeFlag'],
      numberOfStudents: json['numberOfStudents'],
    );
  }
}
