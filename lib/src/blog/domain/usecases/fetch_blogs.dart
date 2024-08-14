import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/core/utils/constants/typedefs.dart';
import 'package:blog/src/blog/domain/entity/blog_entity.dart';
import 'package:blog/src/blog/domain/repository/blog_repository.dart';

class FetchBlogs implements UseCaseWithoutParams<List<BlogEntity>> {
  final BlogRepository repository;

  FetchBlogs({required this.repository});
  @override
  ResultFuture<List<BlogEntity>> call() async {
    return await repository.fetchBlogs();
  }
}
