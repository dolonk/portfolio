class PricingFaqModel {
  final String id;
  final String question;
  final String answer;
  final String category;
  final List<String> keywords;

  PricingFaqModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.category,
    required this.keywords,
  });

  /// Get all FAQs
  static List<PricingFaqModel> getAllFaqs() {
    return [
      // PRICING QUESTIONS
      PricingFaqModel(
        id: 'pricing-1',
        question: 'Why "starting from" prices? Can I get an exact quote?',
        answer:
            'Every project is unique with different requirements, complexity, and timelines. These are baseline prices for standard features. Once you share your specific needs, I\'ll provide a detailed, fixed-price quote with no hidden costs.',
        category: 'Pricing',
        keywords: ['pricing', 'quote', 'exact', 'cost', 'starting from'],
      ),
      PricingFaqModel(
        id: 'pricing-2',
        question: 'What\'s included in the base package prices?',
        answer:
            'All packages include:\n• Clean, production-ready code\n• MVVM architecture implementation\n• Version control (Git repository)\n• Basic deployment assistance\n• Source code ownership\n• Email support during development\n• Bug fixes during development period',
        category: 'Pricing',
        keywords: ['included', 'base', 'package', 'features', 'what\'s in'],
      ),
      PricingFaqModel(
        id: 'pricing-3',
        question: 'What\'s NOT included in the packages?',
        answer:
            'These are typically separate:\n• Custom UI/UX design from scratch (Add-on available)\n• Backend/server development (Add-on available)\n• Third-party API costs (payment gateways, maps, etc.)\n• App Store/Google Play developer account fees (\$99/year + \$25 one-time)\n• Domain and hosting costs\n• Marketing and ASO services\n• Content creation (text, images, videos)',
        category: 'Pricing',
        keywords: ['not included', 'excluded', 'extra', 'additional costs'],
      ),
      PricingFaqModel(
        id: 'pricing-4',
        question: 'Are there any hidden fees?',
        answer:
            'Absolutely not. The quote includes everything agreed upon. Additional costs only occur if:\n• You request scope changes (we discuss & approve first)\n• Third-party services needed (API keys, hosting, etc.)\n• You choose optional add-ons\n\nAll changes are transparent and require your approval.',
        category: 'Pricing',
        keywords: ['hidden fees', 'extra costs', 'additional charges'],
      ),
      PricingFaqModel(
        id: 'pricing-5',
        question: 'Do you offer discounts?',
        answer:
            'Yes, in these cases:\n• Startups/Non-profits: 10-15% discount (case-by-case)\n• Multiple projects: 15% off 2nd project, 20% off 3rd+\n• Referrals: \$500 credit for each successful referral\n• Long-term retainer: 20% off monthly rates vs hourly\n• Bundle services: 15% off when adding 3+ add-ons',
        category: 'Pricing',
        keywords: ['discount', 'offers', 'deals', 'save money', 'cheaper'],
      ),

      // PAYMENT QUESTIONS
      PricingFaqModel(
        id: 'payment-1',
        question: 'Do you offer payment plans or financing?',
        answer:
            'For projects \$10K+, I can offer:\n• Monthly installment plans (over project duration)\n• Minimum 25% upfront + equal monthly payments\n• No interest charges\n• Custom terms negotiable for enterprise clients',
        category: 'Payment',
        keywords: ['payment plan', 'financing', 'installments', 'monthly'],
      ),
      PricingFaqModel(
        id: 'payment-2',
        question: 'What payment methods do you accept?',
        answer:
            'I accept:\n• Bank Transfer (Preferred - no fees)\n• PayPal (International clients)\n• Wise/TransferWise (Low fees)\n• Cryptocurrency (Bitcoin, USDT - for \$10K+ projects)\n• Payoneer\n\nAll prices are in USD, but can invoice in BDT for local clients.',
        category: 'Payment',
        keywords: ['payment methods', 'how to pay', 'bank transfer', 'paypal'],
      ),
      PricingFaqModel(
        id: 'payment-3',
        question: 'What\'s your refund policy?',
        answer:
            'Refund policy:\n• Before work starts: 100% refund minus 10% admin fee\n• Design phase only: 50% refund\n• Development started: No refund (you keep all completed work and code)\n\nYou always own whatever has been built up to that point.',
        category: 'Payment',
        keywords: ['refund', 'money back', 'cancellation', 'return'],
      ),
      PricingFaqModel(
        id: 'payment-4',
        question: 'What currency do you accept?',
        answer:
            'All prices are in USD (\$). For Bangladesh clients, I can invoice in BDT (৳) at current exchange rates. Payment can be made in your local currency through services like Wise or PayPal.',
        category: 'Payment',
        keywords: ['currency', 'usd', 'bdt', 'dollars', 'taka'],
      ),

      // PROJECT QUESTIONS
      PricingFaqModel(
        id: 'project-1',
        question: 'Can I upgrade from Starter to Pro mid-project?',
        answer:
            'Yes! You can upgrade anytime before the design phase ends. I\'ll adjust the quote and timeline accordingly. Price difference applies based on the new package features.',
        category: 'Project',
        keywords: ['upgrade', 'change package', 'switch tier'],
      ),
      PricingFaqModel(
        id: 'project-2',
        question: 'What happens if the project takes longer than estimated?',
        answer:
            'The fixed price stays the same unless:\n• You request major scope changes (new features)\n• Significant delays from your side (feedback, content)\n• Third-party integration issues beyond control\n\nTimeline extensions due to my delays = no extra cost to you.',
        category: 'Project',
        keywords: ['timeline', 'delay', 'longer', 'late', 'overtime'],
      ),
      PricingFaqModel(
        id: 'project-3',
        question: 'Do you sign NDAs?',
        answer:
            'Yes, I sign NDAs before project discussions at no extra cost. Your idea and data are completely confidential. I take privacy and intellectual property seriously.',
        category: 'Project',
        keywords: ['nda', 'confidentiality', 'privacy', 'secret', 'agreement'],
      ),
      PricingFaqModel(
        id: 'project-4',
        question: 'What if I\'m not happy with the final result?',
        answer:
            'Each package includes revision rounds (2-Unlimited based on tier). I work until you\'re satisfied within the agreed scope. If there\'s a fundamental mismatch, the milestone-based payment protects both of us - you\'ve only paid for completed work.',
        category: 'Project',
        keywords: ['not happy', 'dissatisfied', 'revisions', 'changes'],
      ),
      PricingFaqModel(
        id: 'project-5',
        question: 'Can I see examples of your previous work before paying?',
        answer:
            'Absolutely! Check my Portfolio page for detailed case studies. I can also share relevant work samples specific to your industry during our consultation call. No payment required to see examples.',
        category: 'Project',
        keywords: ['portfolio', 'examples', 'previous work', 'samples'],
      ),

      // GENERAL QUESTIONS
      PricingFaqModel(
        id: 'general-1',
        question: 'What if I only have a rough idea, no detailed requirements?',
        answer:
            'Perfect! That\'s common. We\'ll have a free consultation where I\'ll help you:\n• Define features and scope\n• Suggest technical approach\n• Estimate timeline and budget\n• Create a detailed proposal\n\nNo commitment needed for the consultation call.',
        category: 'General',
        keywords: ['rough idea', 'no requirements', 'just idea', 'planning'],
      ),
      PricingFaqModel(
        id: 'general-2',
        question: 'Can you work within my budget?',
        answer:
            'I\'ll try my best! If your budget is below package prices, we can:\n• Build an MVP (minimum features first)\n• Phase the project (launch in stages)\n• Adjust scope to fit budget\n• Suggest cost-saving approaches\n\nLet\'s discuss what\'s possible within your constraints.',
        category: 'General',
        keywords: ['budget', 'affordable', 'cheap', 'low cost', 'save money'],
      ),
      PricingFaqModel(
        id: 'general-3',
        question: 'Do prices differ for iOS vs Android vs Web vs Desktop?',
        answer:
            'Yes, platform complexity varies:\n• Single platform (iOS or Android or Web): Starter tier\n• Two platforms (iOS + Android): Pro tier\n• All platforms (iOS + Android + Web + Desktop): Enterprise tier\n\nDesktop (Windows/macOS/Linux) typically requires more work than mobile.',
        category: 'General',
        keywords: ['platform', 'ios', 'android', 'web', 'desktop', 'pricing'],
      ),
      PricingFaqModel(
        id: 'general-4',
        question: 'What\'s your hourly rate for small tasks?',
        answer:
            'For one-off tasks, consultations, or code reviews:\n• Hourly rate: \$100/hour\n• Minimum: 2 hours\n• Response time: 24-48 hours\n\nFor ongoing work, monthly retainers are more cost-effective.',
        category: 'General',
        keywords: ['hourly rate', 'small task', 'consultation', 'code review'],
      ),
      PricingFaqModel(
        id: 'general-5',
        question: 'How do I get started?',
        answer:
            'Simple 3 steps:\n1. Fill the Contact Form with your project details\n2. Schedule a free 30-minute consultation call\n3. Receive a detailed proposal & quote within 48 hours\n\nNo commitment until you approve the proposal!',
        category: 'General',
        keywords: ['get started', 'begin', 'start', 'how to'],
      ),

      // SUPPORT QUESTIONS
      PricingFaqModel(
        id: 'support-1',
        question: 'How does support work after launch?',
        answer:
            'Each package includes post-launch support:\n• Starter: 1 month email support\n• Pro: 3 months priority support\n• Enterprise: 6 months priority + emergency support\n\nAfter that, you can:\n• Purchase extended support (\$400-\$1,500/month)\n• Pay hourly for specific fixes (\$100/hour)\n• No obligation to continue',
        category: 'Support',
        keywords: ['support', 'after launch', 'maintenance', 'help'],
      ),
      PricingFaqModel(
        id: 'support-2',
        question: 'Can you maintain existing apps?',
        answer:
            'Yes! I offer maintenance services for existing Flutter apps, even if I didn\'t build them. Services include:\n• Bug fixes\n• Feature updates\n• OS compatibility updates\n• Performance optimization\n• Code refactoring\n\nContact me for a maintenance quote.',
        category: 'Support',
        keywords: ['maintain', 'existing app', 'take over', 'fix bugs'],
      ),
    ];
  }

  /// Get FAQs by category
  static List<PricingFaqModel> getFaqsByCategory(String category) {
    if (category == 'All') {
      return getAllFaqs();
    }
    return getAllFaqs().where((faq) => faq.category == category).toList();
  }

  /// Search FAQs
  static List<PricingFaqModel> searchFaqs(String query) {
    if (query.isEmpty) return getAllFaqs();

    final lowerQuery = query.toLowerCase();
    return getAllFaqs().where((faq) {
      return faq.question.toLowerCase().contains(lowerQuery) ||
          faq.answer.toLowerCase().contains(lowerQuery) ||
          faq.keywords.any((keyword) => keyword.toLowerCase().contains(lowerQuery));
    }).toList();
  }

  /// Get all categories
  static List<String> getAllCategories() {
    return ['All', 'Pricing', 'Payment', 'Project', 'General', 'Support'];
  }
}
