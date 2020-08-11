
import 'base_data_model.dart';

class User extends BaseDataModel {
  String name;
  bool enableNotify;

  User({String name, bool enableNotify}) {
    this.name = name;
    this.enableNotify = enableNotify;
  }

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    enableNotify = json['enable_notify'];
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'enable_notify': enableNotify
  };
}