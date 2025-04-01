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

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  bool obscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: SizedBox.expand(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تسجيل الدخول',
                style: AppStyles.titleLarge
                    .copyWith(fontSize: 40, shadows: AppStyles.mainTextShadows),
              ),
              const SizedBox(
                height: 30,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: CustomTextField(
                  hint: 'Email address',
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
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
                  obscureText: obscureText,
                  controller: passwordController,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'املئ الحقل';
                    }
                    return null;
                  },
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
                  if (state is LoginSuccess) {
                    GoRouter.of(context).pushReplacement(AppRouter.home);
                    BlocProvider.of<HomeCubit>(context).getHomeData();
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      state is! LoginLoading ? CustomFormButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).login(
                              email: emailController.text, 
                              password: passwordController.text
                            );
                          }
                        }, text: 'تسجيل'
                      ) : const Center(
                        child: CircularProgressIndicator(color: kPrimaryColor,),
                      ),
                      state is LoginFailure ? Center(
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
                    'لا تمتلك حساباً؟ ',
                    style: AppStyles.bodySmall,
                  ),
                  TextButton(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.register);
                      },
                      child: Text(
                        'تسجيل حساب جديد',
                        style: AppStyles.bodySmall.copyWith(
                          color: kPrimaryColor,
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
