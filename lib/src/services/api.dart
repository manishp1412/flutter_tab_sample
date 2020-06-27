import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_shows/src/model/Movies_model.dart';
import 'package:my_shows/src/model/popular_movie_model.dart';

String baseUrl = "https://api.themoviedb.org/3/movie/";
String apiKey = "43382edaf02cb3ce16a28178ac7d8708";

Future<Movies> getAllMovies() async
{
    try
    {
      final moviesResponse = await http.get('${baseUrl}upcoming?api_key=$apiKey');
      return Movies.fromJson(json.decode(moviesResponse.body));
    }on Exception catch(e)
    {
      print(e);
    }
}

Future<PopularMovieList> getLatestMovies() async
{
  var data;
    try{
      final responce = await http.get('${baseUrl}popular?api_key=$apiKey');
      data = PopularMovieList.fromJson(json.decode(responce.body));
      return data;
    }on Exception catch(e)
    {
      print(e);
    }
    return data;
}