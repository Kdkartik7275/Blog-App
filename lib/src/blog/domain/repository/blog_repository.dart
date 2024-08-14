import 'package:blog/core/utils/constants/typedefs.dart';
import 'package:blog/src/blog/domain/entity/blog_entity.dart';

abstract interface class BlogRepository {
  ResultFuture<List<BlogEntity>> fetchBlogs();
  ResultFuture<List<BlogEntity>> fetchFavBlogs();
  ResultVoid addBlogToFav(BlogEntity blog);
}
