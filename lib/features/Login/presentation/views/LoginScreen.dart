import 'package:docdoc_app/features/Login/presentation/views/widgets/LoginForm.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final emailController = TextEditingController();
  final PasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginForm(
        emailController: emailController,
        passwordController: PasswordController,
      ),
    );
  }
}
