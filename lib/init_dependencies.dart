import 'package:blog/core/helpers/database_helper.dart';
import 'package:blog/core/network/connection_checker.dart';
import 'package:blog/src/blog/data/data_source/local/blog_local_data_source.dart';
import 'package:blog/src/blog/data/data_source/remote/blog_remote_data_source.dart';
import 'package:blog/src/blog/data/repository/blog_repository_impl.dart';
import 'package:blog/src/blog/domain/repository/blog_repository.dart';
import 'package:blog/src/blog/domain/usecases/add_fav.dart';
import 'package:blog/src/blog/domain/usecases/favourites_blogs.dart';
import 'package:blog/src/blog/domain/usecases/fetch_blogs.dart';
import 'package:blog/src/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'init_dependencies.main.dart';
