import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:majootestcase/utils/url_list.dart';

class NetworkHelper {
  final Dio _client = Dio(BaseOptions(
    baseUrl: UrlList.baseUrl,
    receiveTimeout: 10000,
    sendTimeout: 10000,
    contentType: Headers.formUrlEncodedContentType,
  ));

  Future<T> get<T>({
    @required String path,
    @required T Function(dynamic data) onSuccess,
    @required T Function(dynamic error) onError,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
    bool isRawResult = false,
  }) async {
    try {
      final response = await _client.get(path,
          options: Options(headers: headers), queryParameters: queryParameters);

      return isRawResult
          ? onSuccess(response.data)
          : onSuccess(response.data['d']);
    } on DioError catch (e) {
      log('${e.message} for ${UrlList.baseUrl}$path');
      return onError(e);
    } catch (e) {
      log(e.toString());
      return onError(e);
    }
  }
}
