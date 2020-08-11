
import 'package:bloc/bloc.dart';
import 'package:en_notes/bloc/home/home_event.dart';
import 'package:en_notes/bloc/home/home_state.dart';
import 'package:en_notes/common/constant.dart';
import 'package:en_notes/model/users_data_response.dart';
import 'package:en_notes/model/word.dart';
import 'package:en_notes/repository/data_repsitory.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => InitHomeState();

  UsersDataResponse usersDataResponse;

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeLoadDataEvent) {
      yield* _fetchUserData();
    }

    if (event is HomeShowLoadingEvent) {
      yield HomeLoadingState(event.isShowing);
    }

    if (event is HomeDeleteItemEvent) {
      yield* _deleteAWord(event.word);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }

  Stream<HomeState> _fetchUserData() async* {
    yield HomeLoadingState(true);
    final response = await DataRepository.getInstance().getUsersData(Constant.test_acc_id, reload: true);
    if (response != null) {
      usersDataResponse = response;
      yield HomeShowUserDataState();
    } else {
      yield HomeLoadDataErrorState('Failed to load data');
    }
    yield HomeLoadingState(false);
  }

  Stream<HomeState> _deleteAWord(Word word) async* {
    yield HomeLoadingState(true);
    final response = await DataRepository.getInstance().deleteAWord(Constant.test_acc_id, word);
    if (response != null) {
      usersDataResponse = response;
      yield HomeShowUserDataState();
    } else {
      yield HomeLoadDataErrorState('Failed to delete data');
    }
    yield HomeLoadingState(false);
  }
}