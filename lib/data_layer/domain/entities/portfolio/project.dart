import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String id;
  final String title;
  final String category;
  final String description;
  final String imagePath;
  final String tagline;
  final List<String> platforms;
  final List<String> techStack;
  final String? projectUrl;
  final String? caseStudyUrl;

  // Additional Detail Fields
  final String clientName;
  final String launchDate;
  final String challenge;
  final String requirements;
  final String constraints;
  final String solution;
  final List<String> keyFeatures;
  final Map<String, String> results;
  final String clientTestimonial;
  final List<String> galleryImages;
  final String demoVideoUrl;
  final String? liveUrl;
  final String? appStoreUrl;
  final String? playStoreUrl;
  final String githubUrl;

  // Metadata
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPublished;
  final bool isFeatured;
  final int viewCount;

  const Project({
    required this.id,
    required this.title,
    required this.category,
    required this.imagePath,
    this.description = '',
    this.tagline = '',
    this.platforms = const [],
    this.techStack = const [],
    this.projectUrl,
    this.caseStudyUrl,
    this.clientName = '',
    this.launchDate = '',
    this.challenge = '',
    this.requirements = '',
    this.constraints = '',
    this.solution = '',
    this.keyFeatures = const [],
    this.results = const {},
    this.clientTestimonial = '',
    this.galleryImages = const [],
    this.demoVideoUrl = '',
    this.liveUrl,
    this.appStoreUrl,
    this.playStoreUrl,
    this.githubUrl = '',
    required this.createdAt,
    required this.updatedAt,
    this.isPublished = true,
    this.isFeatured = false,
    this.viewCount = 0,
  });

  /// Copy with method
  Project copyWith({
    String? id,
    String? title,
    String? category,
    String? description,
    String? imagePath,
    String? tagline,
    List<String>? platforms,
    List<String>? techStack,
    String? projectUrl,
    String? caseStudyUrl,
    String? clientName,
    String? launchDate,
    String? challenge,
    String? requirements,
    String? constraints,
    String? solution,
    List<String>? keyFeatures,
    Map<String, String>? results,
    String? clientTestimonial,
    List<String>? galleryImages,
    String? demoVideoUrl,
    String? liveUrl,
    String? appStoreUrl,
    String? playStoreUrl,
    String? githubUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPublished,
    bool? isFeatured,
    int? viewCount,
  }) {
    return Project(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      tagline: tagline ?? this.tagline,
      platforms: platforms ?? this.platforms,
      techStack: techStack ?? this.techStack,
      projectUrl: projectUrl ?? this.projectUrl,
      caseStudyUrl: caseStudyUrl ?? this.caseStudyUrl,
      clientName: clientName ?? this.clientName,
      launchDate: launchDate ?? this.launchDate,
      challenge: challenge ?? this.challenge,
      requirements: requirements ?? this.requirements,
      constraints: constraints ?? this.constraints,
      solution: solution ?? this.solution,
      keyFeatures: keyFeatures ?? this.keyFeatures,
      results: results ?? this.results,
      clientTestimonial: clientTestimonial ?? this.clientTestimonial,
      galleryImages: galleryImages ?? this.galleryImages,
      demoVideoUrl: demoVideoUrl ?? this.demoVideoUrl,
      liveUrl: liveUrl ?? this.liveUrl,
      appStoreUrl: appStoreUrl ?? this.appStoreUrl,
      playStoreUrl: playStoreUrl ?? this.playStoreUrl,
      githubUrl: githubUrl ?? this.githubUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPublished: isPublished ?? this.isPublished,
      isFeatured: isFeatured ?? this.isFeatured,
      viewCount: viewCount ?? this.viewCount,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    category,
    imagePath,
    platforms,
    techStack,
    createdAt,
    updatedAt,
    isPublished,
    isFeatured,
    viewCount,
  ];
}
