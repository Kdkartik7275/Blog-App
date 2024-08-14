part of 'blog_bloc.dart';

abstract class BlogEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BlogFetchAllBlogs extends BlogEvent {}

class BlogFetchFavouriteBlogs extends BlogEvent {}

class BlogAddToFavorites extends BlogEvent {
  final BlogEntity blog;

  BlogAddToFavorites(this.blog);

  @override
  List<Object?> get props => [blog];
}

class BlogLoadMore extends BlogEvent {}
