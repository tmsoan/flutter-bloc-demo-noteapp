import 'dart:convert';

import 'package:en_notes/helper/log.dart';
import 'package:en_notes/model/users_data_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'restclient.g.dart';

abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  Future<UsersDataResponse> getUsersData(String deviceName);

  Future<UsersDataResponse> putUsersData(String deviceName, @Body() UsersDataResponse body);
}