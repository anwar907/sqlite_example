import 'package:flutter/material.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:majootestcase/ui/page/details/details_page.dart';

class HomeBlocLoadedScreen extends StatelessWidget {
  final List<MovieResponse> data;

  const HomeBlocLoadedScreen({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          if (data.length == null || data == null) {
            return refreshWidget(context);
          } else {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailsPage(data[index].data)));
              },
              child: movieItemWidget(data[index].data[index]),
            );
          }
        },
      ),
      )
    );
  }

  Widget refreshWidget(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.wifi_off),
        ElevatedButton(onPressed: () {}, child: Text("Refresh Button"))
      ],
    );
  }

  Widget movieItemWidget(Data data) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: Image.network("${data.i.imageUrl}"),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Text("${data.l}", textDirection: TextDirection.ltr),
          )
        ],
      ),
    );
  }
}
