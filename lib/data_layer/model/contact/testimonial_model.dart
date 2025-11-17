class TestimonialModel {
  final String clientName;
  final String companyRole;
  final double rating;
  final String testimonial;
  final String? clientPhoto;
  final String projectType;

  TestimonialModel({
    required this.clientName,
    required this.companyRole,
    required this.rating,
    required this.testimonial,
    this.clientPhoto,
    required this.projectType,
  });

  /// Get all testimonials (Sample data - Replace with your actual testimonials)
  static List<TestimonialModel> getAllTestimonials() {
    return [
      // Testimonial 1
      TestimonialModel(
        clientName: 'Sarah Johnson',
        companyRole: 'CEO, TechVision Inc.',
        rating: 5.0,
        testimonial:
            'Outstanding work! The Flutter app exceeded our expectations. Clean code, beautiful UI, and delivered ahead of schedule. Highly professional and communicative throughout the project.',
        clientPhoto: null, // TODO: Add actual photo URL
        projectType: 'Mobile App Development',
      ),

      // Testimonial 2
      TestimonialModel(
        clientName: 'Michael Chen',
        companyRole: 'CTO, StartupHub',
        rating: 5.0,
        testimonial:
            'Incredible expertise in Flutter development! Built a complex cross-platform solution that works flawlessly on iOS, Android, and Web. The MVVM architecture is pristine and maintainable.',
        clientPhoto: null,
        projectType: 'Cross-Platform Solution',
      ),

      // Testimonial 3
      TestimonialModel(
        clientName: 'Emily Rodriguez',
        companyRole: 'Product Manager, HealthTech Co.',
        rating: 5.0,
        testimonial:
            'Best developer I\'ve worked with! Attention to detail is exceptional. The app is fast, responsive, and users love it. Post-launch support was excellent too.',
        clientPhoto: null,
        projectType: 'Healthcare App',
      ),

      // Testimonial 4
      TestimonialModel(
        clientName: 'David Williams',
        companyRole: 'Founder, EduLearn',
        rating: 5.0,
        testimonial:
            'Transformed our vision into reality! The e-learning platform is intuitive and scalable. Great communication, regular updates, and delivered exactly what we needed.',
        clientPhoto: null,
        projectType: 'E-Learning Platform',
      ),

      // Testimonial 5
      TestimonialModel(
        clientName: 'Lisa Anderson',
        companyRole: 'Marketing Director, RetailPro',
        rating: 5.0,
        testimonial:
            'Professional, reliable, and talented! Our e-commerce app is performing brilliantly. The UI/UX design is top-notch and conversion rates have increased significantly.',
        clientPhoto: null,
        projectType: 'E-Commerce App',
      ),

      // Testimonial 6
      TestimonialModel(
        clientName: 'James Taylor',
        companyRole: 'Operations Manager, LogiTrack',
        rating: 5.0,
        testimonial:
            'Exceptional work on our logistics tracking system! Real-time updates work perfectly and the admin dashboard is powerful yet easy to use. Highly recommended!',
        clientPhoto: null,
        projectType: 'Logistics Management',
      ),

      // Testimonial 7
      TestimonialModel(
        clientName: 'Sophia Martinez',
        companyRole: 'HR Director, TalentFind',
        rating: 5.0,
        testimonial:
            'Excellent developer! Built our recruitment platform with amazing features. The code quality is outstanding and documentation is comprehensive. Will definitely work together again.',
        clientPhoto: null,
        projectType: 'Recruitment Platform',
      ),

      // Testimonial 8
      TestimonialModel(
        clientName: 'Robert Kim',
        companyRole: 'Founder, FitLife',
        rating: 5.0,
        testimonial:
            'Amazing experience from start to finish! The fitness tracking app is smooth, feature-rich, and our users are extremely satisfied. Professional approach and great technical skills.',
        clientPhoto: null,
        projectType: 'Fitness Tracking App',
      ),
    ];
  }
}
