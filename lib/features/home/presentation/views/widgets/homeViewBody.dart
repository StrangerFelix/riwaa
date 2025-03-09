import 'package:flutter/material.dart';
import 'package:riwaa/features/home/presentation/views/widgets/homeAppBar.dart';
import 'package:riwaa/features/home/presentation/views/widgets/myPlants/myPlantsBody.dart';
import 'package:riwaa/features/home/presentation/views/widgets/weather/weatherBody.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + 10,
          ),
          const HomeAppBar(),
          const SizedBox(height: 30,),
          const MyPlantsBody(),
          const SizedBox(height: 20,),
          const WeatherBody()
        ],
      ),
    );
  }
}