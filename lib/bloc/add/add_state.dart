import 'package:meta/meta.dart';

@immutable
abstract class AddWordState {}

class InitAddState extends AddWordState {}

class AddShowLoadingState extends AddWordState {
  final bool isShowLoading;

  AddShowLoadingState(this.isShowLoading);
}

class AddNewWordSuccessState extends AddWordState {}

class AddErrorState extends AddWordState {
  final String error;

  AddErrorState(this.error);
}