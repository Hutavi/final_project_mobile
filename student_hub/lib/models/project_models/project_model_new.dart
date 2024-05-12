class ProjectModelNew {
  int? companyId;
  int? projectScopeFlag;
  String? title;
  int? numberOfStudents;
  String? description;
  int? typeFlag;
  String? updatedAt;
  String? deletedAt;
  int? id;
  String? createdAt;

  ProjectModelNew({
    this.companyId,
    this.projectScopeFlag,
    this.title,
    this.numberOfStudents,
    this.description,
    this.typeFlag,
    this.updatedAt,
    this.deletedAt,
    this.id, //id project
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
      'projectScopeFlag': projectScopeFlag,
      'title': title,
      'numberOfStudents': numberOfStudents,
      'description': description,
      'typeFlag': typeFlag,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'id': id,
      'createdAt': createdAt,
    };
  }

  factory ProjectModelNew.fromJson(Map<String, dynamic> json) {
    return ProjectModelNew(
      companyId: json['companyId'],
      projectScopeFlag: json['projectScopeFlag'],
      title: json['title'],
      numberOfStudents: json['numberOfStudents'],
      description: json['description'],
      typeFlag: json['typeFlag'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      id: json['id'],
      createdAt: json['createdAt'],
    );
  }
}
