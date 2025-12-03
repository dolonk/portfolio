import 'package:flutter/material.dart';
import '../../../../core/state/data_state.dart';
import '../../../../data_layer/domain/entities/blog/comment.dart';
import '../../../../data_layer/domain/repositories/comment/comment_repository.dart';


enum CommentSort { newest, oldest, mostLiked }

class CommentProvider with ChangeNotifier {
  final CommentRepository repository;

  CommentProvider({required this.repository});

  // ==================== STATE HOLDERS ====================
  DataState<List<Comment>> _commentsState = DataState.initial();
  DataState<Comment> _addCommentState = DataState.initial();

  String _currentPostId = '';
  CommentSort _sortBy = CommentSort.newest;
  List<Comment> _comments = [];
  final Set<String> _likedCommentIds = {};

  // ==================== PUBLIC GETTERS ====================
  DataState<List<Comment>> get commentsState => _commentsState;
  DataState<Comment> get addCommentState => _addCommentState;

  List<Comment> get comments => _comments;
  CommentSort get sortBy => _sortBy;
  int get totalCommentCount => _comments.length + _comments.fold(0, (sum, c) => sum + c.replyCount);

  bool get isLoading => _commentsState.isLoading;
  bool get hasError => _commentsState.hasError;
  bool get isEmpty => _commentsState.isEmpty;
  String? get errorMessage => _commentsState.errorMessage;

  bool get isAddingComment => _addCommentState.isLoading;

  // ==================== FETCH COMMENTS ====================
  /// Load comments for a post
  Future<void> fetchComments(String postId) async {
    _currentPostId = postId;
    _commentsState = DataState.loading();
    notifyListeners();

    final result = await repository.getCommentsByPostId(postId);

    result.fold(
      (failure) {
        _commentsState = DataState.error(failure.message);
        _comments = [];
        debugPrint('❌ Comments fetch failed: ${failure.message}');
      },
      (comments) {
        _comments = comments;
        _sortComments();
        _commentsState = comments.isEmpty ? DataState.empty() : DataState.success(comments);
        debugPrint('✅ Fetched ${comments.length} comments');
      },
    );

    notifyListeners();
  }

  // ==================== ADD COMMENT ====================
  /// Add new comment
  Future<bool> addComment({
    required String authorName,
    required String authorEmail,
    required String content,
    required String authorImage,
  }) async {
    if (content.trim().isEmpty) return false;

    _addCommentState = DataState.loading();
    notifyListeners();

    final newComment = Comment(
      id: '',
      postId: _currentPostId,
      authorName: authorName,
      authorEmail: authorEmail,
      authorImage: authorImage,
      content: content.trim(),
      timestamp: DateTime.now(),
    );

    final result = await repository.addComment(newComment);

    return result.fold(
      (failure) {
        _addCommentState = DataState.error(failure.message);
        notifyListeners();
        debugPrint('❌ Add comment failed: ${failure.message}');
        return false;
      },
      (comment) {
        // Add to local list
        _comments.insert(0, comment);
        _sortComments();
        _commentsState = DataState.success(_comments);
        _addCommentState = DataState.success(comment);
        notifyListeners();
        debugPrint('✅ Comment added successfully');
        return true;
      },
    );
  }

  // ==================== ADD REPLY ====================
  /// Add reply to a comment
  Future<bool> addReply({
    required String parentId,
    required String authorName,
    required String authorEmail,
    required String content,
    required String authorImage,
  }) async {
    if (content.trim().isEmpty) return false;

    _addCommentState = DataState.loading();
    notifyListeners();

    final reply = Comment(
      id: '',
      postId: _currentPostId,
      authorName: authorName,
      authorEmail: authorEmail,
      authorImage: authorImage,
      content: content.trim(),
      timestamp: DateTime.now(),
      parentId: parentId,
    );

    final result = await repository.addReply(parentId: parentId, reply: reply);

    return result.fold(
      (failure) {
        _addCommentState = DataState.error(failure.message);
        notifyListeners();
        debugPrint('❌ Add reply failed: ${failure.message}');
        return false;
      },
      (newReply) {
        // Add reply to parent comment
        _comments = _comments.map((comment) {
          if (comment.id == parentId) {
            return comment.copyWith(replies: [...comment.replies, newReply]);
          }
          return comment;
        }).toList();

        _commentsState = DataState.success(_comments);
        _addCommentState = DataState.success(newReply);
        notifyListeners();
        debugPrint('✅ Reply added successfully');
        return true;
      },
    );
  }

