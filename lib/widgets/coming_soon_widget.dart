import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({
    super.key,
    required this.imageUrl,
    required this.overview,
    required this.logoUrl,
    required this.month,
    required this.day,
  });
final String imageUrl;
final String overview;
final String logoUrl;
final String month;
final String day;


@override
  Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  final size = MediaQuery.of(context).size;
    return SizedBox(
      // height: size.width * 0.85,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  month,
                  style: TextStyle(
                      fontSize: screenWidth > 600 ? 24 : 16,
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                Text(day,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth > 600 ? 50 : 40,
                        letterSpacing: 5))
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(imageUrl: imageUrl,
                    fit: BoxFit.cover,
                      height: screenWidth > 600 ? 300 : 150,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.5,
                          height: size.width * 0.2,
                          child: CachedNetworkImage(
                            imageUrl: logoUrl,
                            fit: BoxFit.contain,
                            width: screenWidth > 600 ? 300 : 150,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        const Spacer(),
                        const Column(
                          children: [
                            Icon(
                              Icons.notifications_none_rounded,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Remind Me',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 8),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Column(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Info',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 8),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Coming on $month $day',
                          style: TextStyle(
                              fontSize: screenWidth > 600 ? 20 : 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          overview,
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          style:
                          TextStyle(color: Colors.grey,
                            fontSize: screenWidth > 600 ? 16 : 12.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
