import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/core/utilities/serviceLocator.dart';
import 'package:riwaa/features/auth/data/repository/authRepo.dart';
import 'package:riwaa/features/auth/presentation/manager/authCubit.dart';
import 'package:riwaa/features/home/data/repositories/homeRepo.dart';
import 'package:riwaa/features/home/data/repositories/plantDetailsRepo.dart';
import 'package:riwaa/features/home/presentation/manager/home/homeCubit.dart';
// ignore: depend_on_referenced_packages
import 'package:nested/nested.dart';
import 'package:riwaa/features/home/presentation/manager/plantDetails/plantDetailsCubit.dart';
List<SingleChildWidget> providers = [
  BlocProvider(create: (context) => AuthCubit(getIt.get<AuthRepository>())),
  BlocProvider(create: (context) => HomeCubit(getIt.get<HomeRepository>())..getHomeData()),
  BlocProvider(create: (context) => PlantDetailsCubit(getIt.get<PlantDetailsRepository>()),)
];