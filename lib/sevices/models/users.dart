import 'package:equatable/equatable.dart';

class UsersModel extends Equatable {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String userId;

 const UsersModel({
  required this.firstName,
  required this.lastName,
  required this.phone,
   required this.email,
  required this.userId,

});

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      email: json["email"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      phone: json["phone"] ?? "",
      userId: json["userId"] ?? "",
    );
  }

  factory UsersModel.empty() {
    return const UsersModel(
      email: "",
      firstName: "",
      lastName: "",
      phone: "",
      userId: "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "userId": userId,
    };
  }

  UsersModel copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    String? userType,
    String? userid,
    String? medicalId,
    String? profileUrl,
  }) {
    return UsersModel(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      userId: userId ?? this.userId,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}