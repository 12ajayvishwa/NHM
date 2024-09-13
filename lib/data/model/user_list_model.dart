class UserListModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? registrationNo;
  String? slug;
  dynamic? description;
  String? userTypeId;
  String? address;
  dynamic? experience;
  dynamic? verified;
  String? gender;
  dynamic? avatar;
  int? active;
  String? role;
  dynamic? fcmToken;
  String? locale;
  String? accountType;
  dynamic? rememberMeToken;
  String? createdAt;
  String? updatedAt;
  dynamic? deletedAt;
  int? invalidLoginAttempts;

  UserListModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.registrationNo,
      this.slug,
      this.description,
      this.userTypeId,
      this.address,
      this.experience,
      this.verified,
      this.gender,
      this.avatar,
      this.active,
      this.role,
      this.fcmToken,
      this.locale,
      this.accountType,
      this.rememberMeToken,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.invalidLoginAttempts});

  UserListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    registrationNo = json['registration_no'];
    slug = json['slug'];
    description = json['description'];
    userTypeId = json['user_type_id'];
    address = json['address'];
    experience = json['experience'];
    verified = json['verified'];
    gender = json['gender'];
    avatar = json['avatar'];
    active = json['active'];
    role = json['role'];
    fcmToken = json['fcm_token'];
    locale = json['locale'];
    accountType = json['account_type'];
    rememberMeToken = json['remember_me_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    invalidLoginAttempts = json['invalid_login_attempts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['registration_no'] = this.registrationNo;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['user_type_id'] = this.userTypeId;
    data['address'] = this.address;
    data['experience'] = this.experience;
    data['verified'] = this.verified;
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    data['active'] = this.active;
    data['role'] = this.role;
    data['fcm_token'] = this.fcmToken;
    data['locale'] = this.locale;
    data['account_type'] = this.accountType;
    data['remember_me_token'] = this.rememberMeToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['invalid_login_attempts'] = this.invalidLoginAttempts;
    return data;
  }

  void forEach(Null Function(dynamic data) param0) {}
}
