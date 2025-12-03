class ServiceModel {
  final String iconPath;
  final String title;
  final String subTitle;
  final String description;

  ServiceModel({required this.iconPath, required this.title, required this.subTitle, required this.description});

  static List<ServiceModel> getServices() {
    return [
      ServiceModel(
        iconPath: "assets/home/icon/android_icon.svg",
        title: "Mobile App Development",
        subTitle: "iOS & Android",
        description:
            "Custom mobile applications for iOS and Android, delivering high performance and exceptional user experience.",
      ),
      ServiceModel(
        iconPath: "assets/home/icon/web_icon.svg",
        title: "Web Application Development",
        subTitle: "Responsive & Modern",
        description:
            "Responsive web applications with modern frameworks, SEO optimization, and cross-browser compatibility.",
      ),
      ServiceModel(
        iconPath: "assets/home/icon/web_icon.svg",
        title: "Desktop Development",
        subTitle: "Windows, macOS, Linux",
        description:
            "Cross-platform desktop applications for Windows, macOS, and Linux with native platform integration.",
      ),
      ServiceModel(
        iconPath: "assets/home/icon/web_icon.svg",
        title: "UI/UX Design Services",
        subTitle: "User-Centered Design",
        description:
            "Beautiful and intuitive designs with wireframing, prototyping, and high-fidelity mockups for amazing user experience.",
      ),
      ServiceModel(
        iconPath: "assets/home/icon/web_icon.svg",
        title: "Consulting & Code Review",
        subTitle: "Expert Guidance",
        description:
            "Architecture review, performance optimization, code refactoring guidance, and best practices implementation.",
      ),
      ServiceModel(
        iconPath: "assets/home/icon/web_icon.svg",
        title: "Maintenance & Support",
        subTitle: "24/7 Available",
        description:
            "Ongoing maintenance, bug fixes, feature updates, OS compatibility updates, and 24/7 support options.",
      ),
    ];
  }
}
