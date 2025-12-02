import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String id;
  final String title;
  final String category;
  final String description;
  final String imagePath;
  final String tagline;

  // Additional Detail Fields
  final String clientName;
  final String launchDate;
  final String challenge;
  final String requirements;
  final String constraints;
  final String solution;
  final String clientTestimonial;
  final String demoVideoUrl;
  final String? liveUrl;
  final String? appStoreUrl;
  final String? playStoreUrl;
  final String githubUrl;

  // List Variable
  final List<String> platforms;
  final List<String> techStack;
  final List<String> keyFeatures;
  final Map<String, String> results;
  final List<String> galleryImages;
  final Map<String, dynamic>? solutionSteps;
  final List<Map<String, dynamic>>? techStackExtended;
  final List<Map<String, dynamic>>? keyFeaturesExtended;

  // Metadata
  final bool isPublished;
  final bool isFeatured;
  final int viewCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Project({
    required this.id,
    required this.title,
    required this.category,
    required this.imagePath,
    this.description = '',
    this.tagline = '',
    this.clientName = '',
    this.launchDate = '',
    this.challenge = '',
    this.requirements = '',
    this.constraints = '',
    this.solution = '',
    this.clientTestimonial = '',
    this.demoVideoUrl = '',
    this.liveUrl,
    this.appStoreUrl,
    this.playStoreUrl,
    this.githubUrl = '',
    this.results = const {},
    this.platforms = const [],
    this.techStack = const [],
    this.galleryImages = const [],
    this.keyFeatures = const [],
    this.solutionSteps,
    this.techStackExtended,
    this.keyFeaturesExtended,
    this.isPublished = true,
    this.isFeatured = false,
    this.viewCount = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Copy with method
  Project copyWith({
    String? id,
    String? title,
    String? category,
    String? description,
    String? imagePath,
    String? tagline,
    String? projectUrl,
    String? caseStudyUrl,
    String? clientName,
    String? launchDate,
    String? challenge,
    String? requirements,
    String? constraints,
    String? solution,
    String? clientTestimonial,
    String? demoVideoUrl,
    String? liveUrl,
    String? appStoreUrl,
    String? playStoreUrl,
    String? githubUrl,
    List<String>? platforms,
    List<String>? techStack,
    List<String>? keyFeatures,
    List<String>? galleryImages,
    Map<String, String>? results,
    Map<String, dynamic>? solutionSteps,
    List<Map<String, dynamic>>? techStackExtended,
    List<Map<String, dynamic>>? keyFeaturesExtended,
    bool? isPublished,
    bool? isFeatured,
    int? viewCount,
    DateTime? createdAt,
    DateTime? updatedAt,
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
      solutionSteps: solutionSteps ?? this.solutionSteps,
      techStackExtended: techStackExtended ?? this.techStackExtended,
      keyFeaturesExtended: keyFeaturesExtended ?? this.keyFeaturesExtended,
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
    solutionSteps,
    techStackExtended,
    keyFeaturesExtended,
  ];
}
