class LoginResponseModel {
  final bool success;
  final String message;
  final String token;
  final String tokenExpiration;
  final UserModel user;

  LoginResponseModel({
    required this.success,
    required this.message,
    required this.token,
    required this.tokenExpiration,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'],
      message: json['message'],
      token: json['token'],
      tokenExpiration: json['tokenExpiration'],
      user: UserModel.fromJson(json['user']),
    );
  }
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
