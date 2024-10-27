import 'package:flutter/material.dart';
import 'package:movie_app/models/now_playing_model.dart';
import 'package:movie_app/models/top_rate_series_model.dart';
import 'package:movie_app/models/upcoming_movies_model.dart';
import 'package:movie_app/screens/search_screen.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/widgets/custom_curousel.dart';
import 'package:movie_app/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcomingMoviesModel> upcomingFuture;
  late Future<NowPlayingModel> nowPlayingFuture;
  late Future<TopRateSeriesModel> topRatedFuture;

  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    upcomingFuture = apiServices.getUpcomingMovie();
    nowPlayingFuture=apiServices.getNowPlayingModel();
    topRatedFuture=apiServices.getTopRateSeriesModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.asset(
            "assets/netflixLogo.png",
            height: 50,
            //width: 120,
          ),

          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen(),));
                  }, child: const Icon(Icons.search, color: Colors.white)),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: topRatedFuture,
                  builder: (context, snapshot) {
                    if(snapshot.hasData)
                    { return CustomCurousel(data: snapshot.data!); }
                    else
                      { return const SizedBox.shrink(); }
                  },
              ),
              //SizedBox(height: 10),
              SizedBox(
                height: 220,
                child: MovieCard(titleHeading: 'Now Playing', future: upcomingFuture),
              ),
              const SizedBox(height: 10),
              SizedBox(
                  height: 220,
                  child: MovieCard(
                      titleHeading: 'Upcoming', future: upcomingFuture)),
            ],
          ),
        ));
  }
}
