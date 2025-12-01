import '../../domain/entities/portfolio/project.dart';

class ProjectModel extends Project {
  const ProjectModel({
    required super.id,
    required super.title,
    required super.category,
    required super.imagePath,
    super.description,
    super.tagline,
    super.platforms,
    super.techStack,
    super.projectUrl,
    super.caseStudyUrl,
    super.clientName,
    super.launchDate,
    super.challenge,
    super.requirements,
    super.constraints,
    super.solution,
    super.keyFeatures,
    super.results,
    super.clientTestimonial,
    super.galleryImages,
    super.demoVideoUrl,
    super.liveUrl,
    super.appStoreUrl,
    super.playStoreUrl,
    super.githubUrl,
    required super.createdAt,
    required super.updatedAt,
    super.isPublished,
    super.isFeatured,
    super.viewCount,
  });

  // ==================== SUPABASE METHODS ====================
  factory ProjectModel.fromSupabase(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      title: json['title'] as String,
      tagline: json['tagline'] as String? ?? '',
      imagePath: json['image_path'] as String? ?? '',
      category: json['category'] as String? ?? '',
      clientName: json['client_name'] as String? ?? '',
      launchDate: json['launch_date'] as String? ?? '',
      description: json['description'] as String? ?? '',
      challenge: json['challenge'] as String? ?? '',
      requirements: json['requirements'] as String? ?? '',
      constraints: json['constraints'] as String? ?? '',
      solution: json['solution'] as String? ?? '',
      demoVideoUrl: json['demo_video_url'] as String? ?? '',
      appStoreUrl: json['app_store_url'] as String? ?? '',
      playStoreUrl: json['play_store_url'] as String? ?? '',
      githubUrl: json['github_url'] as String? ?? '',
      isPublished: json['is_published'] as bool? ?? false,
      isFeatured: json['is_featured'] as bool? ?? false,
      viewCount: json['view_count'] as int? ?? 0,
      clientTestimonial: json['client_testimonial'] as String? ?? '',

      // Parse PostgreSQL arrays
      platforms: (json['platforms'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      techStack: (json['tech_stack'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      keyFeatures: (json['key_features'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      galleryImages: (json['gallery_images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      // Parse JSONB results
      results:
          (json['results'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, value.toString())) ??
          {},
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'] as String) : DateTime.now(),
    );
  }

  /// Convert ProjectModel to Supabase JSON
  Map<String, dynamic> toSupabase() {
    return {
      'id': id,
      'title': title,
      'tagline': tagline,
      'image_path': imagePath,
      'platforms': platforms, // PostgreSQL text[] array
      'tech_stack': techStack, // PostgreSQL text[] array
      'category': category,
      'client_name': clientName,
      'launch_date': launchDate,
      'description': description,
      'challenge': challenge,
      'requirements': requirements,
      'constraints': constraints,
      'solution': solution,
      'key_features': keyFeatures, // PostgreSQL text[] array
      'results': results, // PostgreSQL jsonb
      'client_testimonial': clientTestimonial,
      'gallery_images': galleryImages, // PostgreSQL text[] array
      'demo_video_url': demoVideoUrl,
      'app_store_url': appStoreUrl,
      'play_store_url': playStoreUrl,
      'github_url': githubUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_published': isPublished,
      'is_featured': isFeatured,
      'view_count': viewCount,
    };
  }

  /// Create from Entity
  factory ProjectModel.fromEntity(Project project) {
    return ProjectModel(
      id: project.id,
      title: project.title,
      category: project.category,
      imagePath: project.imagePath,
      description: project.description,
      tagline: project.tagline,
      platforms: project.platforms,
      techStack: project.techStack,
      projectUrl: project.projectUrl,
      caseStudyUrl: project.caseStudyUrl,
      clientName: project.clientName,
      launchDate: project.launchDate,
      challenge: project.challenge,
      requirements: project.requirements,
      constraints: project.constraints,
      solution: project.solution,
      keyFeatures: project.keyFeatures,
      results: project.results,
      clientTestimonial: project.clientTestimonial,
      galleryImages: project.galleryImages,
      demoVideoUrl: project.demoVideoUrl,
      liveUrl: project.liveUrl,
      appStoreUrl: project.appStoreUrl,
      playStoreUrl: project.playStoreUrl,
      githubUrl: project.githubUrl,
      createdAt: project.createdAt,
      updatedAt: project.updatedAt,
      isPublished: project.isPublished,
      isFeatured: project.isFeatured,
      viewCount: project.viewCount,
    );
  }

  // ==================== STATIC DATA (Development) ====================
  /// Get all sample projects
  static List<ProjectModel> getAllProjects() {
    return [
      // E-Commerce Mobile App
      ProjectModel(
        id: 'ecommerce-app',
        title: 'ShopEase - E-Commerce App',
        tagline: 'Full-featured shopping app with payment integration',
        imagePath: 'assets/home/projects/project_1.png',
        platforms: ['iOS', 'Android'],
        techStack: ['Flutter', 'Firebase', 'Stripe', 'BLoC'],
        category: 'Mobile',
        clientName: 'ShopEase Inc.',
        launchDate: 'March 2024',
        description:
            'ShopEase is a modern e-commerce mobile application designed to provide seamless shopping experience across iOS and Android platforms. Built with Flutter for cross-platform consistency, the app integrates payment processing, real-time inventory management, and personalized recommendations.\n\nThe project was developed over 12 weeks following Agile methodology, with weekly sprints and continuous client feedback. The app successfully launched on both App Store and Play Store, receiving positive reviews for its intuitive UI and smooth performance.',
        challenge:
            'The client needed a scalable e-commerce solution that could handle high traffic during sales events while maintaining fast performance. Key challenges included implementing secure payment processing, managing complex product catalogs with variants, and ensuring smooth user experience across different device sizes and network conditions.',
        requirements:
            'The client required a scalable architecture that could handle concurrent users, secure payment processing with PCI compliance, real-time inventory synchronization across platforms, and seamless user experience with fast load times even on slower networks.',
        constraints:
            'Key constraints included a tight 12-week timeline for MVP delivery, limited backend infrastructure budget requiring cost-effective solutions, need for cross-platform consistency while maintaining native performance, and integration with existing legacy systems without disrupting current operations.',
        solution:
            'We implemented a clean MVVM architecture with BLoC for state management, ensuring separation of concerns and testability. Firebase was chosen for backend services due to its real-time capabilities and scalability. Stripe integration provided secure payment processing with support for multiple payment methods. The app uses efficient caching strategies and image optimization to maintain performance even on slower networks.',
        keyFeatures: [
          'User authentication with email/social login',
          'Product browsing with advanced filters',
          'Shopping cart with real-time updates',
          'Secure payment processing via Stripe',
          'Order tracking and history',
          'Push notifications for offers',
          'Wishlist and favorites',
          'Multi-language support',
        ],
        results: {
          'Downloads': '50,000+',
          'App Store Rating': '4.8/5.0',
          'Play Store Rating': '4.7/5.0',
          'Average Session Time': '8.5 (m)',
        },
        clientTestimonial:
            'The team delivered an exceptional product that exceeded our expectations. The app performance is outstanding, and our customers love the user experience.',
        galleryImages: [
          'assets/home/projects/project_2.png',
          'assets/home/projects/project_3.png',
          'assets/home/projects/project_4.png',
          'assets/home/projects/project_5.png',
        ],
        demoVideoUrl: 'https://www.youtube.com/watch?v=kPa7bsKwL-c&list=RDkPa7bsKwL-c&start_radio=1',
        appStoreUrl: 'https://translate.google.com.bd/?hl=bn&sl=auto&tl=bn&op=translate',
        playStoreUrl: 'https://translate.google.com.bd/?hl=bn&sl=auto&tl=bn&op=translate',
        githubUrl: "https://github.com/dolonk/grozziie_desktop",
        createdAt: DateTime(2024, 5, 10),
        updatedAt: DateTime(2024, 7, 15),
      ),

      // Portfolio Website
      ProjectModel(
        id: 'portfolio-web',
        title: 'Creative Portfolio',
        tagline: 'Responsive portfolio website with animations',
        imagePath: 'assets/home/projects/project_2.png',
        platforms: ['Web'],
        techStack: ['Flutter Web', 'Firebase', 'Provider'],
        category: 'Web',
        description:
            'A beautiful and responsive portfolio website built with Flutter Web. Features smooth animations, dark mode support, and SEO optimization.',
        createdAt: DateTime(2024, 5, 10),
        updatedAt: DateTime(2024, 7, 15),
        isFeatured: true,
        viewCount: 189,
      ),

      // Task Management Desktop
      ProjectModel(
        id: 'task-desktop',
        title: 'TaskMaster Pro',
        tagline: 'Professional task and project management tool',
        imagePath: 'assets/home/projects/project_3.png',
        platforms: ['Windows', 'macOS'],
        techStack: ['Flutter Desktop', 'Hive', 'Provider'],
        category: 'Desktop',
        description:
            'TaskMaster Pro is a powerful desktop application for managing tasks and projects. Features include real-time collaboration, task dependencies, and Gantt charts.',
        createdAt: DateTime(2024, 4, 5),
        updatedAt: DateTime(2024, 6, 10),
        viewCount: 156,
      ),

      // Travel Web App
      ProjectModel(
        id: 'travel-web',
        title: 'WanderGuide',
        tagline: 'Travel planning and booking platform',
        imagePath: 'assets/home/projects/project_4.png',
        platforms: ['Web'],
        techStack: ['Flutter Web', 'REST API', 'BLoC'],
        category: 'Web',
        description:
            'WanderGuide helps travelers plan their perfect vacation with AI-powered recommendations, booking integration, and travel guides.',
        createdAt: DateTime(2024, 3, 20),
        updatedAt: DateTime(2024, 5, 25),
        viewCount: 203,
      ),

      // Fitness Tracking App
      ProjectModel(
        id: 'fitness-app',
        title: 'FitTrack',
        tagline: 'Health and fitness tracking with workout plans',
        imagePath: 'assets/home/projects/project_5.png',
        platforms: ['iOS', 'Android'],
        techStack: ['Flutter', 'Firebase', 'Provider'],
        category: 'Mobile',
        description:
            'FitTrack is a comprehensive fitness tracking app with personalized workout plans, nutrition tracking, and progress analytics.',
        createdAt: DateTime(2024, 2, 14),
        updatedAt: DateTime(2024, 4, 18),
        isFeatured: true,
        viewCount: 312,
      ),

      // Banking App
      ProjectModel(
        id: 'banking-app',
        title: 'SecureBank Mobile',
        tagline: 'Secure mobile banking solution',
        imagePath: 'assets/home/projects/project_6.png',
        platforms: ['iOS', 'Android'],
        techStack: ['Flutter', 'Firebase', 'BLoC'],
        category: 'Mobile',
        description:
            'SecureBank Mobile provides a secure and intuitive mobile banking experience with biometric authentication and real-time notifications.',
        createdAt: DateTime(2024, 1, 8),
        updatedAt: DateTime(2024, 3, 12),
        viewCount: 278,
      ),
    ];
  }

  /// Get featured projects
  static List<ProjectModel> getFeaturedProjects() {
    return getAllProjects().where((p) => p.isFeatured).toList();
  }

  /// Get projects by category
  static List<ProjectModel> getProjectsByCategory(String category) {
    return getAllProjects().where((p) => p.category == category).toList();
  }

  /// Get projects by platform
  static List<ProjectModel> getProjectsByPlatform(String platform) {
    return getAllProjects().where((p) => p.platforms.contains(platform)).toList();
  }

  /// Get all unique categories
  static List<String> getAllCategories() {
    final categories = getAllProjects().map((p) => p.category).toSet().toList();
    categories.sort();
    return categories;
  }

  /// Get all unique platforms
  static List<String> getAllPlatforms() {
    final platforms = <String>{};
    for (var project in getAllProjects()) {
      platforms.addAll(project.platforms);
    }
    final list = platforms.toList();
    list.sort();
    return list;
  }

  /// Get all unique tech stacks
  static List<String> getAllTechStacks() {
    final techStacks = <String>{};
    for (var project in getAllProjects()) {
      techStacks.addAll(project.techStack);
    }
    final list = techStacks.toList();
    list.sort();
    return list;
  }
}
