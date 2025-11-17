class CommentModel {
  final String id;
  final String authorName;
  final String authorImage;
  final String content;
  final DateTime timestamp;
  final int likes;
  final String? parentId; // For replies
  final List<CommentModel> replies;

  CommentModel({
    required this.id,
    required this.authorName,
    required this.authorImage,
    required this.content,
    required this.timestamp,
    this.likes = 0,
    this.parentId,
    this.replies = const [],
  });

  /// Get sample comments for blog post
  static List<CommentModel> getSampleComments(String postId) {
    return [
      CommentModel(
        id: 'comment-1',
        authorName: 'Sarah Johnson',
        authorImage: 'assets/home/hero/dolon.png',
        content:
            'Great article! MVVM has really helped organize my Flutter projects. The code examples are super clear and easy to follow. Thanks for sharing!',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        likes: 12,
        replies: [
          CommentModel(
            id: 'reply-1-1',
            authorName: 'Dolon Kumar',
            authorImage: 'assets/home/hero/dolon.png',
            content:
                'Thanks Sarah! Glad it was helpful. Let me know if you have any questions about implementing it in your projects.',
            timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
            likes: 5,
            parentId: 'comment-1',
          ),
          CommentModel(
            id: 'reply-1-2',
            authorName: 'Mike Chen',
            authorImage: 'assets/home/hero/dolon.png',
            content: 'I agree! The folder structure section was particularly useful.',
            timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 12)),
            likes: 3,
            parentId: 'comment-1',
          ),
        ],
      ),
      CommentModel(
        id: 'comment-2',
        authorName: 'Alex Rodriguez',
        authorImage: 'assets/home/hero/dolon.png',
        content:
            'Quick question: how would you handle state management for forms in MVVM? Should the form logic go in the ViewModel?',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        likes: 8,
        replies: [
          CommentModel(
            id: 'reply-2-1',
            authorName: 'Dolon Kumar',
            authorImage: 'assets/home/hero/dolon.png',
            content:
                'Great question! Yes, form validation logic should go in the ViewModel. Keep the View focused on displaying the UI and capturing user input.',
            timestamp: DateTime.now().subtract(const Duration(hours: 18)),
            likes: 6,
            parentId: 'comment-2',
          ),
        ],
      ),
      CommentModel(
        id: 'comment-3',
        authorName: 'Emily Watson',
        authorImage: 'assets/home/hero/dolon.png',
        content:
            'Been using Provider for state management but this article convinced me to try proper MVVM architecture. Can\'t wait to refactor my app!',
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
        likes: 15,
      ),
      CommentModel(
        id: 'comment-4',
        authorName: 'David Park',
        authorImage: 'assets/home/hero/dolon.png',
        content:
            'The testing section is gold! Finally understand how to properly test ViewModels without Flutter dependencies.',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        likes: 7,
      ),
    ];
  }

  /// Copy with method for updating
  CommentModel copyWith({int? likes, List<CommentModel>? replies}) {
    return CommentModel(
      id: id,
      authorName: authorName,
      authorImage: authorImage,
      content: content,
      timestamp: timestamp,
      likes: likes ?? this.likes,
      parentId: parentId,
      replies: replies ?? this.replies,
    );
  }
}
