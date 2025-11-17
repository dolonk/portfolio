class BlogPostModel {
  // Basic Info (For Blog Card)
  final String id;
  final String title;
  final String excerpt;
  final String imagePath;
  final String category;
  final List<String> tags;
  final bool isFeatured;

  // Meta Information (For Blog Card & Detail)
  final String author;
  final String authorImage;
  final String authorBio;
  final String publishedDate;
  final String readingTime;
  final int viewCount;

  // Detail Page Content
  final String content;
  final String? videoUrl;
  final List<String> contentImages;

  // Author Social Links (For Detail Page)
  final Map<String, String> authorSocialLinks;

  BlogPostModel({
    // Basic Info
    required this.id,
    required this.title,
    required this.excerpt,
    required this.imagePath,
    this.category = 'Flutter',
    required this.tags,
    this.isFeatured = false,

    // Meta Information
    this.author = 'Dolon Kumar',
    this.authorImage = 'assets/home/hero/dolon.png',
    this.authorBio =
        'Flutter Developer | Cross-Platform Expert with 2.6+ years experience building production-ready applications.',
    required this.publishedDate,
    required this.readingTime,
    this.viewCount = 0,

    // Detail Page Content
    this.content = '',
    this.videoUrl,
    this.contentImages = const [],

    // Author Social Links
    this.authorSocialLinks = const {
      'github': 'https://github.com/yourusername',
      'linkedin': 'https://linkedin.com/in/yourprofile',
      'twitter': 'https://twitter.com/yourhandle',
    },
  });

  /// Get all blog posts (sample data)
  static List<BlogPostModel> getAllPosts() {
    return [
      // Featured Post
      BlogPostModel(
        id: 'flutter-mvvm-architecture',
        title: 'Building Scalable Flutter Apps with MVVM Architecture',
        excerpt:
            'Learn how to architect production-ready Flutter applications using the MVVM pattern, clean code principles, and best practices for maintainability and scalability.',
        imagePath: 'assets/home/projects/project_2.png',
        publishedDate: 'Nov 10, 2024',
        readingTime: '8 min read',
        tags: ['Flutter', 'Architecture', 'MVVM', 'Best Practices'],
        isFeatured: true,
        viewCount: 1250,
        videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        contentImages: ['assets/home/projects/project_2.png', 'assets/home/projects/project_4.png', 'assets/home/projects/project_5.png', 'assets/home/projects/project_3.png'],
        content: '''
## Introduction

MVVM (Model-View-ViewModel) is a powerful architectural pattern that helps you build maintainable and testable Flutter applications. In this comprehensive guide, we'll explore how to implement MVVM in Flutter from scratch.

💡 This tutorial is designed for developers who want to write clean, scalable code that's easy to test and maintain.

Building large-scale Flutter applications without a proper architecture can quickly become a nightmare. As your app grows, you'll face challenges like tangled code, difficult testing, and poor maintainability. That's where MVVM comes to the rescue.

## What is MVVM?

MVVM stands for Model-View-ViewModel, and it separates your application into three main components:

- Model: Your data layer and business logic
- View: Your UI components (Flutter Widgets)
- ViewModel: The bridge between Model and View, managing state and business logic

### Why Use MVVM in Flutter?

Here are the key benefits of using MVVM in your Flutter projects:

- Better Separation of Concerns - Clear boundaries between UI and business logic
- Easier Testing - ViewModels can be tested without UI dependencies
- Improved Maintainability - Changes in one layer don't affect others
- Team Collaboration - Multiple developers can work on different layers simultaneously
- Reusable Code - ViewModels can be shared across multiple Views

⚠️ Don't confuse MVVM with MVC. While similar, MVVM provides better separation and testability for Flutter apps.

## Project Structure

Here's the recommended folder structure for MVVM in Flutter:
```
lib/
├── models/
│   ├── user_model.dart
│   └── product_model.dart
├── views/
│   ├── home_view.dart
│   └── profile_view.dart
├── viewmodels/
│   ├── home_viewmodel.dart
│   └── profile_viewmodel.dart
├── services/
│   ├── api_service.dart
│   └── storage_service.dart
└── utils/
    └── constants.dart
```

This structure keeps your code organized and makes it easy to locate specific components. Each layer has its own directory, promoting clean architecture principles.

## Implementation Step-by-Step

Let's build a simple counter app using MVVM to understand the pattern better. We'll start with the Model layer and work our way up to the View.

### Step 1: Create the Model

The Model represents your data structure. Keep it simple and focused on data only.
```dart
class CounterModel {
  int count;
  
  CounterModel({this.count = 0});
  
  void increment() {
    count++;
  }
  
  void decrement() {
    count--;
  }
  
  void reset() {
    count = 0;
  }
}
```

📝 Notice how the Model only contains data and basic operations. No UI logic, no state management - just pure data manipulation.

### Step 2: Create the ViewModel

The ViewModel contains business logic and manages state. It notifies the View when data changes.
```dart
import 'package:flutter/foundation.dart';
import '../models/counter_model.dart';

class CounterViewModel extends ChangeNotifier {
  final CounterModel _model = CounterModel();
  
  int get count => _model.count;
  
  void increment() {
    _model.increment();
    notifyListeners();
  }
  
  void decrement() {
    if (_model.count > 0) {
      _model.decrement();
      notifyListeners();
    }
  }
  
  void reset() {
    _model.reset();
    notifyListeners();
  }
}
```

✅ The ViewModel acts as a middleman, exposing only necessary data to the View and handling business logic like preventing negative counts.

### Step 3: Create the View

The View is purely UI code. It observes the ViewModel and rebuilds when notified.
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/counter_viewmodel.dart';

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterViewModel(),
      child: Scaffold(
        appBar: AppBar(title: const Text('MVVM Counter')),
        body: Consumer<CounterViewModel>(
          builder: (context, viewModel, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Count: \${viewModel.count}',
                    style: const TextStyle(fontSize: 48),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: viewModel.decrement,
                        child: const Icon(Icons.remove),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: viewModel.reset,
                        child: const Text('Reset'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: viewModel.increment,
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
```

## Real-World Example: User Profile

Now let's build a more complex example with API integration to see how MVVM handles real-world scenarios.

### The Model Layer
```dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar_url': avatarUrl,
    };
  }
}
```

### The ViewModel Layer
```dart
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;
  
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  Future<void> loadUser(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      _user = await _apiService.fetchUser(userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load user: \$e';
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> updateProfile(String name, String email) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _user = await _apiService.updateUser(
        userId: _user!.id,
        name: name,
        email: email,
      );
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to update profile: \$e';
      _isLoading = false;
      notifyListeners();
    }
  }
}
```

💡 Notice how we handle loading states and errors in the ViewModel. This keeps the View simple and focused on UI rendering.

## Best Practices

Following these best practices will help you get the most out of MVVM in your Flutter projects.

### Keep ViewModels Testable

Never import Flutter widgets in ViewModels. This makes unit testing much easier.
```dart
// ❌ Bad - Importing Flutter
import 'package:flutter/material.dart';

class BadViewModel extends ChangeNotifier {
  void showDialog(BuildContext context) {
    // Don't do this!
  }
}

// ✅ Good - No Flutter imports
import 'package:flutter/foundation.dart';

class GoodViewModel extends ChangeNotifier {
  void handleAction() {
    // Business logic only
  }
}
```

### Use Dependency Injection

Pass dependencies through constructors for better testability and flexibility.
```dart
class UserViewModel extends ChangeNotifier {
  final ApiService apiService;
  final StorageService storageService;
  
  UserViewModel({
    required this.apiService,
    required this.storageService,
  });
}
```

### Single Responsibility Principle

Each ViewModel should handle one feature or screen. Don't create god ViewModels that do everything.
```dart
// ✅ Good - Focused ViewModels
class LoginViewModel extends ChangeNotifier { }
class ProfileViewModel extends ChangeNotifier { }
class SettingsViewModel extends ChangeNotifier { }

// ❌ Bad - God ViewModel
class AppViewModel extends ChangeNotifier {
  // Too many responsibilities!
}
```

⚠️ Violating the Single Responsibility Principle makes your code harder to test and maintain.

### Dispose Resources Properly

Always dispose of resources when ViewModel is destroyed to prevent memory leaks.
```dart
class MyViewModel extends ChangeNotifier {
  final StreamController _controller = StreamController();
  final Timer _timer;
  
  @override
  void dispose() {
    _controller.close();
    _timer.cancel();
    super.dispose();
  }
}
```

## Testing ViewModels

One of the biggest advantages of MVVM is how easy it makes testing. Here's how to test your ViewModels effectively.
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('CounterViewModel Tests', () {
    late CounterViewModel viewModel;
    
    setUp(() {
      viewModel = CounterViewModel();
    });
    
    test('Initial count should be 0', () {
      expect(viewModel.count, 0);
    });
    
    test('Increment should increase count', () {
      viewModel.increment();
      expect(viewModel.count, 1);
    });
    
    test('Decrement should not go below 0', () {
      viewModel.decrement();
      expect(viewModel.count, 0);
    });
    
    test('Reset should set count to 0', () {
      viewModel.increment();
      viewModel.increment();
      viewModel.reset();
      expect(viewModel.count, 0);
    });
    
    tearDown(() {
      viewModel.dispose();
    });
  });
}
```

✅ Notice how we can test the ViewModel without any Flutter dependencies. This makes tests fast and reliable.

## Common Pitfalls to Avoid

Learn from common mistakes to write better MVVM code.

### Calling notifyListeners Too Often

Excessive calls to notifyListeners cause unnecessary rebuilds and hurt performance.
```dart
// ❌ Bad - Multiple notifies
void updateMultipleValues() {
  value1 = 10;
  notifyListeners();
  value2 = 20;
  notifyListeners();
  value3 = 30;
  notifyListeners();
}

// ✅ Good - Single notify
void updateMultipleValues() {
  value1 = 10;
  value2 = 20;
  value3 = 30;
  notifyListeners();
}
```

### Not Handling Loading States

Always show loading indicators during async operations to improve user experience.
```dart
// ✅ Good - Proper loading handling
Future<void> loadData() async {
  _isLoading = true;
  notifyListeners();
  
  try {
    _data = await apiService.fetchData();
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}
```

### Mixing UI Logic in ViewModel

Keep ViewModels free from UI-specific code like navigation and dialogs.
```dart
// ❌ Bad - UI logic in ViewModel
void handleButtonPress(BuildContext context) {
  Navigator.push(context, ...);
}

// ✅ Good - Business logic only
void handleButtonPress() {
  // Process data
  // View handles navigation
}
```

## Advanced Patterns

Take your MVVM implementation to the next level with these advanced techniques.

### Combining MVVM with BLoC

For complex state management, you can combine MVVM with BLoC pattern.
```dart
class UserViewModel extends ChangeNotifier {
  final UserBloc userBloc;
  
  UserViewModel(this.userBloc) {
    userBloc.stream.listen((state) {
      notifyListeners();
    });
  }
}
```

### Using Riverpod Instead of Provider

Riverpod offers compile-time safety and better testing support than Provider.
```dart
final counterProvider = ChangeNotifierProvider((ref) {
  return CounterViewModel();
});

// In widget
final viewModel = ref.watch(counterProvider);
```

📝 Riverpod is the recommended choice for new projects due to its improved API and better developer experience.

## Conclusion

MVVM is a powerful architectural pattern that brings structure and maintainability to your Flutter applications. By separating concerns into Model, View, and ViewModel layers, you create apps that are:

- Easier to test and debug
- More maintainable and scalable
- Better organized and structured
- Team-friendly and collaborative
- Reusable and modular

Start implementing MVVM in your next Flutter project and experience the benefits of clean architecture. Your future self will thank you!

✅ Remember: Good architecture is an investment in your app's future. Take the time to do it right from the start.

## Resources and Further Reading

Want to learn more about MVVM and Flutter architecture? Check out these resources:

- Official Flutter Documentation
- Provider Package Documentation
- MVVM Design Pattern (Wikipedia)
- Clean Architecture by Robert C. Martin
- Flutter Architecture Samples on GitHub

Happy coding! 🚀
''',
      ),

      // Regular Posts
      BlogPostModel(
        id: 'flutter-animations-guide',
        title: 'Mastering Flutter Animations: A Complete Guide',
        excerpt:
            'Deep dive into Flutter animations with practical examples. Learn implicit animations, explicit animations, and custom animation controllers.',
        imagePath: 'assets/blog/post_1.png',
        publishedDate: 'Nov 5, 2024',
        readingTime: '12 min read',
        tags: ['Flutter', 'Animations', 'UI/UX'],
        viewCount: 890,
      ),

      BlogPostModel(
        id: 'state-management-comparison',
        title: 'State Management in Flutter: Provider vs BLoC vs Riverpod',
        excerpt:
            'Comprehensive comparison of popular state management solutions. Which one should you choose for your next project?',
        imagePath: 'assets/blog/post_2.png',
        publishedDate: 'Oct 28, 2024',
        readingTime: '10 min read',
        tags: ['Flutter', 'Provider', 'BLoC', 'State Management'],
        viewCount: 1520,
      ),

      BlogPostModel(
        id: 'flutter-performance-optimization',
        title: '10 Performance Optimization Tips for Flutter Apps',
        excerpt:
            'Proven techniques to make your Flutter app faster and more responsive. From widget rebuilds to memory management.',
        imagePath: 'assets/blog/post_3.png',
        publishedDate: 'Oct 20, 2024',
        readingTime: '7 min read',
        tags: ['Flutter', 'Performance', 'Optimization'],
        viewCount: 2100,
      ),

      BlogPostModel(
        id: 'firebase-integration-guide',
        title: 'Complete Firebase Integration Guide for Flutter',
        excerpt:
            'Step-by-step tutorial on integrating Firebase Authentication, Firestore, and Cloud Storage in your Flutter app.',
        imagePath: 'assets/blog/post_4.png',
        publishedDate: 'Oct 15, 2024',
        readingTime: '15 min read',
        tags: ['Flutter', 'Firebase', 'Backend'],
        viewCount: 1780,
      ),

      BlogPostModel(
        id: 'responsive-design-flutter',
        title: 'Building Responsive UIs in Flutter: Best Practices',
        excerpt:
            'Learn how to create adaptive layouts that work seamlessly across mobile, tablet, and desktop platforms.',
        imagePath: 'assets/blog/post_5.png',
        publishedDate: 'Oct 8, 2024',
        readingTime: '9 min read',
        tags: ['Flutter', 'Responsive', 'UI/UX'],
        viewCount: 950,
      ),

      BlogPostModel(
        id: 'flutter-testing-guide',
        title: 'Testing in Flutter: Unit, Widget, and Integration Tests',
        excerpt:
            'Complete guide to writing effective tests for your Flutter applications. Ensure code quality and reliability.',
        imagePath: 'assets/blog/post_6.png',
        publishedDate: 'Oct 1, 2024',
        readingTime: '11 min read',
        tags: ['Flutter', 'Testing', 'Quality Assurance'],
        viewCount: 720,
      ),
    ];
  }

  /// Get featured post
  static BlogPostModel? getFeaturedPost() {
    return getAllPosts().firstWhere((post) => post.isFeatured);
  }

  /// Get regular posts (non-featured)
  static List<BlogPostModel> getRegularPosts() {
    return getAllPosts().where((post) => !post.isFeatured).toList();
  }

  static BlogPostModel? getPostById(String id) {
    try {
      return getAllPosts().firstWhere((post) => post.id == id);
    } catch (e) {
      return null;
    }
  }
}
