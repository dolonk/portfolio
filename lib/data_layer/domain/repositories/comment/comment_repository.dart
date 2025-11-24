import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../entities/blog/comment.dart';

abstract class CommentRepository {
  /// Get all comments for a post
  Future<Either<Failure, List<Comment>>> getCommentsByPostId(String postId);

  /// Get single comment by ID
  Future<Either<Failure, Comment>> getCommentById(String commentId);

  /// Add new comment
  Future<Either<Failure, Comment>> addComment(Comment comment);

  /// Add reply to a comment
  Future<Either<Failure, Comment>> addReply({required String parentId, required Comment reply});

  /// Update comment
  Future<Either<Failure, void>> updateComment(Comment comment);

  /// Delete comment
  Future<Either<Failure, void>> deleteComment(String commentId);

  /// Like a comment
  Future<Either<Failure, void>> likeComment(String commentId);

  /// Unlike a comment
  Future<Either<Failure, void>> unlikeComment(String commentId);

  /// Get comment count for a post
  Future<Either<Failure, int>> getCommentCount(String postId);

  /// Report a comment
  Future<Either<Failure, void>> reportComment({required String commentId, required String reason});
}
