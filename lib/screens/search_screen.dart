import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/recommanded_movies_model.dart';
import 'package:movie_app/models/search_movies_model.dart';
import 'package:movie_app/screens/details_screen.dart';
import 'package:movie_app/services/api_services.dart';

import '../common/utlis.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});


  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  ApiServices apiServices = ApiServices();
  SearchMoviesModel? searchMoviesModel;

  late Future<RecommandedMovieModel> popularMovies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    popularMovies = apiServices.getRecommandedModel();
  }

  void search(String query) {
    apiServices.getSearchMovieModel(query).then(
      (results) {
        setState(() {
          searchMoviesModel = results;
        });
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CupertinoSearchTextField(
                controller: searchController,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  if (value.isEmpty) {}
                  return search(searchController.text);
                },
              ),
              searchController.text.isEmpty
                  ? FutureBuilder(
                      future: popularMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data?.results;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              const Text(
                                'Popular Movies',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: data!.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                          DetailsScreen(movieId: data[index].id,),));
                                    },
                                    child: Container(
                                      height: 150,
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.network(
                                              '$imageUrl${data[index].posterPath}'),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            data[index].title.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          );
                        } else {
                          return const Center(
                            child:  SizedBox(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    )
                  : searchMoviesModel == null
                      ? const SizedBox.shrink()
                      : GridView.builder(
                          itemCount: searchMoviesModel!.results.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1.5 / 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 5),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    DetailsScreen(movieId: searchMoviesModel!.results[index].id,),));
                              },
                              child: Column(
                                children: [
                                  searchMoviesModel!.results[index].backdropPath==null?
                                  Image.asset('assets/netflixLogo.png',height: 80,):
                                  Expanded(
                                    child: CachedNetworkImage(
                                      imageUrl: '$imageUrl${searchMoviesModel!.results[index].backdropPath}',
                                      fit: BoxFit.cover,
                                      //height: 170,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      searchMoviesModel!
                                          .results[index].originalTitle,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
