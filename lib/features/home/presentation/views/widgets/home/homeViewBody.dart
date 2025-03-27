import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/home/presentation/manager/home/homeCubit.dart';
import 'package:riwaa/features/home/presentation/manager/home/homeStates.dart';
import 'package:riwaa/features/home/presentation/views/widgets/home/homeAppBar.dart';
import 'package:riwaa/features/home/presentation/views/widgets/home/myPlants/myPlantsBody.dart';
import 'package:riwaa/features/home/presentation/views/widgets/home/weather/weatherBody.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 80,
      color: kPrimaryColor,
      onRefresh: () async {
        BlocProvider.of<HomeCubit>(context).getHomeData();
      },
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.paddingOf(context).top + 10,
                  ),
                  HomeAppBar(userName: state.homeModel.username,),
                  const SizedBox(
                    height: 30,
                  ),
                  MyPlantsBody(plants: state.homeModel.plants,),
                  const SizedBox(
                    height: 20,
                  ),
                  const WeatherBody()
                ],
              ),
            );
          } else if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            );
          } else {
            return Center(
              child: Text(state is HomeFailure ? state.error : 'حدث خطأ ما'),
            );
          }
        },
      ),
    );
  }
}
