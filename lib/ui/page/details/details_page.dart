import 'package:flutter/material.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:majootestcase/ui/extra/loading.dart';
import 'package:majootestcase/ui/widget/card_series.dart';
import 'package:majootestcase/ui/widget/custom_card_widget.dart';

class DetailsPage extends StatefulWidget {
  final List<Data> data;
  DetailsPage(
    this.data,
  );
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: (widget.data.length != null
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) {
                      return CustomListTile(
                        title: "${widget.data[index].l}",
                        leading: NetworkImage(widget.data[index].i.imageUrl),
                        child: Text("${widget.data[index].year}"),
                        traling: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              if (widget.data[index].series != null) {
                                return CardSeries(widget.data[index].series);
                              } else {
                                return LoadingIndicator();
                              }
                            }));
                          },
                          child: widget.data[index].series != null
                              ? Icon(
                                  Icons.local_movies_rounded,
                                  color: Colors.green,
                                )
                              : Icon(Icons.local_movies_rounded),
                        ),
                        onTap: () {},
                      );
                    })
                : LoadingIndicator())));
  }
}
