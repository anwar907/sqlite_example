import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/models/movie.dart';
import 'package:majootestcase/models/movie_response.dart';

class HomeBlocLoadedScreen extends StatelessWidget {
   final List<Data> data;

  const HomeBlocLoadedScreen({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return movieItemWidget(data[index]);
      },
    ),
    );
  }

  Widget movieItemWidget(Data data){
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)
          )
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: Image.network(data.i.imageUrl),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Text(data.l, textDirection: TextDirection.ltr),
          )
        ],
      ),
    );
  }
}
