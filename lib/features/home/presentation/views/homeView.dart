import 'package:flutter/material.dart';
import 'package:riwaa/features/home/presentation/views/widgets/homeViewBody.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeViewBody(),
    );
  }
}