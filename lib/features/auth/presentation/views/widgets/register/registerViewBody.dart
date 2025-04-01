import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/components/customFormButton.dart';
import 'package:riwaa/core/components/customTextField.dart';
import 'package:riwaa/core/utilities/appRouter.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/auth/presentation/manager/authCubit.dart';
import 'package:riwaa/features/auth/presentation/manager/authStates.dart';
import 'package:riwaa/features/home/presentation/manager/home/homeCubit.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  bool obscureText = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: SizedBox.expand(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تسجيل حساب جديد',
                style: AppStyles.titleLarge
                    .copyWith(fontSize: 35, shadows: AppStyles.mainTextShadows),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                hint: 'الاسم',
                controller: nameController,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'املئ الحقل';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 15,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: CustomTextField(
                  hint: 'Email address',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'املئ الحقل';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: CustomTextField(
                  hint: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'املئ الحقل';
                    }
                    if (val.length < 3) {
                      return 'كلمة السر قصيرة';
                    }
                    return null;
                  },
                  obscureText: obscureText,
                  suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                      )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              BlocConsumer<AuthCubit, AuthStates>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    GoRouter.of(context).pushReplacement(AppRouter.home);
                    BlocProvider.of<HomeCubit>(context).getHomeData();
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      state is! RegisterLoading ? CustomFormButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            final authCubit = context.read<AuthCubit>();
                            // Call the sign up method
                            authCubit.signUp(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text,
                            );
                          }
                        }, 
                        text: 'تسجيل'
                      ) : const Center(
                        child: CircularProgressIndicator(color: kPrimaryColor,),
                      ),
                      state is RegisterFailure ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            state.error,
                            textAlign: TextAlign.center,
                            style: AppStyles.paragraphMedium.copyWith(color: Colors.red),
                          ),
                        ),
                      ) : const SizedBox()

                    ],
                  ); 
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'تمتلك حساباً؟ ',
                    style: AppStyles.bodySmall,
                  ),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    child: Text(
                      'تسجيل الدخول',
                      style: AppStyles.bodySmall.copyWith(
                        color: kPrimaryColor,
                      ),
                    )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
