import 'package:equatable/equatable.dart';

class BlogPost extends Equatable {
  final String id;
  final String title;
  final String excerpt;
  final String content;
  final String imagePath;
  final String publishedDate;
  final String readingTime;
  final List<String> tags;
  final int viewCount;
  final String authorId;
  final String authorName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPublished;
  final bool isFeatured;

  const BlogPost({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.imagePath,
    required this.publishedDate,
    required this.readingTime,
    required this.tags,
    required this.viewCount,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    required this.updatedAt,
    this.isPublished = true,
    this.isFeatured = false,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    excerpt,
    content,
    imagePath,
    publishedDate,
    readingTime,
    tags,
    viewCount,
    authorId,
    authorName,
    createdAt,
    updatedAt,
    isPublished,
    isFeatured,
  ];

  /// Copy with method for immutability
  BlogPost copyWith({
    String? id,
    String? title,
    String? excerpt,
    String? content,
    String? imagePath,
    String? publishedDate,
    String? readingTime,
    List<String>? tags,
    int? viewCount,
    String? authorId,
    String? authorName,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPublished,
    bool? isFeatured,
  }) {
    return BlogPost(
      id: id ?? this.id,
      title: title ?? this.title,
      excerpt: excerpt ?? this.excerpt,
      content: content ?? this.content,
      imagePath: imagePath ?? this.imagePath,
      publishedDate: publishedDate ?? this.publishedDate,
      readingTime: readingTime ?? this.readingTime,
      tags: tags ?? this.tags,
      viewCount: viewCount ?? this.viewCount,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPublished: isPublished ?? this.isPublished,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
}
