import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shows/src/model/popular_movie_model.dart';
import 'package:my_shows/src/ui/styles.dart';
import 'package:my_shows/src/utils/constants.dart';

class MovieDetail extends StatelessWidget {
  final String title;
  DetailResult data;
  MovieDetail(this.title, this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        backgroundColor: Color(Constants.ThemeBgColor),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        color: Color(Constants.ThemeColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              data.title,
              style: Styles.headerStyles,
            ),
            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.network(
                      '${Constants.PosterUrl}${data.posterPath}',
                      fit: BoxFit.fill,
                    ),
                    Flexible(
                        child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "OverView : " + data.overview,
                        style: Styles.listTextStyle,
                      ),
                    ))
                  ],
                )),
            Text(
              "Reease Date : " + Constants.dateFromat.format(data.releaseDate),
              style: Styles.listTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
