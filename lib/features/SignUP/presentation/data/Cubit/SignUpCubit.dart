import 'package:docdoc_app/features/SignUP/presentation/data/Cubit/SignUpState.dart';
import 'package:docdoc_app/features/SignUP/presentation/data/model/SignUpModel.dart';
import 'package:docdoc_app/features/SignUP/presentation/data/repo/SignUpRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignUpCubit(this.authRepository) : super(SignUpInitial());

  Future<void> userSignUp(SignUpRequestModel model) async {
    emit(SignUpLoading());
    try {
      final response = await authRepository.signUp(model);

      final user = UserModel.fromJson(response['user']);

      final prefs = await SharedPreferences.getInstance();

      await prefs.setInt("userId", user.id);
      await prefs.setString("userName", "${user.firstName} ${user.lastName}");
      await prefs.setString("userEmail", user.email);
      await prefs.setString("userPhone", user.phoneNumber);
      await prefs.setString("userGender", user.gender);
      await prefs.setString("userDob", user.dateOfBirth);

      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }

  //   Future<Widget> checkAuthStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString("token");
  //   if (token != null && token.isNotEmpty) {
  //     return MainScreen(); // الشاشة الرئيسية
  //   } else {
  //     return LoginScreen();
  //   }
  // }
}
