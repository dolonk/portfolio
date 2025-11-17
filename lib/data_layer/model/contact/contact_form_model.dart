class ContactFormModel {
  final String name;
  final String email;
  final String? phone;
  final String? company;
  final String projectType;
  final List<String> platforms;
  final String budgetRange;
  final String timeline;
  final String message;
  final String? attachedFileName;
  final bool ndaRequired;
  final bool newsletterSignup;

  ContactFormModel({
    required this.name,
    required this.email,
    this.phone,
    this.company,
    required this.projectType,
    required this.platforms,
    required this.budgetRange,
    required this.timeline,
    required this.message,
    this.attachedFileName,
    this.ndaRequired = false,
    this.newsletterSignup = false,
  });

  // Convert to JSON for API submission
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'company': company,
      'project_type': projectType,
      'platforms': platforms,
      'budget_range': budgetRange,
      'timeline': timeline,
      'message': message,
      'attached_file': attachedFileName,
      'nda_required': ndaRequired,
      'newsletter_signup': newsletterSignup,
    };
  }
}
