/*class ProjectModel {
  // Basic Info
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

  // Additional Detail Page Fields
  final String clientName;
  final String launchDate;
  final String challenge;
  final String requirements;
  final String constraints;
  final String solution;
  final List<String> keyFeatures;
  final Map<String, String>? results;
  final String clientTestimonial;
  final List<String> galleryImages;
  final String demoVideoUrl;
  final String? liveUrl;
  final String? appStoreUrl;
  final String? playStoreUrl;
  final String githubUrl;

  ProjectModel({
    // Basic Info
    this.id = '',
    required this.title,
    required this.category,
    required this.imagePath,
    this.description = '',
    this.tagline = '',
    this.platforms = const [],
    this.techStack = const [],
    this.projectUrl,
    this.caseStudyUrl,
    // Additional Detail Page Fields
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
  });

  // Sample data for portfolio (12 projects)
  static List<ProjectModel> getAllProjects() {
    return [
      // 1. E-Commerce Mobile App
      ProjectModel(
        id: 'ecommerce-app',
        title: 'ShopEase - E-Commerce App',
        tagline: 'Full-featured shopping app with payment integration',
        imagePath: 'assets/home/projects/project_1.png',
        platforms: ['iOS', 'Android'],
        techStack: ['Flutter', 'Firebase', 'Stripe', 'BLoC'],
        category: 'Android App',
        projectUrl: 'https://example.com',
        description:
            'ShopEase is a modern e-commerce mobile application designed to provide seamless shopping experience across iOS and Android platforms. Built with Flutter for cross-platform consistency, the app integrates payment processing, real-time inventory management, and personalized recommendations.\n\nThe project was developed over 12 weeks following Agile methodology, with weekly sprints and continuous client feedback. The app successfully launched on both App Store and Play Store, receiving positive reviews for its intuitive UI and smooth performance.',
      ),

      // 2. Healthcare Web App
      ProjectModel(
        id: 'healthcare-web',
        title: 'MediCare Portal',
        tagline: 'Patient management and telemedicine platform',
        imagePath: 'assets/home/projects/project_2.png',
        platforms: ['Web'],
        techStack: ['Flutter Web', 'Firebase', 'WebRTC'],
        category: "Web Development",
        projectUrl: 'https://example.com',
        description:
            'ShopEase is a modern e-commerce mobile application designed to provide seamless shopping experience across iOS and Android platforms. Built with Flutter for cross-platform consistency, the app integrates payment processing, real-time inventory management, and personalized recommendations.\n\nThe project was developed over 12 weeks following Agile methodology, with weekly sprints and continuous client feedback. The app successfully launched on both App Store and Play Store, receiving positive reviews for its intuitive UI and smooth performance.',
      ),

      // 3. Finance Desktop App
      ProjectModel(
        id: 'finance-desktop',
        title: 'FinanceTracker Pro',
        tagline: 'Desktop accounting and analytics software',
        imagePath: 'assets/home/projects/project_3.png',
        platforms: ['Windows', 'macOS', 'Linux'],
        techStack: ['Flutter Desktop', 'SQLite', 'Provider'],
        category: 'Desktop',
        description:
            'ShopEase is a modern e-commerce mobile application designed to provide seamless shopping experience across iOS and Android platforms. Built with Flutter for cross-platform consistency, the app integrates payment processing, real-time inventory management, and personalized recommendations.\n\nThe project was developed over 12 weeks following Agile methodology, with weekly sprints and continuous client feedback. The app successfully launched on both App Store and Play Store, receiving positive reviews for its intuitive UI and smooth performance.',
      ),

      // 4. Education Mobile App
      ProjectModel(
        id: 'education-app',
        title: 'LearnHub',
        tagline: 'Interactive e-learning platform for students',
        imagePath: 'assets/home/projects/project_4.png',
        platforms: ['iOS', 'Android'],
        techStack: ['Flutter', 'Firebase', 'GetX'],
        category: "Ios App",
        description:
            'ShopEase is a modern e-commerce mobile application designed to provide seamless shopping experience across iOS and Android platforms. Built with Flutter for cross-platform consistency, the app integrates payment processing, real-time inventory management, and personalized recommendations.\n\nThe project was developed over 12 weeks following Agile methodology, with weekly sprints and continuous client feedback. The app successfully launched on both App Store and Play Store, receiving positive reviews for its intuitive UI and smooth performance.',
      ),

      // 5. Restaurant Booking Web
      ProjectModel(
        id: 'restaurant-web',
        title: 'DineReserve',
        tagline: 'Modern restaurant booking and management system',
        imagePath: 'assets/home/projects/project_5.png',
        platforms: ['Web'],
        techStack: ['Flutter Web', 'Node.js', 'MongoDB'],
        category: "Mac Os",
        description:
            'ShopEase is a modern e-commerce mobile application designed to provide seamless shopping experience across iOS and Android platforms. Built with Flutter for cross-platform consistency, the app integrates payment processing, real-time inventory management, and personalized recommendations.\n\nThe project was developed over 12 weeks following Agile methodology, with weekly sprints and continuous client feedback. The app successfully launched on both App Store and Play Store, receiving positive reviews for its intuitive UI and smooth performance.',
      ),

      // 6. UI/UX Design Project
      ProjectModel(
        id: 'uiux-design',
        title: 'FitnessPro Design System',
        tagline: 'Complete UI/UX design for fitness tracking app',
        imagePath: 'assets/home/projects/project_6.png',
        techStack: ['Figma', 'Adobe XD'],
        category: 'UI/UX',
        description:
            'ShopEase is a modern e-commerce mobile application designed to provide seamless shopping experience across iOS and Android platforms. Built with Flutter for cross-platform consistency, the app integrates payment processing, real-time inventory management, and personalized recommendations.\n\nThe project was developed over 12 weeks following Agile methodology, with weekly sprints and continuous client feedback. The app successfully launched on both App Store and Play Store, receiving positive reviews for its intuitive UI and smooth performance.',
      ),

      // 7. IoT Dashboard
      ProjectModel(
        id: 'iot-dashboard',
        title: 'SmartHome Controller',
        tagline: 'IoT device management and monitoring dashboard',
        imagePath: 'assets/home/projects/project_1.png',
        platforms: ['Web', 'Android'],
        techStack: ['Flutter', 'MQTT', 'Firebase'],
        category: 'Web',
        description:
            'ShopEase is a modern e-commerce mobile application designed to provide seamless shopping experience across iOS and Android platforms. Built with Flutter for cross-platform consistency, the app integrates payment processing, real-time inventory management, and personalized recommendations.\n\nThe project was developed over 12 weeks following Agile methodology, with weekly sprints and continuous client feedback. The app successfully launched on both App Store and Play Store, receiving positive reviews for its intuitive UI and smooth performance.',
      ),

      // 8. Social Media Mobile App
      ProjectModel(
        id: 'social-app',
        title: 'ConnectHub',
        tagline: 'Social networking app with real-time messaging',
        imagePath: 'assets/home/projects/project_2.png',
        platforms: ['iOS', 'Android'],
        techStack: ['Flutter', 'Firebase', 'Riverpod'],
        category: 'Mobile',
        description:
            'ShopEase is a modern e-commerce mobile application designed to provide seamless shopping experience across iOS and Android platforms. Built with Flutter for cross-platform consistency, the app integrates payment processing, real-time inventory management, and personalized recommendations.\n\nThe project was developed over 12 weeks following Agile methodology, with weekly sprints and continuous client feedback. The app successfully launched on both App Store and Play Store, receiving positive reviews for its intuitive UI and smooth performance.',
      ),

      // 9. Task Management Desktop
      ProjectModel(
        id: 'task-desktop',
        title: 'TaskMaster Pro',
        tagline: 'Professional task and project management tool',
        imagePath: 'assets/home/projects/project_3.png',
        platforms: ['Windows', 'macOS'],
        techStack: ['Flutter Desktop', 'Hive', 'Provider'],
        category: 'Desktop',
        description:
            'ShopEase is a modern e-commerce mobile application designed to provide seamless shopping experience across iOS and Android platforms. Built with Flutter for cross-platform consistency, the app integrates payment processing, real-time inventory management, and personalized recommendations.\n\nThe project was developed over 12 weeks following Agile methodology, with weekly sprints and continuous client feedback. The app successfully launched on both App Store and Play Store, receiving positive reviews for its intuitive UI and smooth performance.',
      ),

      // 10. Travel Web App
      ProjectModel(
        id: 'travel-web',
        title: 'WanderGuide',
        tagline: 'Travel planning and booking platform',
        imagePath: 'assets/home/projects/project_4.png',
        platforms: ['Web'],
        techStack: ['Flutter Web', 'REST API', 'BLoC'],
        category: 'Web',
        description:
            'ShopEase is a modern e-commerce mobile application designed to provide seamless shopping experience across iOS and Android platforms. Built with Flutter for cross-platform consistency, the app integrates payment processing, real-time inventory management, and personalized recommendations.\n\nThe project was developed over 12 weeks following Agile methodology, with weekly sprints and continuous client feedback. The app successfully launched on both App Store and Play Store, receiving positive reviews for its intuitive UI and smooth performance.',
      ),

      // 11. Fitness Tracking App
      ProjectModel(
        id: 'fitness-app',
        title: 'FitTrack',
        tagline: 'Health and fitness tracking with workout plans',
        imagePath: 'assets/home/projects/project_5.png',
        platforms: ['iOS', 'Android'],
        techStack: ['Flutter', 'Firebase', 'Provider'],
        category: 'Mobile',
        description:
            'ShopEase is a modern e-commerce mobile application designed to provide seamless shopping experience across iOS and Android platforms. Built with Flutter for cross-platform consistency, the app integrates payment processing, real-time inventory management, and personalized recommendations.\n\nThe project was developed over 12 weeks following Agile methodology, with weekly sprints and continuous client feedback. The app successfully launched on both App Store and Play Store, receiving positive reviews for its intuitive UI and smooth performance.',
      ),

      // 12. Portfolio Website Design
      ProjectModel(
        id: 'portfolio-design',
        title: 'Creative Portfolio Template',
        tagline: 'Modern portfolio website design for designers',
        imagePath: 'assets/home/projects/project_6.png',
        techStack: ['Figma', 'Sketch'],
        category: 'UI/UX',
        description:
            'ShopEase is a modern e-commerce mobile application designed to provide seamless shopping experience across iOS and Android platforms. Built with Flutter for cross-platform consistency, the app integrates payment processing, real-time inventory management, and personalized recommendations.\n\nThe project was developed over 12 weeks following Agile methodology, with weekly sprints and continuous client feedback. The app successfully launched on both App Store and Play Store, receiving positive reviews for its intuitive UI and smooth performance.',
      ),
    ];
  }

  // Sample detailed project data
  static ProjectModel getSampleProject(String projectId) {
    return ProjectModel(
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
    );
  }
}*/

