import 'package:en_notes/model/users_data_response.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState {}

class InitHomeState extends HomeState {}

class HomeLoadingState extends HomeState {
  final bool isShowLoading;

  HomeLoadingState(this.isShowLoading);
}

class HomeShowUserDataState extends HomeState {}

class HomeLoadDataErrorState extends HomeState {
  final String error;

  HomeLoadDataErrorState(this.error);
}