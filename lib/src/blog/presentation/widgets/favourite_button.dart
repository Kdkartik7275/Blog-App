import 'package:blog/src/blog/domain/entity/blog_entity.dart';
import 'package:blog/src/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({
    super.key,
   required this.blog
  });

  final BlogEntity blog;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogBloc, BlogState>(
      buildWhen: (previous,current) => current != BlogAddingToFav(),
      builder: (context, state) {

        final isFavourite = (state as BlogsDisplaySuccess).favoriteBlogs.contains(blog);

        return Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isFavourite ? Colors.white : Colors.transparent),
          child: IconButton(
              onPressed: () => context.read<BlogBloc>().add(BlogAddToFavorites(blog)),
              icon: Icon(
                Icons.favorite,
                size: 25,
                color: isFavourite ? Colors.red : Colors.grey,
              )),
        );
      },
    );
  }
}
