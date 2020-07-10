import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

Widget carouselSlider(items) =>SizedBox(
  height: 200,
  child: Carousel(
          boxFit: BoxFit.cover,
          autoplay: true,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1500),
          dotSize: 6.0,
          dotBgColor: Colors.transparent,
          showIndicator: true,
          indicatorBgPadding: 7.0,
          images: items,
    ),
);