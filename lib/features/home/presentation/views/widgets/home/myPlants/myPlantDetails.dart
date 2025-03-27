import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appStyles.dart';

class MyPlantDetails extends StatelessWidget {
  const MyPlantDetails({this.humidity,this.moisture,this.temperature,super.key});
  final double? moisture;
  final double? temperature;
  final double? humidity;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyPlantDetail(
          title: "رطوبة التربة",
          value: moisture != null && moisture! > -1 ? '${moisture?.toInt()}' : '--',
          image: AppAssets.drop,
        ),
        MyPlantDetail(
          title: "درجة الحرارة",
          value: temperature != null && temperature! > -49 ? '${temperature?.toInt()}' : '--',
          image: AppAssets.temp,
          istemp: true,
        ),
        MyPlantDetail(
          title: "رطوبة الجو",
          value: humidity != null && humidity! > -1 ? '${humidity?.toInt()}' : '--',
          image: AppAssets.sun,
        ),
      ],
    );
  }
}

class MyPlantDetail extends StatelessWidget {
  const MyPlantDetail({this.istemp = false,required this.image,required this.title,required this.value,super.key});
  final String title;
  final String value;
  final String image;
  final bool istemp;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(image,height: 30,),
              const SizedBox(width: 8,),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  "$value${istemp ? '°C' : '%'}",
                  style: AppStyles.title18.copyWith(
                  
                  fontWeight: FontWeight.w500,
                  
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 5,),
          Text(
            title,
            style: AppStyles.bodySmall.copyWith(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.w500
            ),
          )
        ],
      ),
    );
  }
}