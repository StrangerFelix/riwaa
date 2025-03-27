import 'package:riwaa/features/home/data/models/homeModel.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}
class HomeLoading extends HomeStates {}
class HomeLoaded extends HomeStates {
  final HomeModel homeModel;
  HomeLoaded(this.homeModel);
}
class HomeFailure extends HomeStates {
  final String error;
  HomeFailure(this.error);
}