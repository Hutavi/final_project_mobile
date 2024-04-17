class ProjectForListModel {
  int? projectId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? companyId;
  int? projectScopeFlag;
  String? title;
  String? description;
  int? typeFlag;
  int? numberOfStudents;
  int? countProposals;
  bool? isFavorite;

  ProjectForListModel({
    this.projectId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.companyId,
    this.projectScopeFlag,
    this.title,
    this.description,
    this.typeFlag,
    this.numberOfStudents,
    this.countProposals,
    this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'projectId': projectId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'companyId': companyId,
      'projectScopeFlag': projectScopeFlag,
      'title': title,
      'description': description,
      'typeFlag': typeFlag,
      'numberOfStudents': numberOfStudents,
      'countProposals': countProposals,
      'isFavorite': isFavorite,
    };
  }

  factory ProjectForListModel.fromJson(Map<String, dynamic> json) {
    return ProjectForListModel(
      projectId: json['projectId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      companyId: json['companyId'],
      projectScopeFlag: json['projectScopeFlag'],
      title: json['title'],
      description: json['description'],
      typeFlag: json['typeFlag'],
      numberOfStudents: json['numberOfStudents'],
      countProposals: json['countProposals'],
      isFavorite: json['isFavorite'],
    );
  }
}
