import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/detail_movie_model.dart';
import 'package:movie_app/models/recommanded_movies_model.dart';
import 'package:movie_app/services/api_services.dart';

import '../common/utlis.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key,required this.movieId});

  final int movieId;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<DetailMovieModel> detailFuture;
  late Future<RecommandedMovieModel> recommandedFuture;

  ApiServices apiServices=ApiServices();

  @override
  void initState() {

    super.initState();
    fetchData();
  }
  fetchData() {
    detailFuture=apiServices.getMovieDetailModel(widget.movieId);
    recommandedFuture=apiServices.getRecommendationModel(widget.movieId);

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: detailFuture,
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                final movie=snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage('$imageUrl${movie!.backdropPath}'),
                          fit: BoxFit.fill,

                        )
                      ),
                      child: IconButton(
                        alignment: Alignment.centerLeft,
                          onPressed: () {
                          Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back,color: Colors.white,)),
                    ),
                    const SizedBox(height: 10),
                    Text(movie.title,
                      style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(movie.releaseDate.year.toString(),
                          style: const TextStyle(
                          color: Colors.grey,
                        ),),
                        const SizedBox(width: 20,),
                         Text(movie.genres[0].name,
                           style: const TextStyle(color: Colors.grey),),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Text(movie.overview,
                      maxLines: 4,
                      overflow:TextOverflow.ellipsis,
                      style: const TextStyle(
                      color: Colors.grey,
                    ),),
                    const  SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('More Like This', style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                        const SizedBox(height: 10,),
                        FutureBuilder(
                            future: recommandedFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final recmovies = snapshot.data;
                                return recmovies!.results.isEmpty? const SizedBox.shrink():
                                Column(
                                  children: [
                                    GridView.builder(
                                      itemCount: recmovies.results.length,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 1.5 / 2,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 5),
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return CachedNetworkImage(imageUrl: '$imageUrl${recmovies.results[index].posterPath}');
                                      },
                                    ),
                                  ],
                                );
                              }
                              else {
                                return const SizedBox(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }
                        ),
                      ],
                    ),
                  ],
                );
              }
              else
                {
                  return const SizedBox();
                }
          
            }
          ),
        ),
      ),
    );
  }
}
