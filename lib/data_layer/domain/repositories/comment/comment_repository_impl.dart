import 'package:fpdart/fpdart.dart';
import 'comment_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../entities/blog/comment.dart';
import '../../../model/blog/comment_model.dart';
import '../../../data_sources/remote/comment/comment_remote_datasource.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource remoteDataSource;
  final bool useFirebase;

  CommentRepositoryImpl({required this.remoteDataSource, this.useFirebase = false});

  @override
  Future<Either<Failure, List<Comment>>> getCommentsByPostId(String postId) async {
    try {
      if (useFirebase) {
        final comments = await remoteDataSource.getCommentsByPostId(postId);
        return Right(comments);
      } else {
        // Static data
        final comments = CommentModel.getSampleComments(postId);
        await Future.delayed(const Duration(milliseconds: 500));
        return Right(comments);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load comments: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Comment>> getCommentById(String commentId) async {
    try {
      if (useFirebase) {
        final comment = await remoteDataSource.getCommentById(commentId);
        return Right(comment);
      } else {
        return Left(NotFoundFailure(message: 'Comment not found'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load comment'));
    }
  }

  @override
  Future<Either<Failure, Comment>> addComment(Comment comment) async {
    try {
      if (useFirebase) {
        final newComment = await remoteDataSource.addComment(CommentModel.fromEntity(comment));
        return Right(newComment);
      } else {
        // Simulate adding comment (static mode)
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
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to add comment'));
    }
  }

  @override
  Future<Either<Failure, Comment>> addReply({required String parentId, required Comment reply}) async {
    try {
      if (useFirebase) {
        final newReply = await remoteDataSource.addReply(parentId: parentId, reply: CommentModel.fromEntity(reply));
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
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to add reply'));
    }
  }

  @override
  Future<Either<Failure, void>> updateComment(Comment comment) async {
    try {
      if (!useFirebase) {
        return Left(ServerFailure(message: 'Firebase not configured'));
      }
      await remoteDataSource.updateComment(CommentModel.fromEntity(comment));
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to update comment'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteComment(String commentId) async {
    try {
      if (!useFirebase) {
        return Left(ServerFailure(message: 'Firebase not configured'));
      }
      await remoteDataSource.deleteComment(commentId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to delete comment'));
    }
  }

  @override
  Future<Either<Failure, void>> likeComment(String commentId) async {
    try {
      if (useFirebase) {
        await remoteDataSource.likeComment(commentId);
      }
      // Static mode: handled locally in provider
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to like comment'));
    }
  }

  @override
  Future<Either<Failure, void>> unlikeComment(String commentId) async {
    try {
      if (useFirebase) {
        await remoteDataSource.unlikeComment(commentId);
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to unlike comment'));
    }
  }

  @override
  Future<Either<Failure, int>> getCommentCount(String postId) async {
    try {
      if (useFirebase) {
        final count = await remoteDataSource.getCommentCount(postId);
        return Right(count);
      } else {
        final comments = CommentModel.getSampleComments(postId);
        final total = comments.length + comments.fold(0, (sum, c) => sum + c.replies.length);
        return Right(total.toInt());
      }
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get comment count'));
    }
  }

  @override
  Future<Either<Failure, void>> reportComment({required String commentId, required String reason}) async {
    try {
      if (useFirebase) {
        await remoteDataSource.reportComment(commentId: commentId, reason: reason);
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to report comment'));
    }
  }
}
