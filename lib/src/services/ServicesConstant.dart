class ServicesConstant{
    static const String BaseUrl = "https://api.themoviedb.org/3/movie/";
    static const String apiKey = "43382edaf02cb3ce16a28178ac7d8708";

    static const String UpcomingMoviesUrl = "${BaseUrl}upcoming?api_key=$apiKey";
    static const String PopularMoviesUrl = "${BaseUrl}popular?api_key=$apiKey";

}