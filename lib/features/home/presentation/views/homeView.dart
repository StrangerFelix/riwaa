import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/components/customNavBar.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    required this.navigationShell,
    Key? key}) : super(key: key ?? const ValueKey<String>('HomeView'));
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: navigationShell
          ),
          const CustomNavBar()
        ],
      ),
    );
  }
}