import 'package:en_notes/model/word.dart';
import 'dao.dart';

class WordDao implements Dao<Word> {
  final String tableName = "words_table";
  final id = "id";
  final String _colKey = "key";
  final String _colValue = "value";

  @override
  String get createTableQuery =>
      "CREATE TABLE $tableName($id INTEGER PRIMARY KEY autoincrement,"
          " $_colKey TEXT,"
          " $_colValue TEXT)";

  @override
  List<Word> fromList(List<Map<String, dynamic>> query) {
    return query.map((e) => Word.fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toMap(Word word) {
    return <String, dynamic>{
      id: word.id,
      _colKey : word.key,
      _colValue : word.value,
    };
  }

  @override
  Word fromMap(Map<String, dynamic > query) {
    return Word.fromJson(query);
  }
}