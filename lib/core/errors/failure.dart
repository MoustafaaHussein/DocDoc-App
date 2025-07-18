import 'package:dio/dio.dart';

abstract class RequestFailure {
  final String errorMessage;

  RequestFailure({required this.errorMessage});
}

class ServiceFailure extends RequestFailure {
  ServiceFailure({required super.errorMessage});

  factory ServiceFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServiceFailure(errorMessage: 'Connection Timed out');

      case DioExceptionType.sendTimeout:
        return ServiceFailure(errorMessage: 'Send Time out');
      case DioExceptionType.receiveTimeout:
        return ServiceFailure(errorMessage: 'Receive Time out');
      case DioExceptionType.badCertificate:
        return ServiceFailure(errorMessage: 'oops there was an error');

      case DioExceptionType.badResponse:
        ServiceFailure.fromResponse(
          dioError.response!.statusCode!,
          dioError.response!,
        );
        return ServiceFailure(errorMessage: 'oops there was an error');
      case DioExceptionType.cancel:
        return ServiceFailure(errorMessage: 'Request cancelled');
      case DioExceptionType.connectionError:
        return ServiceFailure(errorMessage: 'Connection Error ');
      case DioExceptionType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return ServiceFailure(errorMessage: 'No internet Connection');
        } else {
          return ServiceFailure(
            errorMessage: 'Unexpected Error, please try again later',
          );
        }
    }
  }

  factory ServiceFailure.fromResponse(int statusCode, dynamic response) {
    final data = response.data;

    if (data is Map<String, dynamic>) {
      final message =
          data['error'] is Map && data['error']['message'] != null
              ? data['error']['message']
              : data['message'] ?? 'Oops there was an error';

      if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
        return ServiceFailure(errorMessage: message);
      } else if (statusCode == 500) {
        return ServiceFailure(errorMessage: 'Internal server error');
      } else {
        return ServiceFailure(errorMessage: message);
      }
    }

    return ServiceFailure(errorMessage: 'Unexpected error');
  }

  // factory ServiceFailure.fromFirebaseAuth(FirebaseAuthException ex) {
  //   switch (ex.code) {
  //     case 'wrong-password':
  //       return ServiceFailure(
  //         errorMessage: 'Wrong password, please try again.',
  //       );
  //     case 'user-not-found':
  //       return ServiceFailure(
  //         errorMessage:
  //             'User not found. Please register or enter the correct user.',
  //       );
  //     case 'email-already-in-use':
  //       return ServiceFailure(
  //         errorMessage: 'This email is already in use. Try logging in instead.',
  //       );
  //     case 'invalid-email':
  //       return ServiceFailure(
  //         errorMessage: 'Invalid email format. Please enter a valid email.',
  //       );
  //     case 'weak-password':
  //       return ServiceFailure(
  //         errorMessage: 'Weak password. Please choose a stronger password.',
  //       );
  //     case 'too-many-requests':
  //       return ServiceFailure(
  //         errorMessage: 'Too many failed attempts. Try again later.',
  //       );
  //     case 'network-request-failed':
  //       return ServiceFailure(
  //         errorMessage:
  //             'Network error. Check your internet connection and try again.',
  //       );
  //     case 'user-disabled':
  //       return ServiceFailure(
  //         errorMessage: 'This account has been disabled by the administrator.',
  //       );

  //     case 'invalid-credential':
  //       return ServiceFailure(
  //         errorMessage: 'Wrong email or Password Please try Again',
  //       );
  //     case 'session-expired':
  //       return ServiceFailure(
  //         errorMessage: 'Your session has expired. Please log in again.',
  //       );
  //     case 'account-exists-with-different-credential':
  //       return ServiceFailure(
  //         errorMessage:
  //             'An account already exists with a different credential.',
  //       );

  //     case 'credential-already-in-use':
  //       return ServiceFailure(
  //         errorMessage:
  //             'This Email is already associated with another account.',
  //       );
  //     case 'invalid-verification-code':
  //       return ServiceFailure(
  //         errorMessage:
  //             'Invalid verification code. Please enter the correct code.',
  //       );
  //     case 'invalid-verification-id':
  //       return ServiceFailure(
  //         errorMessage:
  //             'Invalid verification ID. Please request a new verification code.',
  //       );
  //     default:
  //       return ServiceFailure(
  //         errorMessage: 'An unknown authentication error occurred.',
  //       );
  //   }
  // }
}

class CacheFailure extends RequestFailure {
  CacheFailure({required super.errorMessage});
}
