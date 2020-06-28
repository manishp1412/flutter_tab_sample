import 'package:flutter/material.dart';
import 'package:my_shows/src/model/Movies_model.dart';
import 'package:my_shows/src/services/api.dart';
import 'package:my_shows/src/ui/PopuularMovies.dart';
import 'package:my_shows/src/utils/constants.dart';
import 'package:my_shows/src/ui/styles.dart';

class AllMovies extends StatefulWidget {
  AllMovies(this.title);
  final String title;
  _AllMoviesState createState() => _AllMoviesState();
}

class _AllMoviesState extends State<AllMovies> {
  Future<Movies> listMovies;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listMovies = getAllMovies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Constants.ThemeColor),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(Constants.ThemeBgColor),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        color: Color(Constants.ThemeColor),
        child: FutureBuilder<Movies>(
          future: listMovies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return Container(
                color: Color(Constants.ThemeColor),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    var resultData = snapshot.data.results;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                              "Upcoming Movies",
                              style: Styles.headerStyles,
                            ),
                            FlatButton(
                              child: Text("View All",style: Styles.listTextStyle,),                              
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context)=>new PopularMovies("All Movies")
                                ));
                              },
                            )
                            ],
                          ),
                          padding: EdgeInsets.all(5.0),
                        ),
                        Container(
                          height: 300,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: resultData.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  width: 120,
                                  height: 200,
                                  margin: EdgeInsets.all(10.0),
                                  padding: EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                            '${Constants.PosterUrl}${resultData[index].posterPath}',
                                            fit: BoxFit.contain,
                                            width: 100,
                                            height: 150,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            resultData[index].title,
                                            textAlign: TextAlign.left,
                                            style: Styles.titleStyles,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      //displayAlert(context);
                                    },
                                  ));
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            else if(snapshot.hasError)
            {
              return Center(
                child: Text("No data found"),
              );
            }
              return Center(
                child: CircularProgressIndicator(backgroundColor: Color(Constants.ThemeBgColor),),
              );
          },
        ),
      ),
    );
  }

  displayAlert(BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text("Alert"),
          );
        });
  }
}
