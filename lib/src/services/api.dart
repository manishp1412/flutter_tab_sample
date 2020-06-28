import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_shows/src/model/Movies_model.dart';
import 'package:my_shows/src/model/popular_movie_model.dart';
import 'package:my_shows/src/services/ServicesConstant.dart';

Future<Movies> getAllMovies() async
{
    try
    {
      final response = await http.get(ServicesConstant.UpcomingMoviesUrl);
      if(response.statusCode == 200)
          return Movies.fromJson(json.decode(response.body));
    }on Exception catch(e)
    {
      print(e);
    }
    return null;
}

Future<PopularMovieList> getLatestMovies() async
{
    try{
      final responce = await http.get(ServicesConstant.PopularMoviesUrl);
      if(responce.statusCode == 200)
        return PopularMovieList.fromJson(json.decode(responce.body));
    }on Exception catch(e)
    {
      print(e);
    }
     return null;
}