import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/utlis.dart';
import 'package:movie_app/models/top_rate_series_model.dart';

class CustomCurousel extends StatelessWidget {
  const CustomCurousel({super.key, required this.data});
  final TopRateSeriesModel data;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenWidth > 600 ? 400 : 250,
      child: CarouselSlider.builder(
        itemCount: data.results.length,
        itemBuilder: (context, index, realIndex) {
          var url = data.results[index].backdropPath.toString();
          return Column(
            children: [
              GestureDetector(
                child: CachedNetworkImage(imageUrl: '$imageUrl$url',
                  fit: BoxFit.cover,
                  width: screenWidth > 600 ? 400 : 270,
                ),

              ),
              Text(data.results[index].name,
              style: TextStyle(
                //fontSize: 14,
                fontSize: screenWidth > 600 ? 20 : 14,
                fontWeight: FontWeight.bold,
              ),
              ),
            ],
          );
        },
        options: CarouselOptions(
          //height: 300,
          //height: screenWidth > 600 ? 300 : 200,
          aspectRatio: 16 / 9,
          initialPage: 0,
         //enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
         autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          enlargeCenterPage: true,
          //enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
