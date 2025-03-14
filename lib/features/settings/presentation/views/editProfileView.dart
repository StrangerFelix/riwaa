import 'package:flutter/material.dart';
import 'package:riwaa/features/settings/presentation/views/widgets/editProfile/editProfileViewBody.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('edit profile'),
      ),
      body: const EditProfileViewBody(),
    );
  }
}