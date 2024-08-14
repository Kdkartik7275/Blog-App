import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/core/utils/constants/typedefs.dart';
import 'package:blog/src/blog/domain/entity/blog_entity.dart';
import 'package:blog/src/blog/domain/repository/blog_repository.dart';

class AddBlogToFav implements UseCaseWithParams<void, BlogEntity> {
  final BlogRepository repository;

  AddBlogToFav({required this.repository});
  @override
  ResultFuture<void> call(BlogEntity blog) async {
    return await repository.addBlogToFav(blog);
  }
}
