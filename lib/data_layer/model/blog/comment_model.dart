import '../../domain/entities/blog/comment.dart';

class CommentModel extends Comment {
  const CommentModel({
    required super.id,
    required super.postId,
    required super.authorName,
    required super.authorEmail,
    required super.authorImage,
    required super.content,
    required super.timestamp,
    super.likes,
    super.parentId,
    super.replies,
    super.isApproved,
    super.isAuthorReply,
  });

  // ==================== FIREBASE CONVERSION ====================

  /// Create CommentModel from Supabase response
  factory CommentModel.fromSupabase(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      postId: json['post_id'] as String,
      parentId: json['parent_id'] as String?,
      authorName: json['author_name'] as String,
      authorEmail: json['author_email'] as String,
      authorImage: json['author_image'] as String? ?? '',
      content: json['content'] as String,
      likes: json['likes'] as int? ?? 0,
      isApproved: json['is_approved'] as bool? ?? false,
      isAuthorReply: json['is_author_reply'] as bool? ?? false,
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp'] as String) : DateTime.now(),
      replies: [], // Replies loaded separately
    );
  }

  /// Convert CommentModel to Supabase JSON
  Map<String, dynamic> toSupabase() {
    return {
      'id': id,
      'post_id': postId,
      'parent_id': parentId,
      'author_name': authorName,
      'author_email': authorEmail,
      'author_image': authorImage,
      'content': content,
      'likes': likes,
      'is_approved': isApproved,
      'is_author_reply': isAuthorReply,
      'timestamp': timestamp.toIso8601String(),
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  /// JSON to Model (for static data)
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? '',
      postId: json['postId'] ?? '',
      authorName: json['authorName'] ?? 'Anonymous',
      authorEmail: json['authorEmail'] ?? '',
      authorImage: json['authorImage'] ?? 'assets/home/hero/default_avatar.png',
      content: json['content'] ?? '',
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : DateTime.now(),
      likes: json['likes'] ?? 0,
      parentId: json['parentId'],
      isApproved: json['isApproved'] ?? true,
      isAuthorReply: json['isAuthorReply'] ?? false,
      replies: (json['replies'] as List<dynamic>?)?.map((r) => CommentModel.fromJson(r)).toList() ?? [],
    );
  }

  /// Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'authorName': authorName,
      'authorEmail': authorEmail,
      'authorImage': authorImage,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'likes': likes,
      'parentId': parentId,
      'isApproved': isApproved,
      'isAuthorReply': isAuthorReply,
      'replies': replies.map((r) => (r as CommentModel).toJson()).toList(),
    };
  }

  /// Create from Entity
  factory CommentModel.fromEntity(Comment comment) {
    return CommentModel(
      id: comment.id,
      postId: comment.postId,
      authorName: comment.authorName,
      authorEmail: comment.authorEmail,
      authorImage: comment.authorImage,
      content: comment.content,
      timestamp: comment.timestamp,
      likes: comment.likes,
      parentId: comment.parentId,
      replies: comment.replies,
      isApproved: comment.isApproved,
      isAuthorReply: comment.isAuthorReply,
    );
  }

  /// Override copyWith to return CommentModel
  @override
  CommentModel copyWith({
    String? id,
    String? postId,
    String? authorName,
    String? authorEmail,
    String? authorImage,
    String? content,
    DateTime? timestamp,
    int? likes,
    String? parentId,
    List<Comment>? replies,
    bool? isApproved,
    bool? isAuthorReply,
  }) {
    return CommentModel(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      authorName: authorName ?? this.authorName,
      authorEmail: authorEmail ?? this.authorEmail,
      authorImage: authorImage ?? this.authorImage,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
      parentId: parentId ?? this.parentId,
      replies: replies ?? this.replies,
      isApproved: isApproved ?? this.isApproved,
      isAuthorReply: isAuthorReply ?? this.isAuthorReply,
    );
  }

  // ==================== STATIC DATA (Development) ====================
  /// Get sample comments for blog post
  static List<CommentModel> getSampleComments(String postId) {
    return [
      CommentModel(
        id: 'comment-1',
        postId: postId,
        authorName: 'Sarah Johnson',
        authorEmail: 'sarah@example.com',
        authorImage: 'assets/home/icon/sul.png',
        content:
            'Great article! MVVM has really helped organize my Flutter projects. The code examples are super clear and easy to follow. Thanks for sharing!',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        likes: 12,
        isApproved: true,
        replies: [
          CommentModel(
            id: 'reply-1-1',
            postId: postId,
            authorName: 'Dolon Kumar',
            authorEmail: 'dolon@example.com',
            authorImage: 'assets/home/icon/sul.png',
            content:
                'Thanks Sarah! Glad it was helpful. Let me know if you have any questions about implementing it in your projects.',
            timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
            likes: 5,
            parentId: 'comment-1',
            isAuthorReply: true,
          ),
          CommentModel(
            id: 'reply-1-2',
            postId: postId,
            authorName: 'Mike Chen',
            authorEmail: 'mike@example.com',
            authorImage: 'assets/home/icon/sul.png',
            content: 'I agree! The folder structure section was particularly useful.',
            timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 12)),
            likes: 3,
            parentId: 'comment-1',
          ),
        ],
      ),
      CommentModel(
        id: 'comment-2',
        postId: postId,
        authorName: 'Alex Rodriguez',
        authorEmail: 'alex@example.com',
        authorImage: 'assets/home/icon/sul.png',
        content:
            'Quick question: how would you handle state management for forms in MVVM? Should the form logic go in the ViewModel?',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        likes: 8,
        replies: [
          CommentModel(
            id: 'reply-2-1',
            postId: postId,
            authorName: 'Dolon Kumar',
            authorEmail: 'dolon@example.com',
            authorImage: 'assets/home/icon/sul.png',
            content:
                'Great question! Yes, form validation logic should go in the ViewModel. Keep the View focused on displaying the UI and capturing user input.',
            timestamp: DateTime.now().subtract(const Duration(hours: 18)),
            likes: 6,
            parentId: 'comment-2',
            isAuthorReply: true,
          ),
        ],
      ),
      CommentModel(
        id: 'comment-3',
        postId: postId,
        authorName: 'Emily Watson',
        authorEmail: 'emily@example.com',
        authorImage: 'assets/home/icon/sul.png',
        content:
            'Been using Provider for state management but this article convinced me to try proper MVVM architecture. Can\'t wait to refactor my app!',
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
        likes: 15,
      ),
      CommentModel(
        id: 'comment-4',
        postId: postId,
        authorName: 'David Park',
        authorEmail: 'david@example.com',
        authorImage: 'assets/home/icon/sul.png',
        content:
            'The testing section is gold! Finally understand how to properly test ViewModels without Flutter dependencies.',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        likes: 7,
      ),
    ];
  }
}
