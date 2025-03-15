import 'package:flutter/material.dart';
import 'package:riwaa/features/auth/presentation/views/widgets/register/registerViewBody.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RegisterViewBody(),
    );
  }
}