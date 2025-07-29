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
      await prefs.setString("userPhone", response.user.phoneNumber);
      await prefs.setString("userDob", response.user.dateOfBirth);
      await prefs.setString("userGender", response.user.gender);
      await prefs.setString(
        "profilePicture",
        response.user.profilePictureUrl ?? '',

        
      );
      await prefs.setBool("isLoggedIn", true);

      emit(LoginSuccess(response));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
