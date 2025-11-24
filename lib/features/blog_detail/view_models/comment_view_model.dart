import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/state/state.dart';
import '../providers/comment_provider.dart';
import '../../../data_layer/domain/entities/blog/comment.dart';

class CommentViewModel {
  final BuildContext context;

  CommentViewModel(this.context);

  // ==================== PROVIDER ACCESS ====================
  CommentProvider get _provider => context.read<CommentProvider>();
  CommentProvider get _watch => context.watch<CommentProvider>();

  // ==================== STATE GETTERS ====================
  DataState<List<Comment>> get commentsState => _watch.commentsState;
  DataState<Comment> get addCommentState => _watch.addCommentState;

  // ==================== DATA GETTERS ====================
  List<Comment> get comments => _watch.comments;
  CommentSort get sortBy => _watch.sortBy;
  int get totalCommentCount => _watch.totalCommentCount;

  // ==================== STATUS GETTERS ====================
  bool get isLoading => _watch.isLoading;
  bool get hasError => _watch.hasError;
  bool get isEmpty => _watch.isEmpty;
  String? get errorMessage => _watch.errorMessage;
  bool get isAddingComment => _watch.isAddingComment;

  // ==================== FETCH ACTIONS ====================
  Future<void> fetchComments(String postId) => _provider.fetchComments(postId);
  Future<void> refresh() => _provider.refresh();

  // ==================== ADD ACTIONS ====================
  Future<bool> addComment({
    required String authorName,
    required String authorEmail,
    required String content,
    String authorImage = "assets/home/icon/sul.png",
  }) => _provider.addComment(
    authorName: authorName,
    authorEmail: authorEmail,
    content: content,
    authorImage: authorImage,
  );

  Future<bool> addReply({
    required String parentId,
    required String authorName,
    required String authorEmail,
    required String content,
    String authorImage = "assets/home/icon/sul.png",
  }) => _provider.addReply(
    parentId: parentId,
    authorName: authorName,
    authorEmail: authorEmail,
    content: content,
    authorImage: authorImage,
  );

  // ==================== LIKE ACTIONS ====================
  Future<void> likeComment(String commentId) => _provider.likeComment(commentId);
  Future<void> unlikeComment(String commentId) => _provider.unlikeComment(commentId);
  Future<void> toggleLike(String commentId) => _provider.toggleLike(commentId);
  bool isLiked(String commentId) => _watch.isLiked(commentId);

  // ==================== SORT ACTIONS ====================
  void changeSortOrder(CommentSort sort) => _provider.changeSortOrder(sort);

  // ==================== OTHER ACTIONS ====================
  Future<bool> deleteComment(String commentId) => _provider.deleteComment(commentId);
  Future<bool> reportComment({required String commentId, required String reason}) =>
      _provider.reportComment(commentId: commentId, reason: reason);

  void reset() => _provider.reset();
}
