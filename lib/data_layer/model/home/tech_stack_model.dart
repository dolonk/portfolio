class TechStackModel {
  final String name;
  final String iconPath;
  final String category;

  TechStackModel({required this.name, required this.iconPath, required this.category});

  static List<TechStackModel> getTechStackData() {
    const String basePath = 'assets/home/icon/tech_icons/';

    return [
      // Core Technologies
      TechStackModel(name: 'Flutter', iconPath: '${basePath}flutter-original.svg', category: 'Core Technologies'),
      TechStackModel(name: 'Dart', iconPath: '${basePath}dart-original.svg', category: 'Core Technologies'),
      TechStackModel(name: 'Firebase', iconPath: '${basePath}firebase-plain.svg', category: 'Core Technologies'),
      TechStackModel(name: 'Kotlin', iconPath: '${basePath}kotlin-original.svg', category: 'Core Technologies'),
      TechStackModel(name: 'Java', iconPath: '${basePath}java-original.svg', category: 'Core Technologies'),
      TechStackModel(name: 'Swift', iconPath: '${basePath}swift-original.svg', category: 'Core Technologies'),

      // Platforms
      TechStackModel(name: 'iOS', iconPath: '${basePath}apple-original.svg', category: 'Platforms'),
      TechStackModel(name: 'Android', iconPath: '${basePath}android-plain.svg', category: 'Platforms'),
      TechStackModel(name: 'Web', iconPath: '${basePath}web.png', category: 'Platforms'),
      TechStackModel(name: 'Windows', iconPath: '${basePath}windows8-original.svg', category: 'Platforms'),
      TechStackModel(name: 'macOS', iconPath: '${basePath}mac_os.png', category: 'Platforms'),

      // State Management
      TechStackModel(name: 'Provider', iconPath: '${basePath}provider.svg', category: 'State Management'),
      TechStackModel(name: 'BLoC', iconPath: '${basePath}bloc.svg', category: 'State Management'),
      TechStackModel(name: 'Riverpod', iconPath: '${basePath}riverpod.svg', category: 'State Management'),
      TechStackModel(name: 'GetX', iconPath: '${basePath}getx.svg', category: 'State Management'),

      // Tools & Platforms
      TechStackModel(name: 'Git', iconPath: '${basePath}git-original.svg', category: 'Tools & Platforms'),
      TechStackModel(name: 'GitHub', iconPath: '${basePath}github-original.svg', category: 'Tools & Platforms'),
      TechStackModel(name: 'VS Code', iconPath: '${basePath}vscode-original.svg', category: 'Tools & Platforms'),
      TechStackModel(name: 'Figma', iconPath: '${basePath}figma-original.svg', category: 'Tools & Platforms'),
    ];
  }
}
