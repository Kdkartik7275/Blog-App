import 'package:blog/core/components/indicators/indicators.dart';
import 'package:blog/core/components/layout/list_layout.dart';
import 'package:blog/src/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog/src/blog/presentation/widgets/blog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class FavouriteBlogsView extends StatelessWidget {
  const FavouriteBlogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                color: Colors.white)),
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        buildWhen: (previous, current) =>
            current.runtimeType != BlogAddingToFav,
        builder: (context, state) {
          switch (state) {
            case BlogLoading():
              return LoadingOverlay(
                opacity: 0,
                isLoading: true,
                progressIndicator: circularProgress(context),
                child: const SizedBox(),
              );

            case BlogsDisplaySuccess():
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TListView(
                    itemCount: state.favoriteBlogs.length,
                    itemBuilder: (_, index) {
                      final blog = state.favoriteBlogs[index];
                      return BlogWidget(
                        blog: blog,
                        isFavourite: state.favoriteBlogs.contains(blog),
                      );
                    }),
              );

            case BlogFailure():
              return Center(
                child: Text(state.message),
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
