import 'package:blog/core/utils/routes/route_name.dart';
import 'package:blog/core/utils/routes/routes.dart';
import 'package:blog/core/utils/theme/theme.dart';
import 'package:blog/init_dependencies.dart';
import 'package:blog/src/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => sl<BlogBloc>()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      title: 'Blog App',
      initialRoute: TRouteName.blogs,
      routes: AppRoutes.pages,
    );
  }
}
