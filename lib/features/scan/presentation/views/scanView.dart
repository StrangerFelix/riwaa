import 'package:flutter/material.dart';
import 'package:riwaa/features/scan/presentation/views/widgets/scanViewBody.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('scan plant'),
      ),
      body: const ScanViewBody()
    );
  }
}