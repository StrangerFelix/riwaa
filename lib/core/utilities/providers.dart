import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/core/utilities/serviceLocator.dart';
import 'package:riwaa/features/auth/data/repository/authRepo.dart';
import 'package:riwaa/features/auth/presentation/manager/authCubit.dart';
import 'package:riwaa/features/home/data/repositories/homeRepo/homeRepo.dart';
import 'package:riwaa/features/home/presentation/manager/home/homeCubit.dart';
// ignore: depend_on_referenced_packages
import 'package:nested/nested.dart';
List<SingleChildWidget> providers = [
  BlocProvider(create: (context) => AuthCubit(getIt.get<AuthRepository>())),
  BlocProvider(create: (context) => HomeCubit(getIt.get<HomeRepository>())..getHomeData()),
];