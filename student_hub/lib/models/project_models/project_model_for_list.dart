class ProjectForListModel {
  int? id; //projectId
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
    this.countProposals,
    this.isFavorite,
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
      'countProposals': countProposals,
      'isFavorite': isFavorite,
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
      countProposals: json['countProposals'],
      isFavorite: json['isFavorite'],
    );
  }

  // fromMap
  factory ProjectForListModel.fromMap(Map<String, dynamic> map) {
    return ProjectForListModel(
      id: map['id'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      companyId: map['companyId'],
      projectScopeFlag: map['projectScopeFlag'],
      title: map['title'],
      description: map['description'],
      typeFlag: map['typeFlag'],
      numberOfStudents: map['numberOfStudents'],
      countProposals: map['countProposals'],
      isFavorite: map['isFavorite'],
    );
  }
}
