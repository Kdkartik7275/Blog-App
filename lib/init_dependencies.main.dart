part of 'init_dependencies.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  _initBlog();

  sl.registerFactory(() => InternetConnection());

  // core

  sl.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      sl(),
    ),
  );

  sl.registerFactory<Client>(() => Client());

  // Database Instance

  sl.registerFactory(() => DatabaseHelper.instance);
}

void _initBlog() {
  // Data Source

  sl
    ..registerFactory<BlogLocalDataSource>(() => BlogLocalDataSourceImpl(sl()))
    ..registerFactory<BlogRemoteDataSource>(
        () => BlogRemoteDataSourceImpl(client: sl()))

    // Repository

    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
        remoteDataSource: sl(), localDataSource: sl(), connectionChecker: sl()))

    // UseCases

    ..registerFactory(() => FetchBlogs(repository: sl()))
    ..registerFactory(() => AddBlogToFav(repository: sl()))
    ..registerFactory(() => FetchFavouriteBlogs(repository: sl()))

    // Bloc
    ..registerLazySingleton(() =>
        BlogBloc(fetchBlogs: sl(), addBlogToFav: sl(), favouriteBlogs: sl()));
}
