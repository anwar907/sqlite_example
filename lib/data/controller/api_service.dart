import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:majootestcase/data/helper/database-helper.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/services/dio_config_service.dart' as dioConfig;
import 'package:majootestcase/utils/url_list.dart';

class ApiServices {
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

  Future<User> login(String email, String password) async {
    var db = new DatabaseHelper();
    User user = await db.selectUser(email, password);
    if (user != null) {
      return user;
    }
    return null;
  }
}

ApiServices apiServices = ApiServices();
