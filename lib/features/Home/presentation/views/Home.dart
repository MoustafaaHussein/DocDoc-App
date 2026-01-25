import 'package:docdoc_app/features/Home/presentation/views/widgets/home_screen_body.dart';
import 'package:docdoc_app/features/payment/presentation/manger/bloc/subcription_bloc.dart';
import 'package:docdoc_app/features/payment/presentation/manger/bloc/subcription_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString("userFirstName") ?? '';
    final lastName = prefs.getString("userLastName") ?? '';
    setState(() {
      username = '$firstName $lastName';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubscriptionBloc, SubscriptionState>(
      listener: (context, state) {
        if (state is PremiumActive) {
          Navigator.pop(context); // close paywall automatically
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('🎉 Premium activated!')),
          );
        }
      },
      child: HomeScreenBody(username: username),
    );
  }
}
