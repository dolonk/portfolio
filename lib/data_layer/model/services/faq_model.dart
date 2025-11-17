class FaqModel {
  final String question;
  final String answer;

  FaqModel({required this.question, required this.answer});

  // Sample data for 10 FAQs
  static List<FaqModel> getAllFaqs() {
    return [
      // 1. Development timeline
      FaqModel(
        question: 'How long does development take?',
        answer:
            'Timeline varies by project scope. Simple apps: 4-6 weeks, Medium apps: 6-10 weeks, Complex apps: 10-16 weeks. I provide detailed timeline estimates after understanding your requirements.',
      ),

      // 2. Pricing inclusions
      FaqModel(
        question: 'What\'s included in the price?',
        answer:
            'All packages include clean code, MVVM architecture, version control, deployment assistance, source code ownership, and email support during development. Specific deliverables vary by package tier.',
      ),

      // 3. NDA signing
      FaqModel(
        question: 'Do you sign NDAs?',
        answer:
            'Yes, I sign NDAs before project discussions at no extra cost. Your ideas and data are completely confidential.',
      ),

      // 4. Post-delivery support
      FaqModel(
        question: 'What happens after delivery?',
        answer:
            'You receive complete source code, deployment support, documentation, and a support period (1-6 months based on package). After that, extended support is available at monthly rates.',
      ),

      // 5. Existing app maintenance
      FaqModel(
        question: 'Can you maintain existing apps?',
        answer:
            'Absolutely! I offer maintenance services for existing Flutter apps including bug fixes, feature updates, OS compatibility updates, and performance optimization.',
      ),

      // 6. Refund policy
      FaqModel(
        question: 'What\'s your refund policy?',
        answer:
            '100% refund if work hasn\'t started. 50% refund if only design phase completed. No refund after development begins, but milestone-based payments protect both parties.',
      ),

      // 7. Team collaboration
      FaqModel(
        question: 'Do you work with teams?',
        answer:
            'Yes, I collaborate with development teams, provide code reviews, mentorship, and can integrate into your existing workflow using Agile/Scrum methodologies.',
      ),

      // 8. Technologies used
      FaqModel(
        question: 'What technologies do you use?',
        answer:
            'Flutter/Dart for cross-platform development, state management (Provider, BLoC, Riverpod, GetX), Firebase/custom backends, REST APIs, and platform-specific integrations.',
      ),

      // 9. Portfolio viewing
      FaqModel(
        question: 'Can I see your previous work?',
        answer:
            'Yes! Check my Portfolio page for detailed case studies. I can also share relevant work samples specific to your industry during our consultation call.',
      ),

      // 10. Communication methods
      FaqModel(
        question: 'How do we communicate during the project?',
        answer:
            'Regular updates via email, Slack, or your preferred tool. Weekly progress meetings, access to project management platform, and responsive communication throughout development.',
      ),
    ];
  }
}
