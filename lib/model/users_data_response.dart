
import 'package:en_notes/model/user.dart';
import 'package:en_notes/model/word.dart';

class UsersDataResponse {
  User user;
  List<Word> words;

  UsersDataResponse({User user, List<Word> words}) {
    this.user = user;
    this.words = words;
  }

  UsersDataResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    words = json['words'] != null ? List<Word>.from(json['words'].map((x) => Word.fromJson(x))) : null;
  }

  Map<String, dynamic> toJson() => {
    'user': user != null ? user.toJson() : null,
    'words': words != null ? List<dynamic>.from(words.map((x) => x.toJson())) : null
  };
}