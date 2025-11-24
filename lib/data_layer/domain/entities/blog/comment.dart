import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String id;
  final String postId;
  final String authorName;
  final String authorEmail;
  final String authorImage;
  final String content;
  final DateTime timestamp;
  final int likes;
  final String? parentId;
  final List<Comment> replies;
  final bool isApproved;
  final bool isAuthorReply;

  const Comment({
    required this.id,
    required this.postId,
    required this.authorName,
    required this.authorEmail,
    required this.authorImage,
    required this.content,
    required this.timestamp,
    this.likes = 0,
    this.parentId,
    this.replies = const [],
    this.isApproved = true,
    this.isAuthorReply = false,
  });

  /// Check if this is a reply
  bool get isReply => parentId != null;

  /// Get total reply count
  int get replyCount => replies.length;

  /// Copy with method
  Comment copyWith({
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
    return Comment(
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

  @override
  List<Object?> get props => [
    id,
    postId,
    authorName,
    authorEmail,
    content,
    timestamp,
    likes,
    parentId,
    replies,
    isApproved,
  ];
}
