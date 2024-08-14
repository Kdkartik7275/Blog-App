import 'package:equatable/equatable.dart';

class BlogEntity extends Equatable {
  final String title;
  final String id;
  final String imageURl;

  const BlogEntity(
      {required this.title, required this.id, required this.imageURl});

  @override
  List<Object?> get props => [title, id, imageURl];
}
