import 'dart:convert';

class ReassignSurgeryModel {
    final int id;
    final String title;
    final dynamic description;
    final int status;
    final int patientId;
    final int doctorId;
    final int approverId;
    final DateTime dateTime;
    final DateTime createdAt;
    final DateTime updatedAt;
    final dynamic deletedAt;
    final Patient patient;
    final Approver doctor;
    final Approver approver;

    ReassignSurgeryModel({
        required this.id,
        required this.title,
        required this.description,
        required this.status,
        required this.patientId,
        required this.doctorId,
        required this.approverId,
        required this.dateTime,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.patient,
        required this.doctor,
        required this.approver,
    });

    factory ReassignSurgeryModel.fromRawJson(String str) => ReassignSurgeryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReassignSurgeryModel.fromJson(Map<String, dynamic> json) => ReassignSurgeryModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        patientId: json["patient_id"],
        doctorId: json["doctor_id"],
        approverId: json["approver_id"],
        dateTime: DateTime.parse(json["date_time"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        patient: Patient.fromJson(json["patient"]),
        doctor: Approver.fromJson(json["doctor"]),
        approver: Approver.fromJson(json["approver"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "status": status,
        "patient_id": patientId,
        "doctor_id": doctorId,
        "approver_id": approverId,
        "date_time": dateTime.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "patient": patient.toJson(),
        "doctor": doctor.toJson(),
        "approver": approver.toJson(),
    };
}

class Approver {
    final int id;
    final String name;
    final String email;
    final String phone;
    final String? registrationNo;
    final String slug;
    final dynamic description;
    final String userTypeId;
    final String address;
    final dynamic experience;
    final dynamic verified;
    final String gender;
    final dynamic avatar;
    final int active;
    final String role;
    final String? fcmToken;
    final String locale;
    final String accountType;
    final dynamic rememberMeToken;
    final DateTime createdAt;
    final DateTime updatedAt;
    final dynamic deletedAt;
    final int invalidLoginAttempts;

    Approver({
        required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.registrationNo,
        required this.slug,
        required this.description,
        required this.userTypeId,
        required this.address,
        required this.experience,
        required this.verified,
        required this.gender,
        required this.avatar,
        required this.active,
        required this.role,
        required this.fcmToken,
        required this.locale,
        required this.accountType,
        required this.rememberMeToken,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.invalidLoginAttempts,
    });

    factory Approver.fromRawJson(String str) => Approver.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Approver.fromJson(Map<String, dynamic> json) => Approver(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        registrationNo: json["registration_no"],
        slug: json["slug"],
        description: json["description"],
        userTypeId: json["user_type_id"],
        address: json["address"],
        experience: json["experience"],
        verified: json["verified"],
        gender: json["gender"],
        avatar: json["avatar"],
        active: json["active"],
        role: json["role"],
        fcmToken: json["fcm_token"],
        locale: json["locale"],
        accountType: json["account_type"],
        rememberMeToken: json["remember_me_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        invalidLoginAttempts: json["invalid_login_attempts"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "registration_no": registrationNo,
        "slug": slug,
        "description": description,
        "user_type_id": userTypeId,
        "address": address,
        "experience": experience,
        "verified": verified,
        "gender": gender,
        "avatar": avatar,
        "active": active,
        "role": role,
        "fcm_token": fcmToken,
        "locale": locale,
        "account_type": accountType,
        "remember_me_token": rememberMeToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "invalid_login_attempts": invalidLoginAttempts,
    };
}

class Patient {
    final int id;
    final String patientName;
    final String husbandName;
    final String phone;
    final String age;
    final String village;
    final String block;
    final String district;
    final dynamic state;
    final String mpid;
    final String gravida;
    final String parity;
    final String procedure;
    final String electiveSurgery;
    final dynamic registrationNo;
    final dynamic description;
    final String address;
    final int status;
    final String nameOfAnesthetist;
    final String typeOfAnesthesia;
    final String palaceOfPosting;
    final String nameOfFacility;
    final String gender;
    final dynamic avatar;
    final int doctorId;
    final int approverId;
    final DateTime dateTime;
    final DateTime createdAt;
    final DateTime updatedAt;
    final dynamic deletedAt;

    Patient({
        required this.id,
        required this.patientName,
        required this.husbandName,
        required this.phone,
        required this.age,
        required this.village,
        required this.block,
        required this.district,
        required this.state,
        required this.mpid,
        required this.gravida,
        required this.parity,
        required this.procedure,
        required this.electiveSurgery,
        required this.registrationNo,
        required this.description,
        required this.address,
        required this.status,
        required this.nameOfAnesthetist,
        required this.typeOfAnesthesia,
        required this.palaceOfPosting,
        required this.nameOfFacility,
        required this.gender,
        required this.avatar,
        required this.doctorId,
        required this.approverId,
        required this.dateTime,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
    });

    factory Patient.fromRawJson(String str) => Patient.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["id"],
        patientName: json["patient_name"],
        husbandName: json["husband_name"],
        phone: json["phone"],
        age: json["age"],
        village: json["village"],
        block: json["block"],
        district: json["district"],
        state: json["state"],
        mpid: json["mpid"],
        gravida: json["gravida"],
        parity: json["parity"],
        procedure: json["procedure"],
        electiveSurgery: json["elective_surgery"],
        registrationNo: json["registration_no"],
        description: json["description"],
        address: json["address"],
        status: json["status"],
        nameOfAnesthetist: json["name_of_anesthetist"],
        typeOfAnesthesia: json["type_of_anesthesia"],
        palaceOfPosting: json["palace_of_posting"],
        nameOfFacility: json["name_of_facility"],
        gender: json["gender"],
        avatar: json["avatar"],
        doctorId: json["doctor_id"],
        approverId: json["approver_id"],
        dateTime: DateTime.parse(json["date_time"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "patient_name": patientName,
        "husband_name": husbandName,
        "phone": phone,
        "age": age,
        "village": village,
        "block": block,
        "district": district,
        "state": state,
        "mpid": mpid,
        "gravida": gravida,
        "parity": parity,
        "procedure": procedure,
        "elective_surgery": electiveSurgery,
        "registration_no": registrationNo,
        "description": description,
        "address": address,
        "status": status,
        "name_of_anesthetist": nameOfAnesthetist,
        "type_of_anesthesia": typeOfAnesthesia,
        "palace_of_posting": palaceOfPosting,
        "name_of_facility": nameOfFacility,
        "gender": gender,
        "avatar": avatar,
        "doctor_id": doctorId,
        "approver_id": approverId,
        "date_time": dateTime.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
    };
}
