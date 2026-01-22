import 'package:docdoc_app/features/Login/Data/Cubit/LoginState.dart';
import 'package:docdoc_app/features/Login/Data/Repo/LoginRepo.dart';
import 'package:docdoc_app/features/SignUP/presentation/data/repo/SignUpRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginCubit(this.authRepository) : super(LoginInitial());

  Future<void> login(LoginRequestModel model, String trim) async {
    emit(LoginLoading());
    try {
      final response = await authRepository.login(model);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt("userId", response.user.id);
      await prefs.setString("userFirstName", response.user.firstName);
      await prefs.setString("userLastName", response.user.lastName);
      await prefs.setString("userEmail", response.user.email);

      prefs.setBool("isLoggedIn", true);

      emit(LoginSuccess(response));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
  Future<void> deleteAccount(String password) async {
    emit(LoginLoading());
    try {
      // Here you would call the delete account method from your repository
      // For example: await authRepository.deleteAccount(userId);

      // Simulating a successful account deletion
      await Future.delayed(const Duration(seconds: 2));
      await authRepository.deleteAccount(password);

      emit(DeleteAccountSuccess("Account deleted successfully."));
    } catch (e) {
      emit(DeleteAccountFailure(e.toString()));
    }
  }
}
