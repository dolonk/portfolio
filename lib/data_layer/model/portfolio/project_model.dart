class ProjectModel {
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
        category: 'Mobile',
        projectUrl: 'https://example.com',
      ),

      // 2. Healthcare Web App
      ProjectModel(
        id: 'healthcare-web',
        title: 'MediCare Portal',
        tagline: 'Patient management and telemedicine platform',
        imagePath: 'assets/home/projects/project_2.png',
        platforms: ['Web'],
        techStack: ['Flutter Web', 'Firebase', 'WebRTC'],
        category: 'Web',
        projectUrl: 'https://example.com',
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
      ),

      // 4. Education Mobile App
      ProjectModel(
        id: 'education-app',
        title: 'LearnHub',
        tagline: 'Interactive e-learning platform for students',
        imagePath: 'assets/home/projects/project_4.png',
        platforms: ['iOS', 'Android'],
        techStack: ['Flutter', 'Firebase', 'GetX'],
        category: 'Mobile',
      ),

      // 5. Restaurant Booking Web
      ProjectModel(
        id: 'restaurant-web',
        title: 'DineReserve',
        tagline: 'Modern restaurant booking and management system',
        imagePath: 'assets/home/projects/project_5.png',
        platforms: ['Web'],
        techStack: ['Flutter Web', 'Node.js', 'MongoDB'],
        category: 'Web',
      ),

      // 6. UI/UX Design Project
      ProjectModel(
        id: 'uiux-design',
        title: 'FitnessPro Design System',
        tagline: 'Complete UI/UX design for fitness tracking app',
        imagePath: 'assets/home/projects/project_6.png',
        techStack: ['Figma', 'Adobe XD'],
        category: 'UI/UX',
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
      ),

      // 12. Portfolio Website Design
      ProjectModel(
        id: 'portfolio-design',
        title: 'Creative Portfolio Template',
        tagline: 'Modern portfolio website design for designers',
        imagePath: 'assets/home/projects/project_6.png',
        techStack: ['Figma', 'Sketch'],
        category: 'UI/UX',
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
}
