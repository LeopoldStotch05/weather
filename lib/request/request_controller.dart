import 'package:dio/dio.dart';
import 'request_model.dart';

class RequestController {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: 10000,
    receiveTimeout: 10000,
    sendTimeout: 10000,
    responseType: ResponseType.plain,
  ));

  Future<Response> sendRequest(RequestModel requestModel) async {
    Response response;
    try {
      response = await _sendRequest(_dio, requestModel);
    } on DioError catch (error) {
      response = error.response;
    }
    return response;
  }

  Future<Response> _sendRequest(Dio dio, RequestModel requestModel) async {
    switch (requestModel.method) {
      case HttpMethod.getMethod:
        return await dio.get(requestModel.uri, options: requestModel.options, queryParameters: requestModel.queryParameters);
      case HttpMethod.postMethod:
        return await dio.post(requestModel.uri,
            data: requestModel.body, options: requestModel.options, queryParameters: requestModel.queryParameters);
      default:
        throw ArgumentError('Unknown HTTP method ${requestModel.method}');
    }
  }
}
