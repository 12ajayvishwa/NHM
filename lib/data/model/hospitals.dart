// ignore_for_file: prefer_collection_literals, unnecessary_new, unnecessary_this

class Hospital {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? registrationNo;
  String? slug;
  dynamic designation;
  String? userTypeId;
  dynamic hospitalId;
  dynamic specializationId;
  String? address;
  dynamic gender;
  dynamic avatar;
  int? active;
  String? role;
  String? locale;
  String? accountType;
  dynamic rememberMeToken;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  int? invalidLoginAttempts;

  Hospital(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.registrationNo,
      this.slug,
      this.designation,
      this.userTypeId,
      this.hospitalId,
      this.specializationId,
      this.address,
      this.gender,
      this.avatar,
      this.active,
      this.role,
      this.locale,
      this.accountType,
      this.rememberMeToken,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.invalidLoginAttempts});

  Hospital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    registrationNo = json['registration_no'];
    slug = json['slug'];
    designation = json['designation'];
    userTypeId = json['user_type_id'];
    hospitalId = json['hospital_id'];
    specializationId = json['specialization_id'];
    address = json['address'];
    gender = json['gender'];
    avatar = json['avatar'];
    active = json['active'];
    role = json['role'];
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
    data['designation'] = this.designation;
    data['user_type_id'] = this.userTypeId;
    data['hospital_id'] = this.hospitalId;
    data['specialization_id'] = this.specializationId;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    data['active'] = this.active;
    data['role'] = this.role;
    data['locale'] = this.locale;
    data['account_type'] = this.accountType;
    data['remember_me_token'] = this.rememberMeToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['invalid_login_attempts'] = this.invalidLoginAttempts;
    return data;
  }
}
