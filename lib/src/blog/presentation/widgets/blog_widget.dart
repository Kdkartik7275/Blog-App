// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog/core/components/images/cached_image.dart';
import 'package:blog/src/blog/presentation/pages/detailed_blog_view.dart';
import 'package:blog/src/blog/presentation/widgets/favourite_button.dart';
import 'package:flutter/material.dart';

import 'package:blog/src/blog/domain/entity/blog_entity.dart';

class BlogWidget extends StatelessWidget {
  const BlogWidget({
    super.key,
    required this.blog,
    required this.isFavourite,
  });

  final BlogEntity blog;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 500),
              barrierDismissible: true,
              pageBuilder: (context, animation, secondayAnimation) =>
                  FadeTransition(
                      opacity: animation,
                      child: DetailedBlogView(
                        blog: blog,
                        isFavourite: isFavourite,
                      ))));
        },
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // BLOG IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Hero(
                      tag: 'blog_${blog.id}',
                      child: TCachedNetworkImage(
                        imageURl: blog.imageURl,
                        height: 200,
                        width: double.infinity,
                        radius: 10,
                      ),
                    ),
                  ),

                  // ADD TO FAVOURITE BUTTON
                  Positioned(
                    right: 10,
                    top: 10,
                    child: FavouriteButton(blog: blog),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8, right: 10),
                child: Text(
                  blog.title,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
