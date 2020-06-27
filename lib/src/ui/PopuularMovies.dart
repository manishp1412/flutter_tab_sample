import 'package:flutter/material.dart';
import 'package:my_shows/src/model/popular_movie_model.dart';
import 'package:my_shows/src/services/api.dart';
import 'package:my_shows/src/ui/movie_detail.dart';
import 'package:my_shows/src/ui/styles.dart';
import 'package:my_shows/src/utils/constants.dart';

class PopularMovies extends StatefulWidget {
  PopularMovies(this.title);
  final String title;
  _PopularMoviesState createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  List<DetailResult> filterlist = new List<DetailResult>();
  List<DetailResult> movieList = new List<DetailResult>();
  Widget appbarTitle = new Text("Popular Movies");
  Icon actionIcon = Icon(Icons.search);
  TextEditingController searchQuery  = new TextEditingController();
  bool isSearch;
  String searchText;
  @override
  void initState() { 
    super.initState();
    isSearch = false;
    searchText = "";
  }
  _PopularMoviesState(){
    searchQuery.addListener((){
      setState(() {
       if(searchQuery.text.isEmpty)
        {
          setState(() {
            isSearch = false;
            searchText ="";
          });          
        } 
        else{
          setState(() {
            isSearch = true;
            searchText = searchQuery.text;
          });          
        }
      });
    });
  }
  List<DetailResult> getSearchList(){
    filterlist.clear();
    var listMovies = movieList;
    if(searchText.isEmpty)
      return listMovies;
    else
    {
      for(int i=0;i<listMovies.length;i++)
      {
        String movieTitle = listMovies[i].title;
        if(movieTitle.toLowerCase().contains(searchText.toLowerCase()))
          filterlist.add(listMovies[i]);
      }
      return filterlist;
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Color(Constants.ThemeColor),
      appBar: AppBar(
        title: appbarTitle,
        backgroundColor: Color(Constants.ThemeBgColor),
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: (){
              setState(() {
               if(this.actionIcon.icon == Icons.search)
              {
                this.actionIcon = Icon(Icons.close);
                appbarTitle = Theme(
                  data: theme.copyWith(primaryColor: Colors.white),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(Constants.ThemeColor),
                      borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    child: TextField(              
                      style: Styles.listTextStyle,
                      controller: searchQuery,
                      decoration: new InputDecoration( 
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search,color: Colors.white,),               
                        hintText: 'search..',
                        hintStyle: TextStyle(color: Colors.white,fontSize: 14),                              
                      ),
                      ),
                  ),
                );
                handleSearchStart();
              }
              else
              {
                handleSearchEnd();
              } 
              });
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        color: Color(Constants.ThemeColor),
        child: FutureBuilder<PopularMovieList>(
          future: getLatestMovies(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              movieList = snapshot.data.results;
              var resultData = isSearch ? getSearchList() : movieList;
              return Container(
                child: ListView.builder(
                  itemCount: resultData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Row(                          
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                '${Constants.PosterUrl}${resultData[index].posterPath}',
                                fit: BoxFit.contain,
                                width: 100,
                                height: 150,
                              ),
                            ),
                            Flexible(
                              child: Container(   
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    setRowText("Title : " + resultData[index].title,),
                                    setRowText("Release Date : " +
                                            Constants.dateFromat.format(
                                                resultData[index].releaseDate),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new MovieDetail(
                                      "Overview", resultData[index])));
                        },
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator()
              );
            }
          },
        ),
      ),
    );
  }
  Widget setRowText(String text)
  {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Text(text,
        style: Styles.listTextStyle,
      ),
    );
  }
  void handleSearchStart(){
    setState(() {
     isSearch = true; 
    });
  }
  void handleSearchEnd(){
    setState(() {
     this.actionIcon = Icon(Icons.search);
      appbarTitle = new Text("Popular Movies");
      isSearch = false;
      searchQuery.clear(); 
    });
  }
}
