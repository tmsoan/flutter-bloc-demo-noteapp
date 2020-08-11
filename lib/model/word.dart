
import 'base_data_model.dart';

class Word extends BaseDataModel {
  String key;
  String value;

  Word({String key, String value}) {
    this.key = key;
    this.value = value;
  }

  Word.fromJson(Map<String, dynamic> json) {
    key = json['key'] as String;
    value = json['value'] as String;
  }

  Map<String, dynamic> toJson() => {
    'key': key,
    'value': value
  };
}