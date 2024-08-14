import 'package:blog/core/utils/routes/route_name.dart';
import 'package:blog/src/blog/presentation/pages/blogs_view.dart';
import 'package:blog/src/blog/presentation/pages/detailed_blog_view.dart';
import 'package:blog/src/blog/presentation/pages/favourite_blogs_view.dart';

class AppRoutes {
  static final pages = {
    TRouteName.blogs: (context) => const BlogsView(),
    TRouteName.detailedBlog: (context) => const DetailedBlogView(),
    TRouteName.favourites: (context) => const FavouriteBlogsView(),
  };
}
