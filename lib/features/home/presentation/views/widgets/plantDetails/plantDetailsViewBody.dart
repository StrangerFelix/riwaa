import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:riwaa/core/components/svgWithShadow.dart';
import 'package:riwaa/core/utilities/appAssets.dart';
import 'package:riwaa/core/utilities/appRouter.dart';
import 'package:riwaa/core/utilities/appStyles.dart';
import 'package:riwaa/core/utilities/constants.dart';
import 'package:riwaa/features/home/data/models/addPlantDroplist.dart';
import 'package:riwaa/features/home/presentation/manager/plantDetails/plantDetailsBloc.dart';
import 'package:riwaa/features/home/presentation/manager/plantDetails/plantDetailsEvents.dart';
import 'package:riwaa/features/home/presentation/manager/plantDetails/plantDetailsState.dart';
import 'package:riwaa/features/home/presentation/views/widgets/plantDetails/plantDetailImage.dart';
import 'package:riwaa/features/home/presentation/views/widgets/plantDetails/plantDetailItem.dart';
import 'package:riwaa/features/home/presentation/views/widgets/plantDetails/plantTemperature.dart';
import 'package:riwaa/features/home/presentation/views/widgets/plantDetails/waterPlantButton.dart';
import 'package:timeago/timeago.dart' as timeago;

class PlantDetailsViewBody extends StatelessWidget {
  const PlantDetailsViewBody({required this.plantId,super.key});
  final String plantId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantDetailsBloc, PlantDetailsState>(
      builder: (context, state) {
        if (state.status == PlantDetailsStatus.failure) {
          return Center(
            child: Text(
              state.error ?? "حدث خطأ ما",
              style: AppStyles.paragraphMedium.copyWith(
                color: Colors.red,
              ),
            ),
          );
        } else if (state.status == PlantDetailsStatus.loading || state.status == PlantDetailsStatus.deleting) {
          return const Center(child: CircularProgressIndicator(color: kPrimaryColor,),);
        } else {
          return RefreshIndicator(
            displacement: 80,
            color: kPrimaryColor,
            onRefresh: () async {
              BlocProvider.of<PlantDetailsBloc>(context).add(
                GetPlantDetailsEvent(
                  plantId: state.plant?.uId ?? plantId,
                  changed: true
                ),
              );
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: Column(
                  children: [
                    PlantDetailImage(
                      potType: state.plant?.type,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kHorizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Opacity(
                                    opacity: .75,
                                    child: Text(
                                      state.plant?.name ?? "--",
                                      style: AppStyles.titleLarge.copyWith(
                                        shadows: AppStyles.mainTextShadows,
                                        fontSize: 40.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    plantNaming[state.plant?.type ?? 'other'],
                                    style: AppStyles.bodySmall
                                        .copyWith(color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: IconButton(
                                  onPressed: () {
                                    GoRouter.of(context).push(
                                      AppRouter.editPlantDetails,
                                      extra: state.plant
                                    );
                                  },
                                  icon: SvgWithShadow(
                                      child: SvgPicture.asset(AppAssets.edit)),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 2.5,
                            width: MediaQuery.sizeOf(context).width * .9,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20))),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          PlantDetailItem(
                            icon: AppAssets.drop,
                            title: 'رطوبة التربة:',
                            percentage: state.plant?.info?.moisture?.toDouble() ?? -1,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          PlantDetailItem(
                            icon: AppAssets.sun,
                            title: 'رطوبة الجو:',
                            percentage: state.plant?.info?.humidity?.toDouble() ?? -1,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          PlantTemperature(
                            temperature: state.plant?.info?.temperature?.toDouble() ?? -49.0,
                          ),
                          const SizedBox(height: 20,),
                          state.plant?.lastUpdated != null ? SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: Text(
                              'اخر تحديث ${timeago.format(state.plant!.lastUpdated!.toDate(), locale: 'ar')}.',
                              style: AppStyles.bodySmall.copyWith(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ) : const SizedBox(),
                          // const SizedBox(height: 20,),
                          WaterPlantButton(
                            deviceId: state.plant?.uId,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      }
    );
  }
}
