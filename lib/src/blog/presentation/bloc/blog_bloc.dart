import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog/src/blog/domain/entity/blog_entity.dart';
import 'package:blog/src/blog/domain/usecases/add_fav.dart';
import 'package:blog/src/blog/domain/usecases/favourites_blogs.dart';
import 'package:blog/src/blog/domain/usecases/fetch_blogs.dart';
import 'package:equatable/equatable.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final FetchBlogs _fetchBlogs;
  final AddBlogToFav _addBlogToFav;
  final FetchFavouriteBlogs _favouriteBlogs;

  List<BlogEntity> _allBlogs = [];
  List<BlogEntity> _favourites = [];
  List<BlogEntity> _visibleBlogs = [];

  int _currentIndex = 0;
  final int _batchSize = 10;

  BlogBloc(
      {required FetchBlogs fetchBlogs,
      required AddBlogToFav addBlogToFav,
      required FetchFavouriteBlogs favouriteBlogs})
      : _fetchBlogs = fetchBlogs,
        _addBlogToFav = addBlogToFav,
        _favouriteBlogs = favouriteBlogs,
        super(BlogInitial()) {
    on<BlogFetchAllBlogs>(_getAllBlogs);
    on<BlogAddToFavorites>(_addToFavorites);
    on<BlogLoadMore>(_loadMoreBlogs);
  }

  FutureOr<void> _getAllBlogs(
      BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    emit(BlogLoading());

    final blogs = await _fetchBlogs();

    blogs.fold((l) {
      emit(BlogFailure(l.message));
      return;
    }, (r) {
      _allBlogs = r;
      _visibleBlogs = _allBlogs.take(_batchSize).toList();
      _currentIndex = _visibleBlogs.length;
    });

    final fav = await _favouriteBlogs();
    fav.fold((l) => emit(BlogFailure(l.message)), (r) {
      _favourites = r;
      emit(BlogsDisplaySuccess(_visibleBlogs, r));
    });
  }

  FutureOr<void> _addToFavorites(
      BlogAddToFavorites event, Emitter<BlogState> emit) async {
    emit(BlogAddingToFav());

    final res = await _addBlogToFav(event.blog);

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (_) {
        if (_favourites.contains(event.blog)) {
          _favourites.remove(event.blog);
        } else {
          _favourites.add(event.blog);
        }
        emit(BlogsDisplaySuccess(_visibleBlogs, _favourites));
      },
    );
  }

  FutureOr<void> _loadMoreBlogs(
      BlogLoadMore event, Emitter<BlogState> emit) async {
    if (_currentIndex >= _allBlogs.length) return;

    emit(BlogsDisplaySuccess(_visibleBlogs, _favourites, isLoadingMore: true));

    final nextBatch = _allBlogs.skip(_currentIndex).take(_batchSize).toList();
    _visibleBlogs.addAll(nextBatch);
    _currentIndex += nextBatch.length;

    emit(BlogsDisplaySuccess(_visibleBlogs, _favourites));
  }
}
