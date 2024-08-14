// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog/core/components/layout/list_layout.dart';
import 'package:blog/src/blog/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:blog/core/components/indicators/indicators.dart';
import 'package:blog/src/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog/src/blog/presentation/widgets/blog_widget.dart';

class BlogsView extends StatelessWidget {
  const BlogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {},
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
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      BlogsList(state: state),
                    ],
                  ),
                ),
              );

            case BlogFailure():
              return Center(
                child: Text(state.message),
              );

            default:
              return const SizedBox();
          }
        },
        buildWhen: (previous, current) =>
            current.runtimeType != BlogAddingToFav,
      ),
    );
  }
}

class BlogsList extends StatelessWidget {
  const BlogsList({
    super.key,
    required this.state,
  });
  final BlogsDisplaySuccess state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TListView(
          shrinkWap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.allBlogs.length + 1,
          itemBuilder: (context, index) {
            if (index == state.allBlogs.length) {
              return state.isLoadingMore
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: circularProgress(context),
                    )
                  : const SizedBox();
            }

            final blog = state.allBlogs[index];
            if (index >= state.allBlogs.length - 3 && !state.isLoadingMore) {
              context.read<BlogBloc>().add(BlogLoadMore());
            }

            return BlogWidget(
              blog: blog,
              isFavourite: state.favoriteBlogs.contains(blog),
            );
          },
        ),
      ],
    );
  }
}
