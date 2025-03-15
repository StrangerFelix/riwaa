import 'package:flutter/material.dart';
import 'package:riwaa/features/auth/presentation/views/widgets/login/loginViewBody.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginViewBody(),
    );
  }
}