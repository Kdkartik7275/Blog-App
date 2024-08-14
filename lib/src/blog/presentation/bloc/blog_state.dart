part of 'blog_bloc.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object?> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogAddingToFav extends BlogState {}

class BlogsDisplaySuccess extends BlogState {
  final List<BlogEntity> allBlogs;
  final List<BlogEntity> favoriteBlogs;
  final bool isLoadingMore;

  const BlogsDisplaySuccess(this.allBlogs, this.favoriteBlogs,
      {this.isLoadingMore = false});

  @override
  List<Object?> get props => [allBlogs, favoriteBlogs, isLoadingMore];
}

class BlogFailure extends BlogState {
  final String message;

  const BlogFailure(this.message);

  @override
  List<Object?> get props => [message];
}