  // ==================== LIKE COMMENT ====================
  /// Like a comment (local + remote)
  Future<void> likeComment(String commentId) async {
    // Optimistic update
    if (_likedCommentIds.contains(commentId)) return;

    _likedCommentIds.add(commentId);
    _updateCommentLikes(commentId, increment: true);
    notifyListeners();

    // Remote update (fire and forget)
    await repository.likeComment(commentId);
  }

  /// Unlike a comment
  Future<void> unlikeComment(String commentId) async {
    if (!_likedCommentIds.contains(commentId)) return;

    _likedCommentIds.remove(commentId);
    _updateCommentLikes(commentId, increment: false);
    notifyListeners();

    await repository.unlikeComment(commentId);
  }

  /// Toggle like
  Future<void> toggleLike(String commentId) async {
    if (_likedCommentIds.contains(commentId)) {
      await unlikeComment(commentId);
    } else {
      await likeComment(commentId);
    }
  }

  /// Check if comment is liked
  bool isLiked(String commentId) => _likedCommentIds.contains(commentId);

  // ==================== SORT COMMENTS ====================
  /// Change sort order
  void changeSortOrder(CommentSort sort) {
    print('Dolon babu');
    _sortBy = sort;
    _sortComments();
    notifyListeners();
  }

  void _sortComments() {
    switch (_sortBy) {
      case CommentSort.newest:
        _comments.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        break;
      case CommentSort.oldest:
        _comments.sort((a, b) => a.timestamp.compareTo(b.timestamp));
        break;
      case CommentSort.mostLiked:
        _comments.sort((a, b) => b.likes.compareTo(a.likes));
        break;
    }
  }

  // ==================== DELETE COMMENT ====================
  /// Delete a comment
  Future<bool> deleteComment(String commentId) async {
    final result = await repository.deleteComment(commentId);

    return result.fold(
      (failure) {
        debugPrint('❌ Delete comment failed: ${failure.message}');
        return false;
      },
      (_) {
        // Remove from local list
        _comments.removeWhere((c) => c.id == commentId);
        // Also remove from replies
        _comments = _comments.map((comment) {
          return comment.copyWith(replies: comment.replies.where((r) => r.id != commentId).toList());
        }).toList();

        _commentsState = _comments.isEmpty ? DataState.empty() : DataState.success(_comments);
        notifyListeners();
        debugPrint('✅ Comment deleted');
        return true;
      },
    );
  }

  // ==================== REPORT COMMENT ====================
  /// Report a comment
  Future<bool> reportComment({required String commentId, required String reason}) async {
    final result = await repository.reportComment(commentId: commentId, reason: reason);

    return result.fold(
      (failure) {
        debugPrint('❌ Report failed: ${failure.message}');
        return false;
      },
      (_) {
        debugPrint('✅ Comment reported');
        return true;
      },
    );
  }

  // ==================== UTILITY METHODS ====================
  void _updateCommentLikes(String commentId, {required bool increment}) {
    _comments = _comments.map((comment) {
      if (comment.id == commentId) {
        return comment.copyWith(likes: increment ? comment.likes + 1 : comment.likes - 1);
      }
      // Check replies
      final updatedReplies = comment.replies.map((reply) {
        if (reply.id == commentId) {
          return reply.copyWith(likes: increment ? reply.likes + 1 : reply.likes - 1);
        }
        return reply;
      }).toList();
      return comment.copyWith(replies: updatedReplies);
    }).toList();
  }

  /// Reset state
  void reset() {
    _commentsState = DataState.initial();
    _addCommentState = DataState.initial();
    _comments = [];
    _currentPostId = '';
    _likedCommentIds.clear();
    notifyListeners();
  }

  /// Refresh comments
  Future<void> refresh() async {
    if (_currentPostId.isNotEmpty) {
      await fetchComments(_currentPostId);
    }
  }

  @override
  void dispose() {
    _comments.clear();
    _likedCommentIds.clear();
    super.dispose();
  }
}
