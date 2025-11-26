import 'package:fpdart/fpdart.dart';
import 'comment_repository.dart';
import '../../entities/blog/comment.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../model/blog/comment_model.dart';
import '../../../data_sources/remote/comment/comment_remote_datasource.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource remoteDataSource;
  final bool useSupabase;

  CommentRepositoryImpl({required this.remoteDataSource, this.useSupabase = false});

  @override
  Future<Either<Failure, List<Comment>>> getCommentsByPostId(String postId) async {
    try {
      if (useSupabase) {
        final comments = await remoteDataSource.getCommentsByPostId(postId);
        return Right(comments);
      } else {
        // Static data
        final comments = CommentModel.getSampleComments(postId);
        await Future.delayed(const Duration(milliseconds: 500));
        return Right(comments);
      }
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Fetching comments for post $postId'));
    }
  }

  @override
  Future<Either<Failure, Comment>> getCommentById(String commentId) async {
    try {
      if (useSupabase) {
        final comment = await remoteDataSource.getCommentById(commentId);
        return Right(comment);
      } else {
        return Left(NotFoundFailure(message: 'Comment not found'));
      }
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Fetching comment $commentId'));
    }
  }

  @override
  Future<Either<Failure, Comment>> addComment(Comment comment) async {
    try {
      if (useSupabase) {
        final newComment = await remoteDataSource.addComment(CommentModel.fromEntity(comment));
        return Right(newComment);
      } else {
        final newComment = CommentModel(
          id: 'comment-${DateTime.now().millisecondsSinceEpoch}',
          postId: comment.postId,
          authorName: comment.authorName,
          authorEmail: comment.authorEmail,
          authorImage: comment.authorImage,
          content: comment.content,
          timestamp: DateTime.now(),
          likes: 0,
          isApproved: true,
        );
        await Future.delayed(const Duration(milliseconds: 500));
        return Right(newComment);
      }
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Adding new comment'));
    }
  }

  @override
  Future<Either<Failure, Comment>> addReply({required String parentId, required Comment reply}) async {
    try {
      if (useSupabase) {
        final newReply = await remoteDataSource.addReply(
          parentId: parentId,
          reply: CommentModel.fromEntity(reply),
        );
        return Right(newReply);
      } else {
        // Simulate adding reply (static mode)
        final newReply = CommentModel(
          id: 'reply-${DateTime.now().millisecondsSinceEpoch}',
          postId: reply.postId,
          authorName: reply.authorName,
          authorEmail: reply.authorEmail,
          authorImage: reply.authorImage,
          content: reply.content,
          timestamp: DateTime.now(),
          likes: 0,
          parentId: parentId,
          isApproved: true,
        );
        await Future.delayed(const Duration(milliseconds: 500));
        return Right(newReply);
      }
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Adding reply to comment $parentId'));
    }
  }

  @override
  Future<Either<Failure, void>> updateComment(Comment comment) async {
    try {
      if (!useSupabase) {
        return Left(ServerFailure(message: 'Firebase not configured'));
      }
      await remoteDataSource.updateComment(CommentModel.fromEntity(comment));
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Updating comment ${comment.id}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteComment(String commentId) async {
    try {
      if (!useSupabase) {
        return Left(ServerFailure(message: 'Firebase not configured'));
      }
      await remoteDataSource.deleteComment(commentId);
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Deleting comment $commentId'));
    }
  }

  @override
  Future<Either<Failure, void>> likeComment(String commentId) async {
    try {
      if (useSupabase) {
        await remoteDataSource.likeComment(commentId);
      }
      // Static mode: handled locally in provider
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Liking comment $commentId'));
    }
  }

  @override
  Future<Either<Failure, void>> unlikeComment(String commentId) async {
    try {
      if (useSupabase) {
        await remoteDataSource.unlikeComment(commentId);
      }
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Unliking comment $commentId'));
    }
  }

  @override
  Future<Either<Failure, int>> getCommentCount(String postId) async {
    try {
      if (useSupabase) {
        final count = await remoteDataSource.getCommentCount(postId);
        return Right(count);
      } else {
        final comments = CommentModel.getSampleComments(postId);
        final total = comments.length + comments.fold(0, (sum, c) => sum + c.replies.length);
        return Right(total.toInt());
      }
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Getting comment count for post $postId'));
    }
  }

  @override
  Future<Either<Failure, void>> reportComment({required String commentId, required String reason}) async {
    try {
      if (useSupabase) {
        await remoteDataSource.reportComment(commentId: commentId, reason: reason);
      }
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Reporting comment $commentId'));
    }
  }
}
