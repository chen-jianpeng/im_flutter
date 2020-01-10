import 'dart:io';
import 'package:dio/dio.dart';

Dio init() {
  final dio = new Dio();

  dio.options
    ..baseUrl = "http://10.94.14.65:1337"
    ..connectTimeout = 5000
    ..receiveTimeout = 5000
    ..validateStatus = (int status) {
      return status > 0;
    }
    ..headers = {
      HttpHeaders.userAgentHeader: 'dio',
      'common-header': 'xx',
    };

  dio.interceptors
    ..add(InterceptorsWrapper(
      onRequest: (Options options) {
        // return ds.resolve( Response(data:"xxx"));
        // return ds.reject( DioError(message: "eh"));
        return options;
      },
    ))
    ..add(LogInterceptor(responseBody: false)); //Open log;

  return dio;
}
