import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/exceptions.dart';
import '../../../model/blog/comment_model.dart';

abstract class CommentRemoteDataSource {
  Future<List<CommentModel>> getCommentsByPostId(String postId);
  Future<CommentModel> getCommentById(String commentId);
  Future<CommentModel> addComment(CommentModel comment);
  Future<CommentModel> addReply({required String parentId, required CommentModel reply});
  Future<void> updateComment(CommentModel comment);
  Future<void> deleteComment(String commentId);
  Future<void> likeComment(String commentId);
  Future<void> unlikeComment(String commentId);
  Future<int> getCommentCount(String postId);
  Future<void> reportComment({required String commentId, required String reason});
}

class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  final FirebaseFirestore? firestore;

  CommentRemoteDataSourceImpl({this.firestore});

  CollectionReference? get _commentsCollection => firestore?.collection('comments');

  void _checkFirebaseAvailable() {
    if (firestore == null || _commentsCollection == null) {
      throw ServerException('Firebase not initialized');
    }
  }

  @override
  Future<List<CommentModel>> getCommentsByPostId(String postId) async {
    try {
      _checkFirebaseAvailable();

      // Get parent comments (no parentId)
      final querySnapshot = await _commentsCollection!
          .where('postId', isEqualTo: postId)
          .where('isApproved', isEqualTo: true)
          .where('parentId', isNull: true)
          .orderBy('timestamp', descending: true)
          .get();

      final comments = <CommentModel>[];

      for (final doc in querySnapshot.docs) {
        final comment = CommentModel.fromFirestore(doc);

        // Load replies for this comment
        final repliesSnapshot = await _commentsCollection!
            .where('parentId', isEqualTo: comment.id)
            .where('isApproved', isEqualTo: true)
            .orderBy('timestamp', descending: false)
            .get();

        final replies = repliesSnapshot.docs.map((d) => CommentModel.fromFirestore(d)).toList();

        comments.add(comment.copyWith(replies: replies));
      }

      return comments;
    } catch (e) {
      throw ServerException('Failed to fetch comments: ${e.toString()}');
    }
  }

  @override
  Future<CommentModel> getCommentById(String commentId) async {
    try {
      _checkFirebaseAvailable();

      final doc = await _commentsCollection!.doc(commentId).get();

      if (!doc.exists) {
        throw ServerException('Comment not found');
      }

      return CommentModel.fromFirestore(doc);
    } catch (e) {
      throw ServerException('Failed to fetch comment: ${e.toString()}');
    }
  }

  @override
  Future<CommentModel> addComment(CommentModel comment) async {
    try {
      _checkFirebaseAvailable();

      final docRef = await _commentsCollection!.add(comment.toFirestore());
      final newDoc = await docRef.get();

      return CommentModel.fromFirestore(newDoc);
    } catch (e) {
      throw ServerException('Failed to add comment: ${e.toString()}');
    }
  }

  @override
  Future<CommentModel> addReply({required String parentId, required CommentModel reply}) async {
    try {
      _checkFirebaseAvailable();

      final replyWithParent = reply.copyWith(parentId: parentId);
      final docRef = await _commentsCollection!.add(replyWithParent.toFirestore());
      final newDoc = await docRef.get();

      return CommentModel.fromFirestore(newDoc);
    } catch (e) {
      throw ServerException('Failed to add reply: ${e.toString()}');
    }
  }

  @override
  Future<void> updateComment(CommentModel comment) async {
    try {
      _checkFirebaseAvailable();

      await _commentsCollection!.doc(comment.id).update(comment.toFirestore());
    } catch (e) {
      throw ServerException('Failed to update comment: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteComment(String commentId) async {
    try {
      _checkFirebaseAvailable();

      // Delete comment
      await _commentsCollection!.doc(commentId).delete();

      // Delete all replies
      final repliesSnapshot = await _commentsCollection!.where('parentId', isEqualTo: commentId).get();

      for (final doc in repliesSnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw ServerException('Failed to delete comment: ${e.toString()}');
    }
  }

  @override
  Future<void> likeComment(String commentId) async {
    try {
      _checkFirebaseAvailable();

      await _commentsCollection!.doc(commentId).update({'likes': FieldValue.increment(1)});
    } catch (e) {
      throw ServerException('Failed to like comment: ${e.toString()}');
    }
  }

  @override
  Future<void> unlikeComment(String commentId) async {
    try {
      _checkFirebaseAvailable();

      await _commentsCollection!.doc(commentId).update({'likes': FieldValue.increment(-1)});
    } catch (e) {
      throw ServerException('Failed to unlike comment: ${e.toString()}');
    }
  }

  @override
  Future<int> getCommentCount(String postId) async {
    try {
      _checkFirebaseAvailable();

      final snapshot = await _commentsCollection!
          .where('postId', isEqualTo: postId)
          .where('isApproved', isEqualTo: true)
          .count()
          .get();

      return snapshot.count ?? 0;
    } catch (e) {
      throw ServerException('Failed to get comment count: ${e.toString()}');
    }
  }

  @override
  Future<void> reportComment({required String commentId, required String reason}) async {
    try {
      _checkFirebaseAvailable();

      await firestore!.collection('comment_reports').add({
        'commentId': commentId,
        'reason': reason,
        'timestamp': Timestamp.now(),
        'status': 'pending',
      });
    } catch (e) {
      throw ServerException('Failed to report comment: ${e.toString()}');
    }
  }
}
