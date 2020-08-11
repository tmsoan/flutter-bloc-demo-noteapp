import 'package:en_notes/model/word.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AddWordEvent {}

class AddShowLoadingEvent extends AddWordEvent {
  bool isShowing;
  AddShowLoadingEvent(this.isShowing);
}

class AddNewItemEvent extends AddWordEvent {
  Word word;
  AddNewItemEvent(this.word);
}