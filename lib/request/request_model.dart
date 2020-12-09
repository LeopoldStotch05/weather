import 'package:dio/dio.dart';

abstract class RequestModel {
  HttpMethod method;
  Options options;
  String uri;
  String body;
  Map<String, dynamic> queryParameters;
}

enum HttpMethod {
  getMethod,
  postMethod,
}
