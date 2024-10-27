import 'dart:convert';
import 'package:movie_app/common/utlis.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/now_playing_model.dart';
import 'package:movie_app/models/recommanded_movies_model.dart';
import 'package:movie_app/models/search_movies_model.dart';
import 'package:movie_app/models/top_rate_series_model.dart';
import 'package:movie_app/models/upcoming_movies_model.dart';

import '../models/detail_movie_model.dart';

const baseUrl='https://api.themoviedb.org/3/';
var key='?api_key=$apikey';
late String endPoint;


class ApiServices {

  Future<UpcomingMoviesModel> getUpcomingMovie() async {
    endPoint='movie/upcoming';
    final url='$baseUrl$endPoint$key';
    http.Response response= await http.get(Uri.parse(url));

    if(response.statusCode==200)
      {
        return UpcomingMoviesModel.fromJson(json.decode(response.body));

      }
    throw Exception('failed to Upcoming Movies');
  }

  Future<NowPlayingModel> getNowPlayingModel() async {
    endPoint = 'movie/now_playing';
    final url = '$baseUrl$endPoint$key';

    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = response.body;
      return NowPlayingModel.fromJson(json.decode(data));
    }
    else {
      throw Exception('Failed to load Now Playing');
    }
  }
  Future<TopRateSeriesModel> getTopRateSeriesModel() async {
    endPoint = 'tv/top_rated';
    final url = '$baseUrl$endPoint$key';

    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = response.body;
      return TopRateSeriesModel.fromJson(json.decode(data));
    }
    else {
      throw Exception('Failed to load Now Playing');
    }
  }

  Future<SearchMoviesModel> getSearchMovieModel(String searchText) async{
    endPoint='search/movie?query=$searchText';
    final url='$baseUrl$endPoint';
    http.Response response= await http.get(Uri.parse(url),
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZWZkM2NhMjA1OTJhYmRlNTQxZmUyNTBlZTIyZGRlNCIsIm5iZiI6MTcyOTc1MTQzMi4yODMzMjgsInN1YiI6IjY1Mzk0NjcyOGEwZTliMDBlYWZhZDBjNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.STKJ3YkNxzxy_j2BuNIoy0_IS33_z5kmmB6rbDBlWC0'
      }
    );
    if(response.statusCode==200)
      {
        return SearchMoviesModel.fromJson(json.decode(response.body));

      }
    else {
      throw Exception('Failed to search please correct name');
    }
  }

  Future<RecommandedMovieModel> getRecommandedModel() async{
    endPoint='trending/all/day';
    final url='$baseUrl$endPoint$key';
    http.Response response= await http.get(Uri.parse(url),);
    if(response.statusCode==200)
      {

        return RecommandedMovieModel.fromJson(json.decode(response.body));
      }
    else{
      throw Exception('Failed to Loaded Movies');
    }
  }
  Future<DetailMovieModel> getMovieDetailModel(int movieId) async {
    endPoint='movie/$movieId';
    final url='$baseUrl$endPoint$key';
    http.Response response= await http.get(Uri.parse(url));

    if(response.statusCode==200)
      {
        return DetailMovieModel.fromJson(json.decode(response.body));
      }
    else
      {
        throw Exception('Failed to load details');
      }

  }
  Future<RecommandedMovieModel> getRecommendationModel(int movieId) async {
    endPoint='movie/$movieId/recommendations';
    final url='$baseUrl$endPoint$key';
    http.Response response= await http.get(Uri.parse(url));

    if(response.statusCode==200)
    {
      return RecommandedMovieModel.fromJson(json.decode(response.body));
    }
    else
    {
      throw Exception('Failed to load details');
    }

  }

}

