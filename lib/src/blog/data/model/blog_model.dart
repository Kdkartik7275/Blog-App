import 'package:blog/src/blog/domain/entity/blog_entity.dart';

class BlogModel extends BlogEntity {
  const BlogModel(
      {required super.title, required super.id, required super.imageURl});

  BlogModel copyWith({String? id, String? title, String? imageURl}) {
    return BlogModel(
        title: title ?? this.title,
        id: id ?? this.id,
        imageURl: imageURl ?? this.imageURl);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image_url': imageURl,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
        id: map['id'] ?? '',
        title: map['title'] ?? '',
        imageURl: map['image_url'] ?? '');
  }
}
