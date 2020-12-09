import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/request/request_model.dart';

import '../request/request_controller.dart';

abstract class Repository {
  void init();

  @protected
  Future<Response> sendRequest(RequestModel requestModel) => GetIt.instance.get<RequestController>().sendRequest(requestModel);
}