import 'package:cloud_firestore/cloud_firestore.dart';
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

  // ==================== FIREBASE CONVERSION ====================
  /// Firebase Document to Model
  factory ProjectModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ProjectModel(
      id: doc.id,
      title: data['title'] ?? '',
      category: data['category'] ?? '',
      imagePath: data['imagePath'] ?? '',
      description: data['description'] ?? '',
      tagline: data['tagline'] ?? '',
      platforms: List<String>.from(data['platforms'] ?? []),
      techStack: List<String>.from(data['techStack'] ?? []),
      projectUrl: data['projectUrl'],
      caseStudyUrl: data['caseStudyUrl'],
      clientName: data['clientName'] ?? '',
      launchDate: data['launchDate'] ?? '',
      challenge: data['challenge'] ?? '',
      requirements: data['requirements'] ?? '',
      constraints: data['constraints'] ?? '',
      solution: data['solution'] ?? '',
      keyFeatures: List<String>.from(data['keyFeatures'] ?? []),
      results: Map<String, String>.from(data['results'] ?? {}),
      clientTestimonial: data['clientTestimonial'] ?? '',
      galleryImages: List<String>.from(data['galleryImages'] ?? []),
      demoVideoUrl: data['demoVideoUrl'] ?? '',
      liveUrl: data['liveUrl'],
      appStoreUrl: data['appStoreUrl'],
      playStoreUrl: data['playStoreUrl'],
      githubUrl: data['githubUrl'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isPublished: data['isPublished'] ?? true,
      isFeatured: data['isFeatured'] ?? false,
      viewCount: data['viewCount'] ?? 0,
    );
  }

  /// Model to Firebase
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'category': category,
      'imagePath': imagePath,
      'description': description,
      'tagline': tagline,
      'platforms': platforms,
      'techStack': techStack,
      'projectUrl': projectUrl,
      'caseStudyUrl': caseStudyUrl,
      'clientName': clientName,
      'launchDate': launchDate,
      'challenge': challenge,
      'requirements': requirements,
      'constraints': constraints,
      'solution': solution,
      'keyFeatures': keyFeatures,
      'results': results,
      'clientTestimonial': clientTestimonial,
      'galleryImages': galleryImages,
      'demoVideoUrl': demoVideoUrl,
      'liveUrl': liveUrl,
      'appStoreUrl': appStoreUrl,
      'playStoreUrl': playStoreUrl,
      'githubUrl': githubUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'isPublished': isPublished,
      'isFeatured': isFeatured,
      'viewCount': viewCount,
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
