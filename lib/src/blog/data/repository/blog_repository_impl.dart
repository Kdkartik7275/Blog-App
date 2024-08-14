import 'package:blog/core/errors/api_failure.dart';
import 'package:blog/core/network/connection_checker.dart';
import 'package:blog/core/utils/constants/typedefs.dart';
import 'package:blog/src/blog/data/data_source/local/blog_local_data_source.dart';
import 'package:blog/src/blog/data/data_source/remote/blog_remote_data_source.dart';
import 'package:blog/src/blog/data/model/blog_model.dart';
import 'package:blog/src/blog/domain/entity/blog_entity.dart';
import 'package:blog/src/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource remoteDataSource;
  final BlogLocalDataSource localDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.connectionChecker});
  @override
  ResultFuture<List<BlogEntity>> fetchBlogs() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final blogs = await localDataSource.loadBlogs();
        return right(blogs);
      }
      final blogs = await remoteDataSource.fetchBlogs();
      localDataSource.uploadLocalBlogs(blogs: blogs);
      return right(blogs);
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  @override
  ResultVoid addBlogToFav(BlogEntity blog) async {
    try {
      final blogModel = BlogModel(
        id: blog.id,
        title: blog.title,
        imageURl: blog.imageURl,
      );
      await localDataSource.addBlogToFav(blogModel);
      return right(null); // or right(Void)
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<List<BlogEntity>> fetchFavBlogs() async {
    try {
      final favoriteBlogs = await localDataSource.loadfavouriteBlogs();
      return right(favoriteBlogs);
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }
}
