import 'package:equatable/equatable.dart';

class BlogPost extends Equatable {
  // ==================== REQUIRED FIELDS ====================
  final String id;
  final String title;
  final String excerpt;
  final String imagePath;
  final List<String> tags;
  final String publishedDate;
  final String readingTime;

  // ==================== OPTIONAL WITH DEFAULTS ====================
  final String category;
  final bool isFeatured;
  final String author;
  final String authorImage;
  final String authorBio;
  final int viewCount;

  // ==================== OPTIONAL (Can be null/empty) ====================
  final String content;
  final String? videoUrl;
  final List<String> contentImages;
  final Map<String, String> authorSocialLinks;

  // ==================== TIMESTAMPS ====================
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPublished;

  const BlogPost({
    // Required
    required this.id,
    required this.title,
    required this.excerpt,
    required this.imagePath,
    required this.tags,
    required this.publishedDate,
    required this.readingTime,

    // Optional with defaults
    this.category = 'Flutter',
    this.isFeatured = false,
    this.author = 'Dolon Kumar',
    this.authorImage = 'assets/home/hero/dolon.png',
    this.authorBio =
        'Flutter Developer | Cross-Platform Expert with 2.6+ years experience building production-ready applications.',
    this.viewCount = 0,

    // Optional (can be empty)
    this.content = '',
    this.videoUrl,
    this.contentImages = const [],
    this.authorSocialLinks = const {
      'github': 'https://github.com/yourusername',
      'linkedin': 'https://linkedin.com/in/yourprofile',
      'twitter': 'https://twitter.com/yourhandle',
    },

    // Timestamps
    required this.createdAt,
    required this.updatedAt,
    this.isPublished = true,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    excerpt,
    imagePath,
    category,
    tags,
    isFeatured,
    author,
    authorImage,
    authorBio,
    publishedDate,
    readingTime,
    viewCount,
    content,
    videoUrl,
    contentImages,
    authorSocialLinks,
    createdAt,
    updatedAt,
    isPublished,
  ];

  BlogPost copyWith({
    String? id,
    String? title,
    String? excerpt,
    String? imagePath,
    String? category,
    List<String>? tags,
    bool? isFeatured,
    String? author,
    String? authorImage,
    String? authorBio,
    String? publishedDate,
    String? readingTime,
    int? viewCount,
    String? content,
    String? videoUrl,
    List<String>? contentImages,
    Map<String, String>? authorSocialLinks,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPublished,
  }) {
    return BlogPost(
      id: id ?? this.id,
      title: title ?? this.title,
      excerpt: excerpt ?? this.excerpt,
      imagePath: imagePath ?? this.imagePath,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      isFeatured: isFeatured ?? this.isFeatured,
      author: author ?? this.author,
      authorImage: authorImage ?? this.authorImage,
      authorBio: authorBio ?? this.authorBio,
      publishedDate: publishedDate ?? this.publishedDate,
      readingTime: readingTime ?? this.readingTime,
      viewCount: viewCount ?? this.viewCount,
      content: content ?? this.content,
      videoUrl: videoUrl ?? this.videoUrl,
      contentImages: contentImages ?? this.contentImages,
      authorSocialLinks: authorSocialLinks ?? this.authorSocialLinks,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPublished: isPublished ?? this.isPublished,
    );
  }
}
