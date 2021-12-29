import 'package:flutter/material.dart';
import 'package:majootestcase/models/movie_response.dart';

class CardSeries extends StatelessWidget {
  final List<Series> listSeries;
  CardSeries(this.listSeries);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            itemCount: listSeries.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          height: 120,
                          width: 100,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 10.0,
                                    offset: Offset(0.0, 5.0))
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      listSeries[index].i.imageUrl)),
                              color: Color(0xFFF9F9F9),
                              borderRadius:
                                  BorderRadiusDirectional.circular(10.0)),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              listSeries[index].l,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]);
            }));
  }
}
