import 'package:bloc/bloc.dart';
import 'package:en_notes/bloc/add/add_event.dart';
import 'package:en_notes/bloc/add/add_state.dart';
import 'package:en_notes/common/constant.dart';
import 'package:en_notes/model/word.dart';
import 'package:en_notes/repository/data_repsitory.dart';

class AddWordBloc extends Bloc<AddWordEvent, AddWordState> {
  @override
  AddWordState get initialState => InitAddState();

  @override
  Stream<AddWordState> mapEventToState(AddWordEvent event) async* {
    if (event is AddShowLoadingEvent) {
      yield AddShowLoadingState(event.isShowing);
    }

    if (event is AddNewItemEvent) {
      yield* _addNewWordItem(event.word);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }

  Stream<AddWordState> _addNewWordItem(Word word) async* {
    yield AddShowLoadingState(true);
    final response = await DataRepository.getInstance().addNewWord(Constant.test_acc_id, word);
    if (response != null) {
      yield AddNewWordSuccessState();
    } else {
      yield AddErrorState('Failed to add data');
    }
    yield AddShowLoadingState(false);
  }
}