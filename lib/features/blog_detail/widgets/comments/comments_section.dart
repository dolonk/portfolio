import 'widgets/comment_card.dart';
import 'package:flutter/material.dart';
import 'widgets/submit_comment_button.dart';
import 'widgets/discussion_on_twitter_button.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import '../../../../data_layer/domain/entities/blog/blog_post.dart';
import 'package:portfolio/data_layer/model/blog/comment_model.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';

enum CommentSort { newest, oldest, mostLiked }

class CommentsSection extends StatefulWidget {
  final BlogPost post;

  const CommentsSection({super.key, required this.post});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  List<CommentModel> _comments = [];
  CommentSort _sortBy = CommentSort.newest;
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _loadComments() {
    setState(() {
      _comments = CommentModel.getSampleComments(widget.post.id);
      _sortComments();
    });
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

  void _submitComment() async {
    if (_commentController.text.trim().isEmpty) return;

    setState(() => _isSubmitting = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      final newComment = CommentModel(
        id: 'comment-${DateTime.now().millisecondsSinceEpoch}',
        authorName: 'You',
        authorImage: 'assets/home/hero/dolon.png',
        content: _commentController.text.trim(),
        timestamp: DateTime.now(),
        likes: 0,
      );

      setState(() {
        _comments.insert(0, newComment);
        _commentController.clear();
        _isSubmitting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Colors.white),
              SizedBox(width: 12),
              Text('Comment posted successfully!'),
            ],
          ),
          backgroundColor: DColors.primaryButton,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  void _likeComment(String commentId) {
    setState(() {
      _comments = _comments.map((comment) {
        if (comment.id == commentId) {
          return comment.copyWith(likes: comment.likes + 1);
        }
        // Check replies
        final updatedReplies = comment.replies.map((reply) {
          if (reply.id == commentId) {
            return reply.copyWith(likes: reply.likes + 1);
          }
          return reply;
        }).toList();
        return comment.copyWith(replies: updatedReplies);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 700, desktop: 900),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with count and sort
              _buildHeader(context, s),
              SizedBox(height: s.spaceBtwItems),

              // Twitter Discuss Button
              DiscussOnTwitterButton(post: widget.post),
              SizedBox(height: s.spaceBtwItems),

              // Divider
              Divider(color: DColors.cardBorder),
              SizedBox(height: s.spaceBtwItems),

              // Add Comment Form
              _buildAddCommentForm(context, s),
              SizedBox(height: s.spaceBtwItems),

              // Comments List
              _buildCommentsList(context, s),
            ],
          ),
        ),
      ),
    );
  }

  /// Header with count and sort
  Widget _buildHeader(BuildContext context, DSizes s) {
    final fonts = context.fonts;
    final totalComments = _comments.length + _comments.fold(0, (sum, c) => sum + c.replies.length);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Title + Count
        Row(
          children: [
            Icon(Icons.comment_rounded, color: DColors.primaryButton, size: 24),
            SizedBox(width: s.paddingSm),
            Text(
              'Comments',
              style: fonts.titleLarge.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
            ),
            SizedBox(width: s.paddingSm),
            Container(
              padding: EdgeInsets.symmetric(horizontal: s.paddingSm, vertical: 4),
              decoration: BoxDecoration(
                color: DColors.primaryButton.withAlpha((255 * 0.1).round()),
                borderRadius: BorderRadius.circular(s.borderRadiusSm),
              ),
              child: Text(
                '$totalComments',
                style: fonts.labelSmall.rubik(color: DColors.primaryButton, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),

        // Sort Dropdown
        _buildSortDropdown(context, s),
      ],
    );
  }

  /// Sort Dropdown
  Widget _buildSortDropdown(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return PopupMenuButton<CommentSort>(
      initialValue: _sortBy,
      color: DColors.cardBackground,
      onSelected: (value) {
        setState(() {
          _sortBy = value;
          _sortComments();
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
        decoration: BoxDecoration(
          color: DColors.cardBackground,
          borderRadius: BorderRadius.circular(s.borderRadiusSm),
          border: Border.all(color: DColors.cardBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.sort_rounded, color: DColors.textSecondary, size: 18),
            SizedBox(width: s.paddingXs),
            Text(_getSortLabel(_sortBy), style: fonts.bodySmall.rubik(color: DColors.textSecondary)),
          ],
        ),
      ),
      itemBuilder: (context) => [
        _buildSortMenuItem(CommentSort.newest, 'Newest First', fonts),
        _buildSortMenuItem(CommentSort.oldest, 'Oldest First', fonts),
        _buildSortMenuItem(CommentSort.mostLiked, 'Most Liked', fonts),
      ],
    );
  }

  PopupMenuItem<CommentSort> _buildSortMenuItem(CommentSort value, String label, AppFonts fonts) {
    return PopupMenuItem<CommentSort>(
      value: value,
      child: Text(
        label,
        style: fonts.bodySmall.rubik(
          color: _sortBy == value ? DColors.primaryButton : DColors.textPrimary,
          fontWeight: _sortBy == value ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  String _getSortLabel(CommentSort sort) {
    switch (sort) {
      case CommentSort.newest:
        return 'Newest';
      case CommentSort.oldest:
        return 'Oldest';
      case CommentSort.mostLiked:
        return 'Most Liked';
    }
  }

  /// Add Comment Form
  Widget _buildAddCommentForm(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Container(
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Leave a Comment',
            style: fonts.titleMedium.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
          ),
          SizedBox(height: s.paddingMd),
          TextField(
            controller: _commentController,
            maxLines: 4,
            style: fonts.bodyMedium.rubik(color: DColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Share your thoughts...',
              hintStyle: fonts.bodyMedium.rubik(color: DColors.textSecondary),
              filled: true,
              fillColor: DColors.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(s.borderRadiusMd),
                borderSide: BorderSide(color: DColors.cardBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(s.borderRadiusMd),
                borderSide: BorderSide(color: DColors.cardBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(s.borderRadiusMd),
                borderSide: BorderSide(color: DColors.primaryButton, width: 2),
              ),
            ),
          ),
          SizedBox(height: s.paddingMd),
          Align(
            alignment: Alignment.centerRight,
            child: SubmitCommentButton(onPressed: _submitComment, isSubmitting: _isSubmitting),
          ),
        ],
      ),
    );
  }

  /// Comments List
  Widget _buildCommentsList(BuildContext context, DSizes s) {
    if (_comments.isEmpty) {
      return _buildEmptyState(context, s);
    }

    return Column(
      children: _comments.map((comment) {
        return CommentCard(
          comment: comment,
          onLike: () => _likeComment(comment.id),
          onReplyLike: (replyId) => _likeComment(replyId),
        );
      }).toList(),
    );
  }

  /// Empty State
  Widget _buildEmptyState(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Container(
      padding: EdgeInsets.all(s.paddingXl * 2),
      child: Column(
        children: [
          Icon(Icons.chat_bubble_outline_rounded, color: DColors.textSecondary, size: 60),
          SizedBox(height: s.paddingMd),
          Text(
            'No comments yet',
            style: fonts.titleMedium.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
          ),
          SizedBox(height: s.paddingSm),
          Text('Be the first to share your thoughts!', style: fonts.bodyMedium.rubik(color: DColors.textSecondary)),
        ],
      ),
    );
  }
}
