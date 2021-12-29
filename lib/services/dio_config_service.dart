import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio dioInstance;
createInstance() async {
  var options = BaseOptions(
      baseUrl: "https://imdb8.p.rapidapi.com/auto-complete?q=game%20of%20thr",
      connectTimeout: 10000,
      receiveTimeout: 10000,
      headers: {
        "x-rapidapi-key": "a3599a5e1cmshbe0d46373b97767p104511jsn962a7b024b09",
        "x-rapidapi-host": "imdb8.p.rapidapi.com"
      });
  dioInstance = new Dio(options);
  dioInstance.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90));
}

Future<Dio> dio() async {
  await createInstance();
  dioInstance.options.baseUrl =
      "https://imdb8.p.rapidapi.com/auto-complete?q=game%20of%20thr";
  return dioInstance;
}
