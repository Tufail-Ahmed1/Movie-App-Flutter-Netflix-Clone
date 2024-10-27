import 'package:flutter/material.dart';
import 'package:movie_app/common/utlis.dart';
import 'package:movie_app/models/upcoming_movies_model.dart';

class MovieCard extends StatelessWidget {

  const MovieCard({super.key, required this.future,required this.titleHeading});

  final Future<UpcomingMoviesModel>? future;
  final String titleHeading;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            var data = snapshot.data?.results;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titleHeading,style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: data!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.network(
                            '$imageUrl${data[index].posterPath}'),
                      );
                    },
                  ),
                )
              ],
            );
          }
          else
            {
              return const Center(
                child:  SizedBox(
                  child: CircularProgressIndicator(),
                ),
              );
            }
        },
    );
  }
}
