import 'package:en_notes/model/word.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent {}

class HomeShowLoadingEvent extends HomeEvent {
  bool isShowing;
  HomeShowLoadingEvent(this.isShowing);
}

class HomeLoadDataEvent extends HomeEvent {}

class HomeDeleteItemEvent extends HomeEvent {
  Word word;
  HomeDeleteItemEvent(this.word);
}