// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restclient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  final Dio _dio;
  String baseUrl;

  _RestClient(this._dio) {
    this.baseUrl = 'https://ennotes-ec479.firebaseio.com/en_notes/';
  }

  Future<Response> _request(
      String path,
      String method, {
      Map<String, dynamic> queryParams,
      Map<String, dynamic> headers,
      Map<String, dynamic> data
  }) async {
    Map<String, dynamic> _headers = {
      'Content-Type': 'application/json'
    };
    if (headers != null) {
      _headers.addAll(headers);
    }

    Map<String, dynamic> _queryParameters = {
      'auth': 'hz7ohBZo5Q8GfadPMGqfCDZkbRhwbIKi6tljgUDE'
    };
    if (queryParams != null) {
      _queryParameters.addAll(queryParams);
    }

    Log.apiLogRequest('$baseUrl$path', _headers.toString(), queryParams: _queryParameters.toString(), body: data?.toString() ?? '');

    final Response<dynamic> _result = await _dio.request(
      path,
      queryParameters: _queryParameters,
      options: RequestOptions(
          method: method,
          headers: _headers,
          baseUrl: baseUrl),
      data: data
    );
    return _result;
  }

  @override
  Future<UsersDataResponse> getUsersData(String deviceName) async {
    try {
      final Response<dynamic> _result = await _request(
        'users/$deviceName.json',
        'GET',
      );
      var value = UsersDataResponse.fromJson(_result?.data ?? Map<String, dynamic>());
      Log.apiLogResponse(_result.request.uri.toString(), value?.toJson()?.toString() ?? '', _result.statusCode.toString());
      return value;
    } catch(exception) {
      debugPrint('Parse result body error: ${exception.toString()}');
    }
    return null;
  }

  @override
  Future<UsersDataResponse> putUsersData(String deviceName, UsersDataResponse body) async {
    try {
      final Response<dynamic> _result = await _request(
        'users/$deviceName.json',
        'PUT',
        data: body.toJson()
      );
      var value = UsersDataResponse.fromJson(_result?.data ?? Map<String, dynamic>());
      Log.apiLogResponse(_result.request.uri.toString(), value?.toJson()?.toString() ?? '', _result.statusCode.toString());
      return value;
    } catch(exception) {
      debugPrint('Parse result body error: ${exception.toString()}');
    }
    return null;
  }

}
