class SignUpRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;

  SignUpRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "confirmPassword": confirmPassword,
  };
}

class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }
}
