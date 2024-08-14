import 'dart:convert';

import 'package:blog/core/errors/api_failure.dart';
import 'package:blog/src/blog/data/model/blog_model.dart';
import 'package:http/http.dart' as http;

abstract interface class BlogRemoteDataSource {
  Future<List<BlogModel>> fetchBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final http.Client _client;

  BlogRemoteDataSourceImpl({required http.Client client}) : _client = client;

  @override
  Future<List<BlogModel>> fetchBlogs() async {
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      List<BlogModel> blogs = [];
      final response = await _client.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        final decodedBlogs = jsonDecode(response.body)['blogs'];

        for (var blog in decodedBlogs) {
          blogs.add(BlogModel.fromMap(blog));
        }

        return blogs;
      } else {
        throw ApiFailure(message: response.body);
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
