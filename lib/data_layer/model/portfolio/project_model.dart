import '../../domain/entities/portfolio/project.dart';

class ProjectModel extends Project {
  const ProjectModel({
    required super.id,
    required super.title,
    required super.category,
    super.description,
    required super.imagePath,
    super.tagline,

    super.clientName,
    super.launchDate,
    super.challenge,
    super.requirements,
    super.constraints,
    super.solution,
    super.clientTestimonial,
    super.demoVideoUrl,
    super.liveUrl,
    super.appStoreUrl,
    super.playStoreUrl,
    super.githubUrl,

    super.platforms,
    super.techStack,
    super.keyFeatures,
    super.results,
    super.galleryImages,
    super.solutionSteps,
    super.techStackExtended,
    super.keyFeaturesExtended,

    super.isPublished,
    super.isFeatured,
    super.viewCount,
    required super.createdAt,
    required super.updatedAt,
  });

  // ==================== SUPABASE METHODS ====================
  factory ProjectModel.fromSupabase(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imagePath: json['image_path'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',

      clientName: json['client_name'] as String? ?? '',
      launchDate: json['launch_date'] as String? ?? '',
      challenge: json['challenge'] as String? ?? '',
      requirements: json['requirements'] as String? ?? '',
      constraints: json['constraints'] as String? ?? '',
      solution: json['solution'] as String? ?? '',
      clientTestimonial: json['client_testimonial'] as String? ?? '',
      demoVideoUrl: json['demo_video_url'] as String? ?? '',
      liveUrl: json['live_url'] as String?,
      appStoreUrl: json['app_store_url'] as String?,
      playStoreUrl: json['play_store_url'] as String?,
      githubUrl: json['github_url'] as String? ?? '',

      // Parse PostgreSQL arrays
      platforms: (json['platforms'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      techStack: (json['tech_stack'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      keyFeatures: (json['key_features'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      // Parse JSONB results
      results: (json['results'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, value.toString())) ?? {},
      galleryImages: (json['gallery_images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      solutionSteps: json['solution_steps'] as Map<String, dynamic>?,
      techStackExtended: (json['tech_stack_extended'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      keyFeaturesExtended: (json['key_features_extended'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),

      isPublished: json['is_published'] as bool? ?? false,
      isFeatured: json['is_featured'] as bool? ?? false,
      viewCount: json['view_count'] as int? ?? 0,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'] as String) : DateTime.now(),
    );
  }

  /// Convert ProjectModel to Supabase JSON
  Map<String, dynamic> toSupabase() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'description': description,
      'image_path': imagePath,
      'tagline': tagline,

      'client_name': clientName,
      'launch_date': launchDate,
      'challenge': challenge,
      'requirements': requirements,
      'constraints': constraints,
      'solution': solution,
      'client_testimonial': clientTestimonial,
      'demo_video_url': demoVideoUrl,
      'live_url': liveUrl,
      'app_store_url': appStoreUrl,
      'play_store_url': playStoreUrl,
      'github_url': githubUrl,

      'platforms': platforms,
      'tech_stack': techStack,
      'key_features': keyFeatures,
      'results': results,
      'gallery_images': galleryImages,
      'solution_steps': solutionSteps,
      'tech_stack_extended': techStackExtended,
      'key_features_extended': keyFeaturesExtended,

      'is_published': isPublished,
      'is_featured': isFeatured,
      'view_count': viewCount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Create from Entity
  factory ProjectModel.fromEntity(Project project) {
    return ProjectModel(
      id: project.id,
      title: project.title,
      category: project.category,
      description: project.description,
      imagePath: project.imagePath,
      tagline: project.tagline,

      clientName: project.clientName,
      launchDate: project.launchDate,
      challenge: project.challenge,
      requirements: project.requirements,
      constraints: project.constraints,
      solution: project.solution,
      clientTestimonial: project.clientTestimonial,
      demoVideoUrl: project.demoVideoUrl,
      liveUrl: project.liveUrl,
      appStoreUrl: project.appStoreUrl,
      playStoreUrl: project.playStoreUrl,
      githubUrl: project.githubUrl,

      platforms: project.platforms,
      techStack: project.techStack,
      keyFeatures: project.keyFeatures,
      results: project.results,
      galleryImages: project.galleryImages,
      solutionSteps: project.solutionSteps,
      techStackExtended: project.techStackExtended,
      keyFeaturesExtended: project.keyFeaturesExtended,

      isPublished: project.isPublished,
      isFeatured: project.isFeatured,
      viewCount: project.viewCount,
      createdAt: project.createdAt,
      updatedAt: project.updatedAt,
    );
  }
}

/* ProjectModel(
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

        // 🆕 Solution Timeline Steps Data
        solutionSteps: {
          'step1': {
            'description':
                'Clean architecture principles were applied throughout the project to ensure maintainability and scalability. The codebase follows SOLID principles with clear separation of concerns.',
            'highlights': [
              'Clean architecture principles',
              'Modular component design',
              'Test-driven development',
              'Continuous integration pipeline',
            ],
          },
          'step2': {
            'description':
                'We implemented a clean MVVM architecture pattern to ensure separation of concerns and maintainability. The codebase is organized into clear layers: presentation, domain, and data.',
            'highlights': [
              'MVVM pattern for clean separation',
              'Repository pattern for data management',
              'Dependency injection for flexibility',
              'Clear layer boundaries',
            ],
          },
          'step3': {
            'description':
                'BLoC (Business Logic Component) was chosen for state management due to its predictability and testability. It provides clear separation between business logic and UI.',
            'highlights': [
              'BLoC for predictable state flow',
              'Stream-based reactive updates',
              'Easy testing and debugging',
              'Separation of concerns',
            ],
          },
          'step4': {
            'description':
                'Flutter was selected for cross-platform development efficiency, Firebase for real-time capabilities and scalability, and Stripe for secure payment processing.',
            'highlights': [
              'Flutter for cross-platform efficiency',
              'Firebase for real-time sync',
              'Stripe for secure payments',
              'Native performance achieved',
            ],
          },
        },

        // 🆕 Tech Stack Extended Data
        techStackExtended: [
          {'iconName': 'flutter', 'name': 'Flutter', 'category': 'Framework', 'colorHex': '#02569B'},
          {'iconName': 'dart', 'name': 'Dart', 'category': 'Language', 'colorHex': '#0175C2'},
          {'iconName': 'firebase', 'name': 'Firebase', 'category': 'Backend', 'colorHex': '#FFCA28'},
          {'iconName': 'bloc', 'name': 'BLoC', 'category': 'State Management', 'colorHex': '#8B5CF6'},
          {'iconName': 'stripe', 'name': 'Stripe', 'category': 'Payment Gateway', 'colorHex': '#635BFF'},
          {'iconName': 'rest_api', 'name': 'REST API', 'category': 'Integration', 'colorHex': '#3B82F6'},
          {'iconName': 'get_it', 'name': 'Get It', 'category': 'Dependency Injection', 'colorHex': '#10B981'},
          {'iconName': 'git', 'name': 'Git', 'category': 'Version Control', 'colorHex': '#F05032'},
          {'iconName': 'figma', 'name': 'Figma', 'category': 'Design Tool', 'colorHex': '#F24E1E'},
        ],

        // 🆕 Key Features Extended Data
        keyFeaturesExtended: [
          {
            'iconName': 'user_check',
            'title': 'User Authentication',
            'description': 'Email/social login with secure password management and two-factor authentication',
            'colorHex': '#8B5CF6',
          },
          {
            'iconName': 'magnifying_glass',
            'title': 'Product Browsing',
            'description': 'Advanced filters and search with category navigation and smart recommendations',
            'colorHex': '#3B82F6',
          },
          {
            'iconName': 'cart_shopping',
            'title': 'Shopping Cart',
            'description': 'Real-time cart updates with quantity management and price calculations',
            'colorHex': '#10B981',
          },
          {
            'iconName': 'credit_card',
            'title': 'Payment Integration',
            'description': 'Secure Stripe payments with multiple methods including cards and wallets',
            'colorHex': '#EF4444',
          },
          {
            'iconName': 'truck_fast',
            'title': 'Order Tracking',
            'description': 'Live order status updates and delivery tracking with notifications',
            'colorHex': '#F59E0B',
          },
          {
            'iconName': 'bell',
            'title': 'Push Notifications',
            'description': 'Real-time alerts for offers, order updates, and personalized messages',
            'colorHex': '#EC4899',
          },
          {
            'iconName': 'heart',
            'title': 'Wishlist & Favorites',
            'description': 'Save items for later with quick access and price drop alerts',
            'colorHex': '#DC2626',
          },
          {
            'iconName': 'language',
            'title': 'Multi-language Support',
            'description': 'Support for 5+ languages with RTL layout and automatic detection',
            'colorHex': '#06B6D4',
          },
        ],
      ),*/
