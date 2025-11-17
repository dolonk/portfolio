import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/data_layer/model/blog/comment_model.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/data_layer/model/blog/blog_post_model.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:responsive_website/utility/url_launcher_service/url_launcher_service.dart';

enum CommentSort { newest, oldest, mostLiked }

class CommentsSection extends StatefulWidget {
  final BlogPostModel post;

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
              _buildTwitterDiscussButton(context, s),
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
      ).animate().fadeIn(duration: 600.ms, delay: 1000.ms).slideY(begin: 0.1, duration: 600.ms, delay: 1000.ms),
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

  /// Twitter Discuss Button
  Widget _buildTwitterDiscussButton(BuildContext context, DSizes s) {
    return _DiscussOnTwitterButton(post: widget.post);
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
            child: _SubmitCommentButton(onPressed: _submitComment, isSubmitting: _isSubmitting),
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
        return _CommentCard(
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

// Comment Card Widget
class _CommentCard extends StatelessWidget {
  final CommentModel comment;
  final VoidCallback onLike;
  final Function(String) onReplyLike;

  const _CommentCard({required this.comment, required this.onLike, required this.onReplyLike});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Container(
      margin: EdgeInsets.only(bottom: s.paddingMd),
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Comment Header
          _buildCommentHeader(context, s),
          SizedBox(height: s.paddingSm),

          // Comment Content
          _buildCommentContent(context, s),
          SizedBox(height: s.paddingMd),

          // Comment Actions
          _buildCommentActions(context, s),

          // Replies
          if (comment.replies.isNotEmpty) ...[SizedBox(height: s.paddingMd), _buildReplies(context, s)],
        ],
      ),
    );
  }

  Widget _buildCommentHeader(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Row(
      children: [
        // Avatar
        CircleAvatar(
          radius: 20,
          backgroundColor: DColors.primaryButton.withAlpha((255 * 0.2).round()),
          backgroundImage: AssetImage(comment.authorImage),
        ),
        SizedBox(width: s.paddingSm),

        // Author + Time
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.authorName,
                style: fonts.bodyMedium.rubik(fontWeight: FontWeight.bold, color: DColors.textPrimary),
              ),
              Text(
                _formatTimestamp(comment.timestamp),
                style: fonts.labelSmall.rubik(color: DColors.textSecondary, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCommentContent(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Text(comment.content, style: fonts.bodyMedium.rubik(color: DColors.textSecondary, height: 1.6));
  }

  Widget _buildCommentActions(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Row(
      children: [
        // Like Button
        _LikeButton(likes: comment.likes, onTap: onLike),
        SizedBox(width: s.paddingMd),

        // Reply Button (placeholder)
        Icon(Icons.reply_rounded, color: DColors.textSecondary, size: 18),
        SizedBox(width: 4),
        Text('Reply', style: fonts.labelSmall.rubik(color: DColors.textSecondary)),
      ],
    );
  }

  Widget _buildReplies(BuildContext context, DSizes s) {
    return Container(
      margin: EdgeInsets.only(left: s.paddingLg),
      padding: EdgeInsets.only(left: s.paddingMd),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: DColors.cardBorder, width: 2)),
      ),
      child: Column(
        children: comment.replies.map((reply) {
          return Container(
            margin: EdgeInsets.only(bottom: s.paddingSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Reply Header
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: DColors.primaryButton.withAlpha((255 * 0.2).round()),
                      backgroundImage: AssetImage(reply.authorImage),
                    ),
                    SizedBox(width: s.paddingSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reply.authorName,
                            style: context.fonts.bodySmall.rubik(
                              fontWeight: FontWeight.bold,
                              color: DColors.textPrimary,
                            ),
                          ),
                          Text(
                            _formatTimestamp(reply.timestamp),
                            style: context.fonts.labelSmall.rubik(color: DColors.textSecondary, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: s.paddingSm),

                // Reply Content
                Text(reply.content, style: context.fonts.bodySmall.rubik(color: DColors.textSecondary, height: 1.6)),
                SizedBox(height: s.paddingSm),

                // Reply Actions
                _LikeButton(likes: reply.likes, onTap: () => onReplyLike(reply.id)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

// Like Button Widget
class _LikeButton extends StatefulWidget {
  final int likes;
  final VoidCallback onTap;

  const _LikeButton({required this.likes, required this.onTap});

  @override
  State<_LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<_LikeButton> {
  bool _isHovered = false;
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() => _isLiked = !_isLiked);
          widget.onTap();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border_rounded,
              color: _isLiked ? Colors.red : (_isHovered ? DColors.primaryButton : DColors.textSecondary),
              size: 18,
            ),
            SizedBox(width: 4),
            Text(
              '${widget.likes}',
              style: fonts.labelSmall.rubik(
                color: _isLiked ? Colors.red : (_isHovered ? DColors.primaryButton : DColors.textSecondary),
                fontWeight: _isLiked ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Submit Comment Button
class _SubmitCommentButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isSubmitting;

  const _SubmitCommentButton({required this.onPressed, required this.isSubmitting});

  @override
  State<_SubmitCommentButton> createState() => _SubmitCommentButtonState();
}

class _SubmitCommentButtonState extends State<_SubmitCommentButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.isSubmitting ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: s.paddingLg, vertical: s.paddingMd),
          decoration: BoxDecoration(
            gradient: _isHovered ? const LinearGradient(colors: [DColors.primaryButton, Color(0xFFD4003D)]) : null,
            color: _isHovered ? null : DColors.primaryButton,
            borderRadius: BorderRadius.circular(s.borderRadiusMd),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: DColors.primaryButton.withAlpha((255 * 0.4).round()),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: widget.isSubmitting
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  'Post Comment',
                  style: fonts.bodyMedium.rubik(color: Colors.white, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}

// Discuss on Twitter Button (same as before)
class _DiscussOnTwitterButton extends StatefulWidget {
  final BlogPostModel post;

  const _DiscussOnTwitterButton({required this.post});

  @override
  State<_DiscussOnTwitterButton> createState() => _DiscussOnTwitterButtonState();
}

class _DiscussOnTwitterButtonState extends State<_DiscussOnTwitterButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _openTwitterDiscussion,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: s.paddingLg, vertical: s.paddingMd),
          decoration: BoxDecoration(
            gradient: _isHovered ? const LinearGradient(colors: [Color(0xFF1DA1F2), Color(0xFF0C85D0)]) : null,
            color: _isHovered ? null : const Color(0xFF1DA1F2).withAlpha((255 * 0.1).round()),
            borderRadius: BorderRadius.circular(s.borderRadiusMd),
            border: Border.all(color: _isHovered ? const Color(0xFF1DA1F2) : DColors.cardBorder, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.xTwitter, color: _isHovered ? Colors.white : const Color(0xFF1DA1F2), size: 20),
              SizedBox(width: s.paddingSm),
              Text(
                'Discuss on Twitter',
                style: fonts.bodyMedium.rubik(
                  color: _isHovered ? Colors.white : const Color(0xFF1DA1F2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openTwitterDiscussion() async {
    final tweetText = 'Just read "${widget.post.title}"\n\nThoughts:';
    final postUrl = 'https://yourwebsite.com/blog/${widget.post.id}';
    final twitterUrl =
        'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(tweetText)}&url=${Uri.encodeComponent(postUrl)}';

    final urlLauncher = UrlLauncherService();
    await urlLauncher.launchWebsite(twitterUrl);
  }
}
