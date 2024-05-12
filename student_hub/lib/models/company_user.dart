class CompanyUser {
  final int? id;
  final String? createAt;
  final String? updatedAt;
  final String? deletedAt;
  final int? userID;
  final String? companyName;
  final String? website; 
  final int? size;
  final String? description;

  CompanyUser({
    this.id,
    this.createAt,
    this.updatedAt,
    this.deletedAt,
    this.userID,
    this.companyName,
    this.website,
    this.size,
    this.description,
  });

  Map<String, dynamic> toMapCompanyUser() => {
        'companyName': companyName,
        'website': website,
        'size': size,
        'description': description,
      };

  factory CompanyUser.fromMapCompanyUser(Map<String, dynamic> map) {
    return CompanyUser(
      id: map['id'],
      createAt: map['createAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      userID: map['userID'],
      companyName: map['companyName'],
      website: map['website'],
      size: map['size'],
      description: map['description'],
    );
  }

  toMapCompany() {}

  String printAll() {
    return 'CompanyUser(id: $id, createAt: $createAt, updatedAt: $updatedAt, deletedAt: $deletedAt, userID: $userID, companyName: $companyName, website: $website, size: $size, description: $description)';
  }
}
