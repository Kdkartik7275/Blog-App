import 'package:blog/core/helpers/database_helper.dart';
import 'package:blog/src/blog/data/model/blog_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  Future<List<BlogModel>> loadBlogs();
  Future<List<BlogModel>> loadfavouriteBlogs();
  Future<void> addBlogToFav(BlogModel blog);
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final DatabaseHelper dbHelper;

  BlogLocalDataSourceImpl(this.dbHelper);

  @override
  Future<List<BlogModel>> loadBlogs() async {
    final db = await dbHelper.database;

    final maps = await db.query('blogs');

    if (maps.isEmpty) return [];

    return maps.map((map) => BlogModel.fromMap(map)).toList();
  }

  @override
  Future<void> uploadLocalBlogs({required List<BlogModel> blogs}) async {
    final db = await dbHelper.database;

    await db.transaction((txn) async {
      await txn.delete('blogs');

      for (final blog in blogs) {
        await txn.insert(
          'blogs',
          blog.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  @override
  Future<void> addBlogToFav(BlogModel blog) async {
    final db = await dbHelper.database;

    final existingBlog = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [blog.id],
    );

    if (existingBlog.isNotEmpty) {
      // If blog exists, remove it from favorites
      await db.delete(
        'favorites',
        where: 'id = ?',
        whereArgs: [blog.id],
      );
    } else {
      // If blog does not exist, add it to favorites
      await db.insert(
        'favorites',
        blog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  @override
  Future<List<BlogModel>> loadfavouriteBlogs() async {
    final db = await dbHelper.database;

    final maps = await db.query('favorites');

    if (maps.isEmpty) return [];

    return maps.map((map) => BlogModel.fromMap(map)).toList();
  }
}
