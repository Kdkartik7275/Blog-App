// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog/core/components/effects/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TCachedNetworkImage extends StatelessWidget {
  final String imageURl;
  final double height;
  final double width;
  final BoxFit boxFit;
  final double radius;
  const TCachedNetworkImage({
    super.key,
    required this.imageURl,
    required this.height,
    required this.width,
    this.boxFit = BoxFit.cover,
    this.radius = 100,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageURl,
      fit: boxFit,
      height: height,
      width: width,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          TShimmerEffect(
        height: height,
        width: width,
        radius: radius,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
