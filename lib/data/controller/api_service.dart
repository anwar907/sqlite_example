import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:majootestcase/data/helper/database-helper.dart';
import 'package:majootestcase/data/helper/network_helper.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/services/dio_config_service.dart' as dioConfig;
import 'package:majootestcase/utils/url_list.dart';

class ApiServices {
  NetworkHelper helper = NetworkHelper();
  Future<MovieResponse> getMovieList() async {
    try {
      var dio = await dioConfig.dio();
      Response<String> response = await dio.get(UrlList.baseUrl + UrlList.path);
      MovieResponse movieResponse =
          MovieResponse.fromJson(jsonDecode(response.data));
      return movieResponse;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Data> getMovieSeries() async {
    try {
      var dio = await dioConfig.dio();
      Response<String> response = await dio.get(UrlList.baseUrl + UrlList.path);
      Data series = Data.fromJson(jsonDecode(response.data));
      return series;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User> login(String email, String password) async {
    var user = new User(email: email, password: password, userName: null);

    var db = new DatabaseHelper();

    var userRetorno = new User(email: null, password: null, userName: null);
    userRetorno = await db.selectUser(user);

    if (userRetorno != null) {
      return new Future.value(
          new User(email: email, password: password, userName: null));
    }
    return userRetorno;
  }
}

ApiServices apiServices = ApiServices();
