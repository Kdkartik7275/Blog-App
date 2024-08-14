import 'package:blog/core/components/images/cached_image.dart';
import 'package:blog/src/blog/presentation/widgets/favourite_button.dart';
import 'package:flutter/material.dart';

import 'package:blog/src/blog/domain/entity/blog_entity.dart';

class DetailedBlogView extends StatelessWidget {
  const DetailedBlogView({
    super.key,
    this.blog,
    this.isFavourite = false,
  });

  final BlogEntity? blog;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(27, 27, 27, 1),
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: 'blog_${blog!.id}',
                child: TCachedNetworkImage(
                  imageURl: blog!.imageURl,
                  height: 250,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 20,
                left: 10,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      size: 30, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    blog!.title,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
                FavouriteButton(blog: blog!)
              ],
            ),
          )
        ],
      ),
    );
  }
}
