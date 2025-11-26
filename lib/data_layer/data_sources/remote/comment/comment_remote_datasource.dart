import '../../../../core/error/exceptions.dart';
import '../../../model/blog/comment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  final SupabaseClient? supabase;
  CommentRemoteDataSourceImpl({this.supabase});

  // ==================== GET COMMENTS BY POST ID ====================
  @override
  Future<List<CommentModel>> getCommentsByPostId(String postId) async {
    try {
      // Get parent comments (no parent_id)
      final response = await supabase!
          .from('comments')
          .select()
          .eq('post_id', postId)
          .eq('is_approved', true)
          .filter('parent_id', 'is', null)
          .order('timestamp', ascending: false);

      final comments = <CommentModel>[];

      for (final commentJson in response as List) {
        final comment = CommentModel.fromSupabase(commentJson);

        // Load replies for this comment
        final repliesResponse = await supabase!
            .from('comments')
            .select()
            .eq('parent_id', comment.id)
            .eq('is_approved', true)
            .order('timestamp', ascending: true);

        final replies = (repliesResponse as List).map((json) => CommentModel.fromSupabase(json)).toList();

        comments.add(comment.copyWith(replies: replies));
      }

      return comments;
    } catch (e) {
      throw ExceptionHandler.parse(e, context: 'Fetching comments for post "$postId"');
    }
  }

  // ==================== GET COMMENT BY ID ====================
  @override
  Future<CommentModel> getCommentById(String commentId) async {
    try {
      final response = await supabase!.from('comments').select().eq('id', commentId).maybeSingle();

      if (response == null) {
        throw NotFoundException('Comment with ID "$commentId" not found');
      }

      return CommentModel.fromSupabase(response);
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Fetching comment by ID');
    }
  }

  // ==================== ADD COMMENT ====================
  @override
  Future<CommentModel> addComment(CommentModel comment) async {
    try {
      final response = await supabase!.from('comments').insert(comment.toSupabase()).select().single();

      return CommentModel.fromSupabase(response);
    } catch (e) {
      throw ExceptionHandler.parse(e, context: 'Adding comment');
    }
  }

  // ==================== ADD REPLY ====================
  @override
  Future<CommentModel> addReply({required String parentId, required CommentModel reply}) async {
    try {
      // Verify parent comment exists
      final parentExists = await supabase!.from('comments').select('id').eq('id', parentId).maybeSingle();

      if (parentExists == null) {
        throw NotFoundException('Parent comment with ID "$parentId" not found');
      }

      final replyWithParent = reply.copyWith(parentId: parentId);

      final response = await supabase!
          .from('comments')
          .insert(replyWithParent.toSupabase())
          .select()
          .single();

      return CommentModel.fromSupabase(response);
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Adding reply to comment');
    }
  }

  // ==================== UPDATE COMMENT ====================
  @override
  Future<void> updateComment(CommentModel comment) async {
    try {
      final response = await supabase!
          .from('comments')
          .update(comment.toSupabase())
          .eq('id', comment.id)
          .select();

      if (response.isEmpty) {
        throw NotFoundException('Comment with ID "${comment.id}" not found');
      }
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Updating comment');
    }
  }

  // ==================== DELETE COMMENT ====================
  @override
  Future<void> deleteComment(String commentId) async {
    try {
      // Delete all replies first (cascade delete)
      await supabase!.from('comments').delete().eq('parent_id', commentId);

      // Delete the comment itself
      final response = await supabase!.from('comments').delete().eq('id', commentId).select();

      if (response.isEmpty) {
        throw NotFoundException('Comment with ID "$commentId" not found');
      }
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Deleting comment');
    }
  }

  // ==================== LIKE COMMENT ====================
  @override
  Future<void> likeComment(String commentId) async {
    try {
      // Get current likes count
      final response = await supabase!.from('comments').select('likes').eq('id', commentId).maybeSingle();

      if (response == null) {
        throw NotFoundException('Comment with ID "$commentId" not found');
      }

      final currentLikes = response['likes'] as int? ?? 0;

      // Increment likes
      await supabase!.from('comments').update({'likes': currentLikes + 1}).eq('id', commentId);
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Liking comment');
    }
  }

  // ==================== UNLIKE COMMENT ====================
  @override
  Future<void> unlikeComment(String commentId) async {
    try {
      // Get current likes count
      final response = await supabase!.from('comments').select('likes').eq('id', commentId).maybeSingle();

      if (response == null) {
        throw NotFoundException('Comment with ID "$commentId" not found');
      }

      final currentLikes = response['likes'] as int? ?? 0;

      // Decrement likes (don't go below 0)
      final newLikes = currentLikes > 0 ? currentLikes - 1 : 0;

      await supabase!.from('comments').update({'likes': newLikes}).eq('id', commentId);
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Unliking comment');
    }
  }

  // ==================== GET COMMENT COUNT ====================
  @override
  Future<int> getCommentCount(String postId) async {
    try {
      final count = await supabase!
          .from('comments')
          .select()
          .eq('post_id', postId)
          .eq('is_approved', true)
          .count(CountOption.exact);

      return count.count;
    } catch (e) {
      throw ExceptionHandler.parse(e, context: 'Getting comment count');
    }
  }

  // ==================== REPORT COMMENT ====================
  @override
  Future<void> reportComment({required String commentId, required String reason}) async {
    try {
      if (reason.trim().isEmpty) {
        throw ValidationException('Report reason cannot be empty');
      }

      // Verify comment exists
      final commentExists = await supabase!.from('comments').select('id').eq('id', commentId).maybeSingle();

      if (commentExists == null) {
        throw NotFoundException('Comment with ID "$commentId" not found');
      }

      // Insert report
      await supabase!.from('comment_reports').insert({
        'comment_id': commentId,
        'reason': reason.trim(),
        'timestamp': DateTime.now().toIso8601String(),
        'status': 'pending',
      });
    } catch (e) {
      if (e is NotFoundException || e is ValidationException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Reporting comment');
    }
  }
}
