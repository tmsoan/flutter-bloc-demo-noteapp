
import 'package:dio/dio.dart';
import 'package:en_notes/db/database_provider.dart';
import 'package:en_notes/db/word_dao.dart';
import 'package:en_notes/model/user.dart';
import 'package:en_notes/model/users_data_response.dart';
import 'package:en_notes/model/word.dart';
import 'package:en_notes/network/restclient.dart';
import 'package:sqflite/sqflite.dart';

class DataRepository {
  DatabaseProvider _databaseProvider;
  final _wordDao = WordDao();

  final _dio = Dio();
  RestClient _restClient;
  static DataRepository _instance;

  UsersDataResponse _usersDataResponse;
  UsersDataResponse get usersDataResponse => _usersDataResponse;

  static DataRepository getInstance() {
    if (_instance == null) {
      _instance = DataRepository._internal();
    }
    return _instance;
  }

  DataRepository._internal() {
    DatabaseProvider.getInstance().then((dbp) {
      _databaseProvider = dbp;
      _getDB(); // open DB first
    });
    _restClient = RestClient(_dio);
  }

  Future<Database> _getDB() async {
    return await _databaseProvider.db();
  }


  Future<UsersDataResponse> getUsersData(String deviceName, {bool reload}) async {
    if (reload == true || _usersDataResponse == null) {
      _usersDataResponse = await _restClient.getUsersData(deviceName);
    }
    return _usersDataResponse;
  }

  Future<UsersDataResponse> addNewWord(String deviceName, Word word) async {
    if (_usersDataResponse != null) {
      if (_usersDataResponse.words == null) {
        _usersDataResponse.words = List();
      }
    } else {
      _usersDataResponse = UsersDataResponse();
      _usersDataResponse.words = List();
    }
    _usersDataResponse.user = User(name: "Soan Trinh", enableNotify: true);
    _usersDataResponse.words.add(word);

    _usersDataResponse = await _restClient.putUsersData(deviceName, _usersDataResponse);
    return _usersDataResponse;
  }

  Future<UsersDataResponse> deleteAWord(String deviceName, Word word) async {
    if (_usersDataResponse == null || _usersDataResponse.words == null) {
      return _usersDataResponse;
    }
    List<Word> tmpLst = List();
    _usersDataResponse.words.forEach((element) {
      if (word.key != element.key || word.value != element.value) {
        tmpLst.add(element);
      }
    });
    final data = UsersDataResponse(user: _usersDataResponse.user);
    data.words = tmpLst;

    _usersDataResponse = await _restClient.putUsersData(deviceName, data);
    return _usersDataResponse;
  }
}