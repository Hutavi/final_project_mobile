// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProjectFavourite {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String companyId;
  final int projectScopeFlag;
  final String title;
  final String description;
  final int numberOfStudents;
  final int typeFlag;
  final int countProposals;

  ProjectFavourite({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.companyId,
    required this.projectScopeFlag,
    required this.title,
    required this.description,
    required this.numberOfStudents,
    required this.typeFlag,
    required this.countProposals,
  });

  factory ProjectFavourite.fromJson(Map<String, dynamic> map) {
    return ProjectFavourite(
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      deletedAt: map['deletedAt'] != null ? map['deletedAt'] as String : null,
      companyId: map['companyId'] as String,
      projectScopeFlag: map['projectScopeFlag'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      numberOfStudents: map['numberOfStudents'] as int,
      typeFlag: map['typeFlag'] as int,
      countProposals: map['countProposals'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'companyId': companyId,
      'projectScopeFlag': projectScopeFlag,
      'title': title,
      'description': description,
      'numberOfStudents': numberOfStudents,
      'typeFlag': typeFlag,
      'countProposals': countProposals,
    };
  }

  factory ProjectFavourite.fromMap(Map<String, dynamic> map) {
    return ProjectFavourite(
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      deletedAt: map['deletedAt'] != null ? map['deletedAt'] as String : null,
      companyId: map['companyId'] as String,
      projectScopeFlag: map['projectScopeFlag'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      numberOfStudents: map['numberOfStudents'] as int,
      typeFlag: map['typeFlag'] as int,
      countProposals: map['countProposals'] as int,
    );
  }

  String toJson() => json.encode(toMap());
}
