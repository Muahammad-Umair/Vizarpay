import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virzanpay/Controller/crouse_image.dart';

class CustomCrousel extends StatelessWidget {
  const CustomCrousel({super.key});

  @override
  Widget build(BuildContext context) {
    final crousel = context.watch<CrouselController>().crouselL;
    Size size = MediaQuery.of(context).size;
    return CarouselSlider.builder(
      itemCount: crousel.length,
      itemBuilder: (context, index, realIndex) {
        return Container(
          width: size.width,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(color: Colors.black, offset: Offset(-1, -1)),
          ]),
          child: CachedNetworkImage(
            imageUrl: crousel[index],
            fit: BoxFit.fill,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                const SizedBox(
              height: 30,
              width: 30,
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey,
            ),
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        disableCenter: true,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        aspectRatio: 16 / 8,
        pageSnapping: false,
        // animateToClosest: false,
      ),
    );
  }
}
