import 'package:flutter_test/flutter_test.dart';
import 'package:majootestcase/data/controller/api_service.dart';

void main() {
  test("HASIL REQUESTNYA ADALAH..", () async {
    var data = await ApiServices().getMovieList();
    print(data.data[0].series[0].i.height);
  });

  // test("HASIL REQUEST DARI SERIES", () async {
  //   var data = await ApiServices().getMovieSeries();
  //   print("${data.series[0].i.height}");
  // });
}
