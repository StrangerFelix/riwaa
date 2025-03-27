import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/home/data/models/homeModel.dart';
import 'package:riwaa/features/home/presentation/views/widgets/home/myPlants/addPlantBox.dart';
import 'package:riwaa/features/home/presentation/views/widgets/home/myPlants/myPlantsBox.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class MyPlantsCarousel extends StatefulWidget {
  const MyPlantsCarousel({required this.plants,super.key});
  final List<Plant> plants;
  @override
  State<MyPlantsCarousel> createState() => _MyPlantsCarouselState();
}

class _MyPlantsCarouselState extends State<MyPlantsCarousel> {

  @override
  void initState() {
    super.initState();
  }
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider(
              items: widget.plants.reversed.map<Widget>((plant) {
                return MyPlantsBox(plant: plant,);
              }).toList() + [
                const AddPlantBox()
              ], 
              options: CarouselOptions(
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                aspectRatio: 5/4,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: widget.plants.length + 1,
                effect: const ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: kPrimaryColor,
                  dotHeight: 10.0,
                  expansionFactor: 1.5,
                  dotWidth: 10,
                  spacing: 5
                ),
              ),
            ),
          ],
        ),
      );
  }
}